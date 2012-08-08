#! /usr/bin/ruby

i = 1

loop do
  cmd = "git show HEAD~#{i}"
  puts cmd
  system(cmd)
  i += 1
  gets
end
