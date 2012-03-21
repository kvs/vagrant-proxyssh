# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "vagrant-proxyssh"
  s.version     = "0.1.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kenneth Vestergaard"]
  s.email       = ["kvs@binarysolutions.dk"]
  s.homepage    = "https://github.com/kvs/vagrant-proxyssh"
  s.summary     = "A Vagrant plugin"
  s.description = "A Vagrant plugin"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'

  s.add_dependency "vagrant", ">= 1.0.0"
end
