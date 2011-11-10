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

print submodule_update
link_rc ".vimrc" => "rc.vim", ".vim" => "vim"
link_rc ".zshrc" => "rc.zsh"
link_rc ".screenrc" => "rc.screen"
install_command_t
