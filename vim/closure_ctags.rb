#!/usr/bin/env ruby



$data=<<TLIST
!_TAG_FILE_FORMAT       2       /extended format/
!_TAG_FILE_SORTED       0       /0=unsorted, 1=sorted, 2=foldcase/
!_TAG_PROGRAM_AUTHOR    Martin Petrov  /martin@martinpetrov.com/
!_TAG_PROGRAM_NAME      closure_tags //
!_TAG_PROGRAM_URL       http://github.com/mpetrov      /GitHub/
!_TAG_PROGRAM_VERSION   0.01     //
TLIST
$lines = []


#p ARGV

def add_file(file_name)
  File.open(file_name){ |file|
    #p file.read
    file.readlines.each_with_index{ |line, index|

      line.scan(/^(([A-Za-z._]+)\s*=.*)$/).collect{ |fun|
        regexp = "^#{fun.first}$"#Regexp.escape( fun.first )
        fun_name = fun.last.split('.')
        if line[/function/]
          $lines << "#{fun_name.last}\t#{file_name}\t/#{regexp}/;\"\tf\tlineno:#{index+1}\tnamespace:#{fun_name[0..-2].join('.')}\n"
        else
          $lines << "#{fun_name.last}\t#{file_name}\t/#{regexp}/;\"\to\tlineno:#{index+1}\tnamespace:#{fun_name[0..-2].join('.')}\n"
        end
      }
    }


  }
end

$outfile = "tags"
f_flag  = ARGV.index('-f')
if f_flag then
  ARGV.delete '-f' 
  $outfile = ARGV[f_flag]
  ARGV.delete $outfile
end


ARGV.each{ |f|
  if f[/^--/]
    nil
  elsif File.directory? f
    Dir.glob("#{f}/**/*.js"){ |file_name|
        add_file file_name
    }
  else
    add_file f
  end
}

$data = $data+$lines.sort.join('')

if $outfile == '-' then
  print $data
else
  File.open($outfile,'w'){|file|
    file.print $data
  }
end

#exit 1
