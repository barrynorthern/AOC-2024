# frozen_string_literal: true

# Rakefile
require 'rake/testtask'
require 'rubocop/rake_task'

# Define a task to run RuboCop
RuboCop::RakeTask.new(:rubocop) do |task|
  task.options = ['-A']
end

# Allows me to run all the tests in the test folder
# lib and test are autoloaded into the path, anything else
# would need to go in t.libs!
Rake::TestTask.new do |t|
  t.test_files = FileList['**/test/*_test.rb']
end

task default: :test
task tidy: %i[rubocop test]
