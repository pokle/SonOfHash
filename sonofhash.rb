require 'set'

class SonOfHash

  def initialize(parent={})
    @store = {}
    @deletions = Set.new
    @parent = parent
  end

  def new_child
    return SonOfHash.new(self)
  end
  
  def [](key)
    return @store[key] if @store.has_key?(key)
    @parent[key]
  end
  
  def []=(key, value)
    @store[key] = value
  end
  
  def delete(key)
    @deletions.add(key)
    return @store.delete(key)
  end
  
  def commit
    @store.each do |key, value|
      @parent[key] = value
    end

  end
  
end