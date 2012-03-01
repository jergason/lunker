require 'pp'

module Lunker
  module PagedResource
    def get_paged_resource(url, limit=nil)
      res = HTTParty.get url

      raise 'bad get request' unless valid?(res)

      data = []
      page = 1

      data = data.concat res['items']
      while res['has_more']

        res = HTTParty.get "#{url}&page=#{page}"

        if valid?(res)
          page += 1
          data = data.concat res['items']
        end

        if limit && data.length > limit
          break
        end
      end

      Lunker.requests_remaining = res['quota_remaining']

      data
    end

    def valid?(response)
      response.kind_of?(Hash) && !response.has_key?('error')
    end
  end
end
