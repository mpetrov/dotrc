#!/usr/bin/env ruby

BASE_DIR = File.dirname(__FILE__)

require 'rbconfig'


def mac?()
  !!Config::CONFIG['target_os'][/darwin/]
end

def linux?()
  !!Config::CONFIG['target_os'][/linux/]
end



def link_rc(paths)
  paths.each_pair { |file, points_to|
    points_to = File.expand_path "#{BASE_DIR}/#{points_to}"
    file = File.expand_path "~/#{file}"
    if File.exists?(file) && !File.identical?(file, points_to)  then 
      if File.symlink? file then
        File.unlink file
      elsif File.directory? file then
        Dir.delete file
      else
        File.delete file
      end
    end
    if not File.exists?(file) then 
      puts "Symlinked #{file} -> #{points_to}"
      begin
        File.symlink points_to, file
      rescue
        #File.delete points_to, file
        #File.symlink points_to, file
      end
    end
  }
end

def submodule_update 
  Dir.chdir BASE_DIR do
     puts "Updating submodules...\n"
    `git submodule init 2>&1` && $?.exitstatus == 0 or
      return "ERROR: could not git submodule init\n"
    `git submodule update 2>&1` && $?.exitstatus == 0 or
      return "ERROR: could not git submodule update\n"
     puts "Updated submodules..."
  end
  ""
end


def apt_get(*args)
  return unless linux?
    puts "apt-get install #{args.join ' '}"
end


def brew(*args)
  return unless mac?
  list = `brew list`.split
  to_brew = {}
  args.each do |prog|
    path = ''
    if prog.kind_of? Hash
      prog.each_pair { |key, value|
        to_brew[key] = value
      }
    else
      to_brew[prog] = nil
    end
  end 
  to_brew.each_pair {|name, path|
    cmd = "brew install #{name}"
    cmd = "#{cmd} --HEAD #{path}" if path
    if not list.include? name
      puts "Installing #{name}"
      `#{cmd}`
    end
  }

end

def install_mercurial
  return unless mac?
  if not File.exists? '/usr/local/bin/hg'
      if `easy_install mercurial 2>&1` && $?.exitstatus == 0 then
        puts "Installed Mercurial"
      else
        puts "ERROR: Could not install Mercurial!"
      end
  end
end

install_mercurial
apt_get 'ruby1.8-dev', 'rake', 'vim-gnome', 'exuberant-ctags'
brew 'vim' =>
  'https://raw.github.com/adamv/homebrew-alt/master/duplicates/vim.rb'
brew 'screen' =>
  'https://raw.github.com/adamv/homebrew-alt/master/duplicates/screen.rb'
brew 'reattach-to-user-namespace' =>
  'https://raw.github.com/phinze/homebrew/tmux-macosx-pasteboard/Library/Formula/reattach-to-user-namespace.rb'

brew 'dos2unix', 'unrar', 'wget', 'par', 'git-extras', 'zsh', 'tmux'

submodule_update
link_rc '.vimrc' => 'rc.vim', '.vim' => 'vim'
link_rc '.zshrc' => 'rc.zsh'
link_rc '.tmux.conf' => 'conf.tmux'
link_rc '.screenrc' => 'rc.screen'
