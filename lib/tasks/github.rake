desc 'Create an issue of PBI'
task :create_pbi, ['repository', 'title'] do |task, args|
  puts HubotSlack::GithubAdapter.create_pbi(args.repository, args.title)
end

desc 'Create a pull request of ReleaseBranch'
task :create_release_pr, ['repository', 'title'] do |task, args|
  puts HubotSlack::GithubAdapter.create_release_pr(args.repository, args.title)
end

desc 'Create a tag of ReleaseTag'
task :create_release_tag, ['repositories', 'tag', 'message'] do |task, args|
  args.repositories.split(',').each do |repository|
    puts HubotSlack::GithubAdapter.create_release_tag(repository, args.tag, args.message)
  end
end
