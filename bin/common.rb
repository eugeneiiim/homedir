def unstaged_modified_files
  `git ls-files --modified --other --exclude-standard`.split("\n")
end

def git_do_on_starting_with(command, patterns, all_filepaths)
  toadd = all_filepaths.select do |f|
    filename = f.split('/').last

    matching_patterns = patterns.select do |pattern|
      filename.start_with?(pattern)
    end

    !matching_patterns.empty?
  end

  if toadd.empty?
    puts 'No matching files.'
  else
    cmd = "git #{command} #{toadd.join(' ')} ; git status"
    puts cmd
    system(cmd)
  end
end
