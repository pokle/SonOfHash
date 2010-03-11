Quacks like a Hash, but contains one additional method (commit) to help you merge changes from child hashes.

Typical usage:

	require 'rubygems'
	require 'sonofhash'
	
	parent = SonOfHash.new
	child = parent.new_child
	
	parent['name'] = 'Moondublin'
	puts child['name']            # Moondublin
	
	child['name'] = 'Lugrat'
	puts parent['name']           # Moondublin
	
	child.commit
	puts parent['name']           # Lugrat
