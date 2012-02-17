require 'thread'

module Lunker
  module PagedResource
    def get_paged_resource(path)
      res = HTTParty.get "#{SO_URL}/#{path}"

      raise 'bad get request' unless valid res

    end

    def valid(response)
      response.kind_of? Hash && !response.has_key? 'error'
    end
  end


  def number_of_requests_in_last_second
=begin
How to do this?
Have a queue of requests made in the last second.
Have it constantly update to clean out old requests
Make it have a semaphore that starts at 20 - max number of
things in queue.
When you finish another request, signal the semaphore?
When you want to do a request, down on the semaphore?

How to access shared data then?
=end
  end
end


class RequestTime
  attr_reader :time
  def initialize
    @time = Time.now
  end
end


class RequestLimit
  def initialize
    @mutex = Mutex.new
    @request_queue = []
  end

  def remove_old_requests
    now = Time.now
    @mutex.synchronize do
      @request_queue = @request_queue.reject {
        |req| diff_milliseconds(now, req.time) > 1000.0
      }
    end
  end

  def make_request
    #NEED SEMAPHORES!!!!
  end


  private
  def diff_milliseconds(t1, t2)
    (t1 - t2) * 1000.0
  end
end
