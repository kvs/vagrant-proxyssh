require 'socket'

class Vagrant::Command::ProxySSH < Vagrant::Command::Base
	def execute
		options = {}

		opts = OptionParser.new do |opt|
			opt.banner = "Usage: Helper to setup ~/.ssh/config for using vagrant-proxy-ssh"

			opt.on("-s", "--setup", "Set up magic in ~/.ssh/config") do |o|
				options[:setup] = o
			end
		end

		parse_options(opts)

		return unless options[:setup]

		with_target_vms(nil, :single_target => true) do |vm|
			raise Errors::VMNotCreatedError if !vm.created?
			raise Errors::VMInaccessible if !vm.state == :inaccessible
			raise Errors::VMNotRunningError if vm.state != :running

			ssh_info = vm.ssh.info

			File.open(File.expand_path("~/.ssh/config"), 'a') do |file|
				file.puts
				file.puts "Host vagrant*"
				file.puts "  ProxyCommand #{cmd}-proxy-ssh %h"
				file.puts "  User #{ssh_info[:username]}"
				file.puts "  UserKnownHostsFile /dev/null"
				file.puts "  StrictHostKeyChecking no"
				file.puts "  PasswordAuthentication no"
				file.puts "  IdentityFile #{ssh_info[:private_key_path]}"
				file.puts "  IdentitiesOnly yes"
			end
		end
	end
end
Vagrant.commands.register(:"proxy-ssh") { Vagrant::Command::ProxySSH }
