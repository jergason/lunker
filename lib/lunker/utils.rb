require 'net/http'
module Lunker
  module Utils
    def parameterize(hash)
      URI.escape(hash.collect { |k, v| "#{k}=#{v}"}.join("&"))
    end
  end
end
