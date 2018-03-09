$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "notify_chat/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "notify_chat"
  s.version     = NotifyChat::VERSION
  s.authors     = ["Anuja Ware"]
  s.email       = ["anuja@joshsoftware.com"]
  s.homepage    = "https://github.com/anujaware/notify_chat.git"
  s.summary     = "Notification or chat management."
  s.description = "Provides a module to manage notification/Chat messages and it's state.
  Also provided a facility to send SNS notification for Android and iOS app."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.4"

  s.add_development_dependency "sqlite3"
end
