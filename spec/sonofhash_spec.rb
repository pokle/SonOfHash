require 'sonofhash'
#require 'ruby-debug'

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

    parent['book1'] = 'Domain Driven Design'
    child['book1'] = 'Programming in Scala'
    child['book2'] = 'Metaprogramming in Ruby'

    # Before commit
    parent['book1'].should == 'Domain Driven Design'
    parent['book2'].should == nil
    child['book1'].should == 'Programming in Scala'
    child['book2'].should == 'Metaprogramming in Ruby'

    child.commit

    # After commit both parent and child should be the same
    parent['book1'].should == 'Programming in Scala'
    parent['book2'].should == 'Metaprogramming in Ruby'
    child['book1'].should == 'Programming in Scala'
    child['book2'].should == 'Metaprogramming in Ruby'
  end
  
 
  it "can merge deletions with its parent" do
    parent = SonOfHash.new
    child = parent.new_child
    
    parent['colour'] = 'color'
    child.delete('colour')
    
    # Before commit
    parent['colour'].should == 'color'
    child.member?('colour').should == false
    child['colour'].should == nil
    
    child.commit
    
    # After commit
    parent.member?('colour').should == false
    child.member?('colour').should == false
    
  end
  
  
end