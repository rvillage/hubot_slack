desc 'Create an issue of PBI'
task :create_pbi, ['repository', 'title'] do |task, args|
  puts HubotSlack::GithubAdapter.create_pbi(args.repository, args.title)
end
