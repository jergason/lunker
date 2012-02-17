require 'bundler'

Bundler.require :default

module Lunker
  SO_URL = 'http://api.stackexchange.com/2.0/'

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :api_key

    def initialize
      @api_key = "bb855F7mbVFTS9Jwe69THg(("
    end
  end

  class Lunk
    def user(user_id)
      User.new(user_id)
    end
  end

  class User
    include PagedResource
    def initialize(id)
      @id = id
    end

    def answers
      get_paged_resource("#{@id}/answers?pagesize=100")
    end
  end



end
