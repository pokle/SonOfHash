require 'set'

# Quacks like a Hash, but contains one additional method - commit()
#
# Typical usage:
#
#   require 'rubygems'
#   require 'sonofhash'
#
#   parent = SonOfHash.new
#   child = parent.new_child
#
#   parent['name'] = 'Moondublin'
#   puts child['name']            # Moondublin
#   
#   child['name'] = 'Lugrat'
#   puts parent['name']           # Moondublin
#
#   child.commit
#   puts parent['name']           # Lugrat
#
class SonOfHash

  def initialize(parent={})
    @store = {}
    @deletions = Set.new
    @parent = parent
  end

  # Create a new child of this object. This is the primary way to
  # record changes.
  def new_child
    return SonOfHash.new(self)
  end
  
  def [](key)
    return nil if @deletions.member?(key)
    return @store[key] if @store.has_key?(key)
    @parent[key]
  end
  
  def []=(key, value)
    @store[key] = value
  end
  
  def has_key?(key)
    return member?(key)
  end
  
  def member?(key)
    return false if @deletions.member?(key);
    return @store.member?(key) || @parent.member?(key)
  end
  
  def delete(key)
    @deletions.add(key)
    return @store.delete(key)
  end
  
  # Merges the changes of this object into its parent
  def commit
    @store.each {|key, value| @parent[key] = value}
    @deletions.each {|key| @parent.delete(key)}
    
    # I want to clear the state here, but I don't know
    # a good spec for it yet
    # @store.clear
    # @deletions.clear
  end
  
end