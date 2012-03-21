# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "vagrant-proxyssh"
  s.version     = "0.1.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kenneth Vestergaard"]
  s.email       = ["kvs@binarysolutions.dk"]
  s.homepage    = "https://github.com/kvs/vagrant-proxyssh"
  s.summary     = "A Vagrant plugin + ssh_config snippet for ssh'ing to a VM"
  s.description = "Makes it possible to use 'ssh' to login to a Vagrant VM, without adding multiple fake hosts to ~/.ssh/config"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'

  s.add_dependency "vagrant", ">= 1.0.0"
end
