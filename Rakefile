require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'spec/rake/spectask'
 
desc 'Default: run specs'
task :default => :spe

spec_files = Rake::FileList["spec/**/*_spec.rb"]
 
desc "Run specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = spec_files
  t.spec_opts = ["-c"]
end
 
desc "Generate code coverage"
Spec::Rake::SpecTask.new(:coverage) do |t|
  t.spec_files = spec_files
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec,/var/lib/gems']
end
 
desc 'Generate documentation for the acts_as_fannable plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = 'ActsAsFannable'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end