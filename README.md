Quacks like a Hash, but contains one additional method (commit) to help you merge changes from child hashes. I use it like Martin Fowler's Unit of Work pattern - http://martinfowler.com/eaaCatalog/unitOfWork.html

[![Circle CI Build Status](https://circleci.com/gh/pokle/SonOfHash.png?circle-token=6b4b88a0d80e58c518f0cbdd364e5e279f8c036b)](https://circleci.com/gh/pokle/SonOfHash)
[![Build Status](https://travis-ci.org/pokle/SonOfHash.png?branch=master)](https://travis-ci.org/pokle/SonOfHash)

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
