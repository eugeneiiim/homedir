def unstaged_modified_files
  `git ls-files --modified --other --exclude-standard`.split("\n")
end

def staged_files
  `git diff --cached --name-only`.split("\n")
end

def all_git_files
  `git ls-tree -r --name-only HEAD`
end

class Array
  def exists?(&fn)
    !self.select(&fn).empty?
  end
end

def do_on_starting_with(command, patterns, all_filepaths)
  toadd = all_filepaths.select do |filepath|
    filename = filepath.split('/').last
    patterns.exists? { |pattern| filename.start_with?(pattern) }
  end

  if toadd.empty?
    puts 'No matching files.'
  else
    cmd = "#{command} #{toadd.join(' ')} ; git status"
    puts cmd
    system(cmd)
  end
end
