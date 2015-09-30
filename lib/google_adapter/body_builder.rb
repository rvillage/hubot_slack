require 'erb'

module HubotSlack
  class GoogleAdapter
    class BodyBuilder
      class << self
        def time_table(title, member, location, start_time, end_time)
          load("#{__dir__}/time_table_body.text.erb", binding)
        end

        private

        def load(file_path, binding)
          ERB.new(File.read(file_path), nil, '-').result(binding)
        end
      end
    end
  end
end
