#!/usr/bin/env ruby

# to install, add the following line to your .bash_profile or .bashrc
# complete -C path/to/gem_completion -o default gem

# Gem completion will return matching gem cmds/gems given typed text. This way
# you can auto-complete cmds and the gems to operate on as you are typing them
# by hitting [tab] or [tab][tab]
# This also caches the gems for optimium speed

class GemCompletion
  GEM_DIR = `gem env gemdir`.strip.freeze
  GEMS_DIR = "#{GEM_DIR}/gems".freeze
  GEM_LIST_CACHE = "#{GEM_DIR}/.gem_list~".freeze

  def initialize(command)
    @command = command
  end

  def matches
    if typed_cmd.nil? || !command_list.include?(typed_cmd)
      matching(command_list, typed_cmd || '')
    elsif typed_cmd_arg.nil? || !gem_list.include?(typed_cmd_arg)
      matching(gem_list, typed_cmd_arg || '')
    else
      []
    end
  end

  protected

  # the list of commands to complete on (customize to suite your needs)
  def command_list
    @command_list ||= [
      'cleanup', 'contents', 'install', 'list', 'open', 'push', 'query', 'read',
      'specification', 'uninstall', 'unpack', 'update', 'which'
    ]
  end

  # the list of gems to complete on (from either cache or gem env gemdir)
  def gem_list
    @gem_list ||= cache_current? ? gem_list_from_cache : gem_list_from_env
  end

  def cache_current?
    File.exist?(GEM_LIST_CACHE) && File.mtime(GEM_LIST_CACHE) >= File.mtime(GEMS_DIR)
  end

  def gem_list_from_cache
    IO.read(GEM_LIST_CACHE).split
  end

  # list out the gemdir contents and strip off version info
  def gem_list_from_env
    gem_list = `ls #{GEMS_DIR} | sed -E "s/-[0-9].+$//g"`.split.uniq
    File.open(GEM_LIST_CACHE, 'w') { |f| f.write gem_list.join("\n") }
    gem_list
  end

  private

  def typed
    @command[/\s(.+?)$/, 1] || ''
  end

  def typed_parts
    @typed_parts ||= typed.split(" ")
  end

  def typed_cmd
    @typed_cmd ||= typed_parts[0]
  end

  def typed_cmd_arg
    @typed_cmd_arg ||= if command_list.include?(typed_cmd)
      typed_parts[1]
    end
  end

  def matching(things, on)
    things.select {|thing| thing[0, on.length] == on}
  end

end

puts GemCompletion.new(ENV["COMP_LINE"]).matches
exit 0
