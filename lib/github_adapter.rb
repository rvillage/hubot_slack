require 'octokit'
require './lib/github_adapter/body_builder'

module HubotSlack
  Octokit.configure do |config|
    config.access_token = ENV['GITHUB_TOKEN']
  end

  class GithubAdapter
    class << self
      def create_pbi(repository, title)
        Octokit.create_issue(prefixed_repo(repository), title, BodyBuilder.pbi, labels: 'PBI').html_url
      end

      def create_release_pr(repository, title)
        res = Octokit.create_pull_request(prefixed_repo(repository), 'master', 'develop', title, BodyBuilder.release_pr)
        add_label(repository, res.number, 'リリースブランチ')
        res.html_url
      end

      def create_release_tag(repository, tag, message)
        tagger            = Octokit.user
        master_newest_sha = Octokit.commits(prefixed_repo(repository), 'master', page: :first, per_page: 1).first.sha
        tag_sha           = Octokit.create_tag(prefixed_repo(repository), tag, message, master_newest_sha, 'commit', tagger.name, tagger.email, DateTime.now).sha
        Octokit.create_ref(prefixed_repo(repository), "tags/#{tag}", tag_sha)
        Octokit.release_for_tag(prefixed_repo(repository), tag).html_url
      end

      private

      def prefixed_repo(repository)
        "rvillage/#{repository}"
      end

      def add_label(repository, issue_number, label)
        Octokit.update_issue(prefixed_repo(repository), issue_number, labels: [label])
      end
    end
  end
end
