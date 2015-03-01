require 'erb'

module HubotSlack
  class GithubAdapter
    class BodyBuilder
      class << self
        def pbi
          load("#{__dir__}/pbi_body.text.erb")
        end

        def release_pr
          load("#{__dir__}/release_pr_body.text.erb")
        end

        private

        def load(file_path)
          ERB.new(File.read(file_path)).result
        end
      end
    end
  end
end
