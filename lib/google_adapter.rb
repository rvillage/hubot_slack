require 'google/api_client'
require 'holidays'
require './lib/google_adapter/body_builder'

module HubotSlack
  class GoogleAdapter
    GOOGLE_API_KEY         = ENV['GOOGLE_API_KEY']
    GOOGLE_API_ACCOUNT     = ENV['GOOGLE_API_ACCOUNT']
    GOOGLE_API_CALENDAR_ID = ENV['GOOGLE_API_CALENDAR_ID']
    CALENDAR_MARGIN        = 1.minutes
    TIME_INTERVAL          = 30.minutes

    class << self
      def holiday?(current_date = Date.today)
        (current_date.saturday? || current_date.sunday? || current_date.holiday?(:jp)) ? true : false
      end

      def ding_dong(current_time = DateTime.now)
        start_time = Time.at((current_time.to_f / TIME_INTERVAL).round * TIME_INTERVAL)
        end_time   = start_time.since(CALENDAR_MARGIN)

        new.schedules(start_time, end_time).each_with_object([]) {|schedule, messages|
          next if schedule.transparency == 'transparent'

          messages << BodyBuilder.time_table(
                        schedule.summary,
                        schedule.description.try(:chomp),
                        schedule.location,
                        schedule.start.dateTime.strftime('%-H:%M'),
                        schedule.end.dateTime.strftime('%-H:%M'))
        }.join("\n")
      end
    end

    def initialize
      @client = Google::APIClient.new(application_name: 'hubot-slack')
      @client.authorization = Signet::OAuth2::Client.new(
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
        audience:             'https://accounts.google.com/o/oauth2/token',
        scope:                'https://www.googleapis.com/auth/calendar.readonly',
        issuer:               GOOGLE_API_ACCOUNT,
        signing_key:          OpenSSL::PKey::RSA.new(ENV['GOOGLE_API_KEY'])
      )
      @client.authorization.fetch_access_token!
      @calendar = @client.discovered_api('calendar', 'v3')

      nil
    end

    def schedules(start_time, end_time)
      params = {calendarId:   GOOGLE_API_CALENDAR_ID,
                orderBy:      'startTime',
                timeMin:      start_time.iso8601,
                timeMax:      end_time.iso8601,
                singleEvents: 'True'}
      result = @client.execute(api_method: @calendar.events.list, parameters: params)
      result.data.items
    end
  end
end
