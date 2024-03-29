Gem::Specification.new do |s|
  s.name = 'lunker'
  s.version = '0.0.7'
  s.date = '2012-04-01'
  s.summary = 'A wrapper for the StackExchange API.'
  s.description = 'See the summary.'
  s.authors = ['Jamison Dance']
  s.email = 'jergason@gmail.com'
  s.files = ['lib/lunker.rb', 'lib/lunker/paged_resource.rb', 'lib/lunker/utils.rb']
  s.homepage = 'https://github.com/jergason/lunker.git'
  s.required_ruby_version = '>=1.9'
  s.add_dependency('httparty')
end
