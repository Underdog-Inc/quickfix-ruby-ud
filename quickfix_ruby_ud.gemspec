Gem::Specification.new do |s|
  s.name        = 'quickfix_ruby_ud'
  s.version     = '2.0.2'
  s.date        = '2025-04-18'
  s.summary     = "QuickFIX"
  s.description = "FIX (Financial Information eXchange) protocol implementation"
  s.authors     = ["Oren Miller", "Tom Kerr"]
  s.email       = 'tom.kerr@underdogfantasy.com.org'
  s.files       = Dir.glob("lib/*.rb") + Dir.glob("ext/quickfix/*.*") + Dir.glob("ext/quickfix/double-conversion/*.*") + Dir.glob("spec/FIX*.xml") + Dir.glob("test/*") 
  s.extensions = %w[ext/quickfix/extconf.rb]
  s.homepage    = 'http://www.quickfixengine.org'
  s.licenses    = 'Apache Style'
  s.rdoc_options = ['--exclude=ext']
  s.required_ruby_version = '>= 3.3.0'
end
