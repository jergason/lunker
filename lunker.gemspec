Gem::Specification.new do |s|
  s.name = 'lunker'
  s.version = '0.0.3'
  s.date = '2012-02-29'
  s.summary = 'A wrapper for the StackExchange API.'
  s.description = 'See the summary.'
  s.authors = ['Jamison Dance']
  s.email = 'jergason@gmail.com'
  s.files = ['lib/lunker.rb', 'lib/lunker/paged_resource.rb']
  s.homepage = 'https://github.com/jergason/lunker.git'
  s.required_ruby_version = '>=1.9'
  s.add_dependency('httparty')
end
