require 'dotfiles_installer'

desc "install dotfiles into home directory"
task :install do
  DotfilesInstaller::Interactive.new(".", {
    :ignored_filenames => %w[README.rdoc Gemfile Gemfile.lock Rakefile]
  }).install
end

desc "uninstall dotfiles from home directory"
task :uninstall do
  DotfilesInstaller::Interactive.new(".", {
    :ignored_filenames => %w[README.rdoc Gemfile Gemfile.lock Rakefile]
  }).uninstall
end
