require 'octokit'
require 'erb'

module HubotSlack
  Octokit.configure do |config|
    config.access_token = ENV['GITHUB_TOKEN']
  end

  class GithubAdapter
    class << self
      def create_pbi(repository, title)
        Octokit.create_issue("rvillage/#{repository}", title, pbi_body, labels: 'PBI').html_url
      end

      private

      def pbi_body
        ERB.new(File.read("#{__dir__}/github_adapter/pbi_body.text.erb")).result
      end
    end
  end
end
