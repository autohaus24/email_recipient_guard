$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "email_recipient_guard/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "email_recipient_guard"
  s.version     = EmailRecipientGuard::VERSION
  s.authors     = ["Michael Raidel"]
  s.email       = ["m.raidel@autohaus24.de"]
  s.summary     = "configure your outgoing email to always go to the same address"
  s.description = "By setting a config option you can configure your outgoing email to always go to the same address (useful for example for development or staging environments)"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rails", ">= 3.0.15", "< 3.3"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "shoulda"
  s.add_development_dependency "pry"
end
