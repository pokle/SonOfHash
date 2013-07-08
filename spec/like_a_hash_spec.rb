require 'sonofhash'

describe SonOfHash do
  
    subject { SonOfHash.new }

    it "indexed for unknown keys should result in nil" do
        subject[:key].should be_nil
    end

    it "indexed for an assigned key should return the assigned value" do
        subject[:key] = :value
        subject[:key].should be(:value)
    end

    it "indexed for a previoiusly deleted key should result in nil" do
        subject[:key] = :value
        subject.delete(:key)        
        subject[:key].should be_nil
    end
  
end