require 'httparty'
require 'lunker/paged_resource'
require 'lunker/utils'


module Lunker
  SO_URL = 'http://api.stackexchange.com/2.0'

  class << self
    attr_accessor :configuration, :requests_remaining
  end

  def self.configure
    self.configuration ||= Configuration.new
    self.requests_remaining = 10000
    yield(configuration) if block_given?
  end

  class Configuration
    attr_accessor :api_key, :filter

    def initialize
      @api_key = "bb855F7mbVFTS9Jwe69THg(("
      # Default filter: we want the titles and bodies of questions, answers, comments
      @filter = "!T5FUCxHumN2QdgS1Nc"
    end
  end

  class StackOverflow
    include Lunker::PagedResource
    include Lunker::Utils

    def initialize
    end

    def users(size_limit, parameters={:sort=>'reputation',:order =>'desc',:min =>'100000'})
      parameters = {
        :pagesize => "100",
        :key => Lunker.configuration.api_key,
        :site => "stackoverflow",
        :filter => Lunker.configuration.filter
      }.merge(parameters)
      encoded_parameters = parameterize parameters

      get_paged_resource "#{SO_URL}/users?#{encoded_parameters}", size_limit
    end
  end

  class User
    include Lunker::PagedResource
    def initialize(id)
      @id = id
    end

    %w(answers questions comments).each do |meth|
      define_method(meth) do |*sort|
        url = "#{SO_URL}/users/#{@id}/#{meth}?pagesize=100&key=#{Lunker.configuration.api_key}&site=stackoverflow&filter=#{Lunker.configuration.filter}"
        # Horribleness to allo an optional sort parameter
        unless sort.empty?
          url = "#{url}&sort=#{sort[0]}"
        end
        get_paged_resource url
      end
    end
  end
end

# Set up defaults
Lunker.configure
