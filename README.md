Quacks like a Hash, but contains one additional method (commit) to help you merge changes from child hashes. I use it like Martin Fowler's Unit of Work pattern - http://martinfowler.com/eaaCatalog/unitOfWork.html

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
