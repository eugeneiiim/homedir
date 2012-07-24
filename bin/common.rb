def unstaged_modified_files
  `git ls-files --modified --other --exclude-standard`.split("\n")
end

def git_do_on_starting_with(command, pattern, all_filenames)
  toadd = all_filenames.select {|f| f.split('/').last.start_with?(pattern) }
  if toadd.empty?
    puts 'No matching files.'
  else
    cmd = "git #{command} #{toadd.join(' ')} ; git status"
    puts cmd
    system(cmd)
  end
end
