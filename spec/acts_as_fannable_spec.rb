require File.dirname(__FILE__) + '/spec_helper'

module FanSpecHelper
  def valid_fan_attributes
    {  :fannable_type => 'Product',
       :fannable_id => 1,
       :user_id => 1,
       :created_at=>Time.now }
  end
    def valid_product_attributes
    {  :name => 'Computer',
       :created_at=>Time.now }
  end
end



describe HeurionConsulting::Acts::Fannable do
  include FanSpecHelper

  before(:each) do
    @fan = Fan.new
    @user = mock_model(User,:id=>1,:created_at=>Time.now,:save=>true)
    @product = mock_model(Product,:id=>1,:name=>"Computer",:created_at=>Time.now,:save=>true)
  end

  it "should be valid" do
    @fan.attributes = valid_fan_attributes
    @fan.should be_valid
  end


  it "should relate to user" do
    Fan.reflect_on_association(:user).should_not be_nil
  end

  it "should relate to product" do
    Product.acts_as_fannable.should_not be_nil
  end
 
  it "should relate to fannable" do
    Fan.reflect_on_association(:fannable).should_not be_nil
  end

  it "should should not be valid without something to related to" do
    @fan.attributes = valid_fan_attributes.except(:fannable_id, :fannable_type, :user_id)
    @fan.should_not be_valid
    @fan.errors.on(:fannable_id).should eql(nil)
    @fan.fannable_id = 1
    @fan.should_not be_valid
    @fan.errors.on(:user_id).should eql(nil)
    @fan.fannable_id = 1
    @fan.should_not be_valid
    @fan.errors.on(:fannable_type).should eql("can't be blank")
    @fan.fannable_type = "Product"
    @fan.should be_valid
  end

  it "should be able to search for fans" do 
     @fan.attributes = valid_fan_attributes
     @fan.save
     fan = Product.find_fans_for(@product)
     fan.should_not be_nil
     fan.include?(@fan).should be_true
  end
  
  it "should be able to search for users based on fannable_type" do 
     @fan.attributes = valid_fan_attributes
     @fan.save
     fan = Product.find_fannables_by_user(@user)
     fan.should_not be_nil
     fan.include?(@fan).should be_true
  end

end
