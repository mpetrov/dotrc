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


apt_get 'ruby1.8-dev', 'rake', 'vim-gnome', 'exuberant-ctags'
#brew 'mercurial'
#brew 'https://raw.github.com/Homebrew/homebrew-dupes/master/vim.rb'
#brew 'reattach-to-user-namespace'
#brew 'dos2unix', 'unrar', 'wget', 'par', 'git-extras', 'zsh', 'tmux'
#brew 'https://github.com/downloads/zolrath/wemux/wemux.rb'

submodule_update
link_rc '.vimrc' => 'rc.vim', '.vim' => 'vim'
link_rc '.zshrc' => 'rc.zsh'
link_rc '.muttrc' => 'rc.mutt'
link_rc '.tmux.conf' => 'conf.tmux'
link_rc '.Xresources' => '.Xresources'
link_rc '.screenrc' => 'rc.screen'
link_rc '.dir_colors' => 'submodules/dircolors-solarized/dircolors.256dark'

