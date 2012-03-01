require 'spec_helper'

describe Lunker do
  it 'has a configuration block that takes a configuration object' do
    #Lunker.configure do |conf|
      #conf.api_key = 'foobar'
    #end

    #Lunker.configuration.api_key.should == 'foobar'
  end

  describe 'requests remaining' do

    it 'has a requests_remaining module variable' do
      defined?(Lunker.requests_remaining).should be_true
      Lunker.requests_remaining.should == 10000
    end

    it 'updates as the api is used' do
      #TODO: this is a horrible way to test this
      Lunker::User.new(78093).answers
      Lunker.requests_remaining.should be < 10000
    end
  end

  describe Lunker::StackOverflow do
    let(:so) { Lunker::StackOverflow.new }
    it 'lets you get a specified number of users' do
      users = so.users(295, { :order => "desc", :sort => "reputation" })
      users.length.should == 300
    end
  end

  describe Lunker::User do
    let(:user) { Lunker::User.new(78093) }

    it 'should return a hash of all the questions' do
      res = user.answers
      res.length.should be > 0
    end
  end
end
