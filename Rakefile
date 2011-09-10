require 'erb'

desc "install dotfiles into home directory"
task :install do
  replace_all = false
  Dir['*'].each do |file|

    next if ignored_files.include? file

    if File.exist?(home_path(file))
      if File.identical? file, home_path(file)
        puts "identical ~/.#{file_name(file)}"
      elsif replace_all
        replace_dotfile(file)
      else
        print "overwrite ~/.#{file_name(file)}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_dotfile(file)
        when 'y'
          replace_dotfile(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file_name(file)}"
        end
      end
    else
      link_dotfile(file)
    end

  end
end

desc "uninstall dotfiles from home directory"
task :uninstall do
  remove_all = false
  Dir['*'].each do |file|
    next if ignored_files.include? file

    if File.exist?(home_path(file))
      if remove_all
        remove_dotfile(file)
      else
        print "remove ~/.#{file_name(file)}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          remove_all = true
          remove_dotfile(file)
        when 'y'
          remove_dotfile(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file_name(file)}"
        end
      end
    end

  end
end


# Utilites

def replace_dotfile(file)
  remove_dotfile(file)
  link_dotfile(file)
end

def remove_dotfile(file)
  run_cmd %Q{rm -rf "$HOME/.#{file_name(file)}"}
end

def link_dotfile(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file_name(file)}"
    File.open(File.join(ENV['HOME'], ".#{file_name(file)}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/.#{file}"
    run_cmd %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end
end

def home_path(file)
  File.join(ENV['HOME'], ".#{file_name(file)}")
end

def file_name(file)
  file.sub('.erb', '')
end

def ignored_files
  %w[Gemfile Gemfile.lock Rakefile README.rdoc]
end

def run_cmd(cmd)
  puts "  => #{cmd}"
  system cmd
end
