require 'sonofhash'

describe SonOfHash do
  
  subject { SonOfHash.new }
  
  it "can create a son that can read its keys and values" do
    subject['gun'] = 'shona'
    son = subject.new_child
    son['gun'].should == 'shona'
  end
  
  its "values are independent of modifications to its children" do
    
    subject['twinkle'] = 'star'
    child = subject.new_child
    
    child['binkle'] = 'btar'
    
    subject['binkle'].should be_nil
  
  end
  
  its "child can merge changes back to it" do
    child = subject.new_child

    subject['book1'] = 'Domain Driven Design'
    child['book1'] = 'Programming in Scala'
    child['book2'] = 'Metaprogramming in Ruby'

    # Before commit
    subject['book1'].should == 'Domain Driven Design'
    subject['book2'].should == nil
    child['book1'].should == 'Programming in Scala'
    child['book2'].should == 'Metaprogramming in Ruby'

    child.commit

    # After commit both subject and child should be the same
    subject['book1'].should == 'Programming in Scala'
    subject['book2'].should == 'Metaprogramming in Ruby'
    child['book1'].should == 'Programming in Scala'
    child['book2'].should == 'Metaprogramming in Ruby'
  end
  
 
  its "child can merge deletions back to it" do
    child = subject.new_child
    
    subject['colour'] = 'color'
    child.delete('colour')
    
    # Before commit
    subject['colour'].should == 'color'
    child.member?('colour').should == false
    child['colour'].should == nil
    
    child.commit
    
    # After commit
    subject.member?('colour').should == false
    child.member?('colour').should == false
    
  end

  it "only commits changes once" do

    child = subject.new_child
    child[:toy] = :bear

    child.commit # 1st commit

    subject[:toy] = :cabbage

    child.commit # 2nd commit shouldn't change anything

    subject[:toy].should eq :cabbage

  end

  it "only deletes changes once" do

    subject[:toy] = :cabbage

    child = subject.new_child
    child.delete :toy

    child.commit # 1st commit
    subject[:toy].should be_nil

    subject[:toy] = :plantain
    child.commit # 2nd commit shouldn't change anything
    subject[:toy].should eq :plantain


  end
  
end