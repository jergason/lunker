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
      VCR.use_cassette('user') do
        Lunker::User.new(78093).answers
        Lunker.requests_remaining.should be < 10000
      end
    end
  end

  describe Lunker::StackOverflow do
    let(:so) { Lunker::StackOverflow.new }
    it 'lets you get a specified number of users' do
      VCR.use_cassette('users') do
        users = so.users(295, { :order => "desc", :sort => "reputation" })
        users.length.should == 300
      end
    end
  end

  describe Lunker::User do
    before(:all) do
      VCR.use_cassette('user') do
        @user = Lunker::User.new(78093)
      end
    end

    it 'returns a hash of all the questions' do
      VCR.use_cassette('answers') do
        res = @user.answers
        res.length.should be > 0
      end
    end

    describe 'tags' do
      it 'gets a hash of all tags with counts for each tag' do
        VCR.use_cassette('tags') do
          tags = @user.tags
          tags.length.should be > 200
        end
      end

      it 'gets tags correctly in the correct format' do
        VCR.use_cassette('tags') do
          tags = @user.tags
          p tags[0]
        end
      end
    end

  end
end
