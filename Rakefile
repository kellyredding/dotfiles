require 'erb'

desc "install dotfiles into home directory"
task :install do
  replace_all = false
  dotfile_source_paths.each do |source_path|
    next if ignore_dotfile? source_path
    home_path = dotfile_home_path(source_path)
    if File.exist? File.expand_path(home_path)
      if File.identical? source_path, File.expand_path(home_path)
        puts "identical #{home_path}"
      elsif replace_all
        replace_dotfile(home_path, source_path)
      else
        print "overwrite #{home_path}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_dotfile(home_path, source_path)
        when 'y'
          replace_dotfile(home_path, source_path)
        when 'q'
          exit
        else
          puts "skipping #{home_path}"
        end
      end
    else
      link_dotfile(source_path, home_path)
    end
  end
end

desc "uninstall dotfiles from home directory"
task :uninstall do
  remove_all = false
  dotfile_source_paths.each do |source_path|
    next if ignore_dotfile? source_path
    home_path = dotfile_home_path(source_path)
    if File.exist? home_path
      if remove_all
        remove_dotfile(home_path)
      else
        print "remove #{home_path}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          remove_all = true
          remove_dotfile(home_path)
        when 'y'
          remove_dotfile(home_path)
        when 'q'
          exit
        else
          puts "skipping #{home_path}"
        end
      end
    end
  end
end


# Utilites

def replace_dotfile(home_path, source_path)
  remove_dotfile(home_path)
  link_dotfile(source_path, home_path)
end

def remove_dotfile(home_path)
  run_cmd %Q{rm -rf "#{File.expand_path(home_path)}"}
end

def link_dotfile(source_path, home_path)
  if source_path =~ /.erb$/
    puts "generating #{home_path}"

    make_dotfile_homedir(home_path)
    File.open(File.expand_path(home_path), 'w') do |new_file|
      new_file.write ERB.new(File.read(source_path)).result(binding)
    end
  else
    puts "linking #{home_path}"

    make_dotfile_homedir(home_path)
    run_cmd %Q{ln -s "#{source_path}" "#{File.expand_path(home_path)}"}
  end
end

def make_dotfile_homedir(home_path)
  home_dir = File.expand_path(File.dirname(home_path))
  run_cmd %Q{mkdir -p "#{home_dir}"} if !File.exist? home_dir
end




# def home_path(file)
#   File.join(ENV['HOME'], ".#{file_name(file)}")
# end
def dotfile_home_path(source_path)
  source_path.
    gsub(/^#{dotfiles_source_root}\//, "~/.").
    gsub(/.erb$/, '')
end

def dotfile_name(path)
  File.basename(path).sub('.erb', '')
end

def dotfile_source_paths
  Dir["#{dotfiles_source_root}/**/*"].select{|p| File.file?(p)}
end

def dotfiles_source_root
  File.expand_path(".")
end

def ignore_dotfile?(path)
  %w[Gemfile Gemfile.lock Rakefile README.rdoc].include? File.basename(path)
end




def empty_dir?(path)
  if File.exists?(d = File.dirname(path))
    Dir.entries(d).reject{|e| ['.', '..'].include?(e)}.empty?
  end
end

def run_cmd(cmd)
  puts "  => #{cmd}"
  system cmd
end
