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
