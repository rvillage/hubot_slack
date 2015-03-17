desc 'Notify google calendar'
task :notify_event do
  exit if HubotSlack::GoogleAdapter.holiday?

  HubotSlack::Task.delay!

  notify_message = HubotSlack::GoogleAdapter.ding_dong
  puts notify_message if notify_message.present?
end

module HubotSlack
  class Task
    def self.delay!(current_time = Time.now)
      wake_up_time = (current_time.to_f / 30.minutes).round * 30.minutes - 3.minutes
      sleep(wake_up_time - current_time.to_i)
    end
  end
end
