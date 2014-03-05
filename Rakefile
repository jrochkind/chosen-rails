#!/usr/bin/env rake
require 'bundler/gem_tasks'
require File.expand_path('../lib/chosen-rails/source_fetcher', __FILE__)

desc "Update with Chosen Library release files from github"
task 'update-chosen', 'github_repo', 'tag_name' do |task, args|
  SourceFetcher.new(args['github_repo'], args['tag_name']).fetch
  
end
