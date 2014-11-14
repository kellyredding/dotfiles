# My dotfiles

These are my personal dotfiles.  They setup an environment the way I like it.

## Installation

Run these commands

```sh
git clone git://github.com/kellyredding/dotfiles ~/.dotfiles
cd ~/.dotfiles
gem install bundler
bundle
bundle exec rake install
```

Now, add this to your `~/.bash_profile` or `~/.bashrc` or whatever:

```bash
# source in dotfiles
if [ -f ~/.bash_dotfiles.sh ]; then
  . ~/.bash_dotfiles.sh
fi
```

## Environment

I am running on Mac OS X, bash.

## Features

* aliases
* fancy ps1 with pwd, ruby**, and git info
* configs for git, gem, irb, pry, rb**, etc...
* git completion
* gem completion**
* rake completion
* cap completion (TODO)

** requires install of [ruby-build and rb](https://github.com/redding/rb)

## Other configuration settings

These dotfiles will never tamper with your main settings files (`~/.bash_profile` or `~/.bashrc` or whatever).  If you want additional settings that need to be secure, private, or specific to one system, add or source them in your settings file as you would normally.  These dotfiles are just sourced alongside them.

## Enjoy!

I modify these at will without notice so things might get broken.  Use accordingly and don't blame me when stuff breaks.  It's probably best to fork this and install using your fork.

## Contributing

Feel free to submit any pull requests suggesting cool new settings or things I may not be aware of.  Please don't submit anything to the issues tracker - I most likely will ignore it.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
