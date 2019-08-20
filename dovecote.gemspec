$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "dovecote/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dovecote"
  s.version     = Dovecote::VERSION
  s.authors     = ["Tomasz Mazur"]
  s.email       = ["defkode@gmail.com"]
  s.homepage    = "http://www.messagebird.com"
  s.summary     = "Summary of Dovecote."
  s.description = "MessageBird Cage"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails",            ">= 5.2"
  s.add_dependency "messagebird-rest", "=1.3.2"

  s.add_development_dependency "sqlite3"
end
