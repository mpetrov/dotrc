#!/usr/bin/env ruby

BASE_DIR = File.dirname(__FILE__)

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
      File.symlink points_to, file
    end
  }
end

def submodule_update 
  Dir.chdir BASE_DIR do
    `git submodule init 2>&1` && $?.exitstatus == 0 or
      return "ERROR: could not git submodule init\n"
    `git submodule update 2>&1` && $?.exitstatus == 0 or
      return "ERROR: could not git submodule update\n"
  end
  ""
end

def install_command_t()
  Dir.chdir "#{BASE_DIR}/vim/bundle/vim-command-t" do
    if `rake make 2>&1` && $?.exitstatus == 0 then
      puts "Installed Command-T"
    else
      puts "ERROR: Command-T install exited with an error code!"
    end
  end
end

def apt_get(*args)
  if not File.exists? '/usr/local/bin/hg'
    puts `apt-get intall #{args.join ' '}`
  end 
end


def brew(*args)
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
  if not File.exists? '/usr/local/bin/hg'
      if `easy_install mercurial 2>&1` && $?.exitstatus == 0 then
        puts "Installed Mercurial"
      else
        puts "ERROR: Could not install Mercurial!"
      end
  end
end

install_mercurial
apt_get 'ruby1.8-dev', 'rake', 'vim-gnome'
brew 'vim' => 'https://raw.github.com/adamv/homebrew-alt/master/duplicates/vim.rb'
brew 'screen' => 'https://raw.github.com/adamv/homebrew-alt/master/duplicates/screen.rb'
brew 'dos2unix', 'unrar', 'wget', 'par', 'git-extras', 'zsh'

submodule_update
link_rc '.vimrc' => 'rc.vim', '.vim' => 'vim'
link_rc '.zshrc' => 'rc.zsh'
link_rc '.screenrc' => 'rc.screen'
install_command_t
