require 'spec_helper'

describe Message do

  let(:user_s) { FactoryGirl.create(:user) }
  let(:user_r) { FactoryGirl.create(:user) }
  before do
     @message = user_s.messages.build(content: "Lorem ipsum", recipient_id: user_r.id)
  end

  subject { @message }

  it { should respond_to(:content) }
  it { should respond_to(:sender_id) }
  it { should respond_to(:recipient_id) }
  its(:sender_id) { should == user_s.id }
  its(:recipient_id) { should == user_r.id }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to sender_id" do
      expect do
        Message.new(sender_id: user_s.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when sender_id is not present" do
    before { @message.sender_id = nil }
    it { should_not be_valid }
  end

  describe "when recipient_id is not present" do
    before { @message.recipient_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @message.content = " " }
    it { should_not be_valid }
  end
 
end