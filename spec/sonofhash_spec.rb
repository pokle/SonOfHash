require 'sonofhash'
require 'ruby-debug'

describe SonOfHash do
  
  it "supports the [] and []= operators" do
    son = SonOfHash.new
    son['owl'].should == nil

    son['owl'] = 'hoot'
    son['owl'].should == 'hoot'

    son.delete('owl').should == 'hoot'
    son['owl'].should == nil
  end
  
  it "can create a son that can read the same keys" do
    son = SonOfHash.new
    son['gun'] = 'shona'
    
    grandson = son.new_child
    grandson['gun'].should == 'shona'
  end
  
  it "can assign values to children that don't affect the parent" do
    parent = SonOfHash.new
    parent['twinkle'] = 'star'
    child = parent.new_child
    
    child['binkle'] = 'btar'
    
    parent['binkle'].should == nil
  
  end
  
  it "can merge new keys with its parent" do
    parent = SonOfHash.new
    child = parent.new_child

    child['key'] = 'value'

    parent['key'].should == nil
    child['key'].should == 'value'

    child.commit

    parent['key'].should == 'value'
    child['key'].should == 'value'
  end
  
  it "can merge value changes with its parent" do
    
  end

  it "can merge deletions with its parent" do
    
  end
  
  
end