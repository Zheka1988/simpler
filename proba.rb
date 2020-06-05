# require 'rack'
# class B
#   def initialize
#     @response = Rack::Response.new
#   end
#   def headers
#     @response
#   end
# end


# class A < B
#   def index
#     headers['asd'] = 'asd'
#   end

#   def show_response
#     headers
#   end
# end

# a = A.new
# a.index
# p a.show_response

a = [1,2,3,4,5]
b = a.find { |element| element == 1 }
p b
