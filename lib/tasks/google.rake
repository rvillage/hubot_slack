desc 'Notify google calendar'
task :notify_event do
  exit if HubotSlack::GoogleAdapter.holiday?

  notify_message = HubotSlack::GoogleAdapter.ding_dong
  puts notify_message if notify_message.present?
end
