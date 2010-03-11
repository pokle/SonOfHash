require 'sonofhash'
require 'ruby-debug'

describe SonOfHash do
  
  it "supports the [] operator" do
    son = SonOfHash.new
    son['owl'].should == nil

    son['owl'] = 'hoot'
    son['owl'].should == 'hoot'

    son.delete('owl').should == 'hoot'
    son['owl'].should == nil
  end
  
  it "can create a son that can read the same keys" do
    #sdebugger
    son = SonOfHash.new
    son['gun'] = 'shona'
    
    grandson = son.new_child
    grandson['gun'].should == 'shona'
    
  end
  
end