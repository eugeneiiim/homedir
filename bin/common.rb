def unstaged_modified_files
  `git ls-files --modified --other --exclude-standard`.split("\n")
end

class Array
  def exists?(&fn)
    !self.select(&fn).empty?
  end
end

def git_do_on_starting_with(command, patterns, all_filepaths)
  toadd = all_filepaths.select do |filepath|
    filename = filepath.split('/').last
    patterns.exists? { |pattern| filename.start_with?(pattern) }
  end

  if toadd.empty?
    puts 'No matching files.'
  else
    cmd = "git #{command} #{toadd.join(' ')} ; git status"
    puts cmd
    system(cmd)
  end
end
