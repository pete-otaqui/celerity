require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Span" do
  
  before :all do
    @ie = IE.new
    add_spec_checker(@ie)    
  end
  
  before :each do
    @ie.goto(TEST_HOST + "/non_control_elements.html")
  end

  # Exists method
  describe "#exist?" do
    it "should return true if the 'p' exists" do
      @ie.span(:id, "lead").should exist
      @ie.span(:id, /lead/).should exist
      @ie.span(:text, "Dubito, ergo cogito, ergo sum.").should exist
      @ie.span(:text, /Dubito, ergo cogito, ergo sum/).should exist
      @ie.span(:class, "lead").should exist
      @ie.span(:class, /lead/).should exist
      @ie.span(:index, 1).should exist
      @ie.span(:xpath, "//span[@id='lead']").should exist
    end
    it "should return false if the 'p' doesn't exist" do
      @ie.span(:id, "no_such_id").should_not exist
      @ie.span(:id, /no_such_id/).should_not exist
      @ie.span(:text, "no_such_text").should_not exist
      @ie.span(:text, /no_such_text/).should_not exist
      @ie.span(:class, "no_such_class").should_not exist
      @ie.span(:class, /no_such_class/).should_not exist
      @ie.span(:index, 1337).should_not exist
      @ie.span(:xpath, "//span[@id='no_such_id']").should_not exist
    end
    it "should raise ArgumentError when what argument is invalid" do
      lambda { @ie.span(:id, 3.14).exists? }.should raise_error(ArgumentError)
    end
    it "should raise MissingWayOfFindingObjectException when how argument is invalid" do
      lambda { @ie.span(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end
  
  # Attribute methods
  describe "#class_name" do
    it "should return the class attribute" do
      @ie.span(:index, 1).class_name.should == 'lead'
    end
    it "should return an empty string if the element exists and the attribute doesn't" do
      @ie.span(:index, 3).class_name.should == ''
    end
    it "should raise UnknownObjectException if the span doesn't exist" do
      lambda { @ie.span(:id, 'no_such_id').class_name }.should raise_error(UnknownObjectException)
    end
  end
  
  describe "#id" do
    it "should return the id attribute" do
      @ie.span(:index, 1).id.should == "lead"
    end
    it "should return an empty string if the element exists and the attribute doesn't" do
      @ie.span(:index, 3).id.should == ''
    end
    it "should raise UnknownObjectException if the span doesn't exist" do
      lambda { @ie.span(:id, "no_such_id").id }.should raise_error(UnknownObjectException)
      lambda { @ie.span(:index, 1337).id }.should raise_error(UnknownObjectException)
    end
  end
  
  describe "#name" do
    it "should return the name attribute" do
      @ie.span(:index, 2).name.should == "invalid_attribute"
    end
    it "should return an empty string if the element exists and the attribute doesn't" do
      @ie.span(:index, 3).name.should == ''
    end
    it "should raise UnknownObjectException if the span doesn't exist" do
      lambda { @ie.span(:id, "no_such_id").name }.should raise_error(UnknownObjectException)
      lambda { @ie.span(:index, 1337).name }.should raise_error(UnknownObjectException)
    end
  end
  
  describe "#title" do
    it "should return the title attribute" do
      @ie.span(:index, 1).title.should == 'Lorem ipsum'
    end
    it "should return an empty string if the element exists and the attribute doesn't" do
      @ie.span(:index, 3).title.should == ''
    end
    it "should raise UnknownObjectException if the p doesn't exist" do
      lambda { @ie.span(:id, 'no_such_id').title }.should raise_error( UnknownObjectException)
      lambda { @ie.span(:xpath, "//span[@id='no_such_id']").title }.should raise_error( UnknownObjectException)
    end
  end
  
  describe "#text" do
    it "should return the text of the p" do
      @ie.span(:index, 2).text.should == 'Sed pretium metus et quam. Nullam odio dolor, vestibulum non, tempor ut, vehicula sed, sapien. Vestibulum placerat ligula at quam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.'
    end
    it "should return an empty string if the element doesn't contain any text" do
      @ie.span(:index, 5).text.should == ''
    end
    it "should raise UnknownObjectException if the p doesn't exist" do
      lambda { @ie.span(:id, 'no_such_id').text }.should raise_error( UnknownObjectException)
      lambda { @ie.span(:xpath , "//span[@id='no_such_id']").text }.should raise_error( UnknownObjectException)
    end
  end
  
  describe "#value" do
    it "should return the value attribute" do
      @ie.span(:index, 2).value.should == "invalid_attribute"
    end
    it "should return an empty string if the element exists and the attribute doesn't" do
      @ie.span(:index, 3).value.should == ''
    end
    it "should raise UnknownObjectException if the p doesn't exist" do
      lambda { @ie.span(:id , "no_such_id").value }.should raise_error(UnknownObjectException)
      lambda { @ie.span(:index , 1337).value }.should raise_error(UnknownObjectException)
    end
  end

  # Other
  describe "#click" do
    it "should fire events" do
      @ie.span(:id, 'footer').text.include?('Javascript').should_not be_true
      @ie.span(:id, 'footer').click
      @ie.span(:id, 'footer').text.include?('Javascript').should be_true
    end
    it "should raise UnknownObjectException if the span doesn't exist" do
      lambda { @ie.span(:id, "no_such_id").click }.should raise_error(UnknownObjectException)
      lambda { @ie.span(:title, "no_such_title").click }.should raise_error(UnknownObjectException)
    end
  end
  
  describe "#to_s" do
    it "should return a human readable representation of the element" do
      @ie.span(:index, 2).to_s.should == "tag:          span\n" + 
                                      "  name:         invalid_attribute\n" +
                                      "  value:        invalid_attribute\n" +
                                      "  text:         Sed pretium metus et quam. Nullam odio dolor, vestibulum non, tempor ut, vehicula sed, sapien. Vestibulum placerat ligula at quam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas."
    end
    it "should raise UnknownObjectException if the p doesn't exist" do
      lambda { @ie.span(:xpath, "//span[@id='no_such_id']").to_s }.should raise_error( UnknownObjectException)
    end
  end


  
 
  
  after :all do
    @ie.close
  end

end
