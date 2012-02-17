require 'spec_helper'

describe Lunker do
  it 'has a configuration block that takes a configuration object' do
    Lunker.configure do |conf|
      conf.api_key = 'foobar'
    end

    Lunker.configuration.api_key.should == 'foobar'
  end

  describe Lunker::Lunk do
    let(:lunk) { Lunker::Lunk.new }
    let(:user_id) { 78093 }

    it 'returns a user object' do
        user = lunk.user(user_id)
        user.should_not be_nil
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
