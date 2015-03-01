require 'octokit'
require 'erb'

module HubotSlack
  Octokit.configure do |config|
    config.access_token = ENV['GITHUB_TOKEN']
  end

  class GithubAdapter
    class << self
      def create_pbi(repository, title)
        Octokit.create_issue(prefixed_repo(repository), title, pbi_body, labels: 'PBI').html_url
      end

      def create_release_pr(repository, title)
        res = Octokit.create_pull_request(prefixed_repo(repository), 'master', 'develop', title, release_pr_body)
        add_label(repository, res.number, 'リリースブランチ')

        res.html_url
      end

      private

      def prefixed_repo(repository)
        "rvillage/#{repository}"
      end

      def build_body(file_path)
        ERB.new(File.read(file_path)).result
      end

      def pbi_body
        build_body("#{__dir__}/github_adapter/pbi_body.text.erb")
      end

      def release_pr_body
        build_body("#{__dir__}/github_adapter/release_pr_body.text.erb")
      end

      def add_label(repository, issue_number, label)
        Octokit.update_issue(prefixed_repo(repository), issue_number, labels: [label])
      end
    end
  end
end
