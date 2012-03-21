require 'socket'

class Vagrant::Command::ProxySSH < Vagrant::Command::Base
	def execute
		options = {}

		opts = OptionParser.new do |opt|
			opt.banner = "Usage: <used by ssh>"
			opt.separator "Helper used to create fake hostnames that proxy through to a VM"
			opt.separator ""

			opt.on("-s", "--setup", "Set up magic in ~/.ssh/config") do |o|
				options[:setup] = o
			end
		end

		argv = parse_options(opts)

		return if argv[0].nil?

		vmname = argv[0].sub(/^vagrant-?/, '')
		vmname = nil if vmname == ""

		with_target_vms(vmname, :single_target => true) do |vm|
			raise Errors::VMNotCreatedError if !vm.created?
			raise Errors::VMInaccessible if !vm.state == :inaccessible
			raise Errors::VMNotRunningError if vm.state != :running

			ssh_info = vm.ssh.info

			if options[:setup]
				File.open(File.expand_path("~/.ssh/config"), 'a') do |file|
					file.puts
					file.puts "Host vagrant*"
					file.puts "  ProxyCommand rbenv exec bundle exec vagrant proxy-ssh %h"
					file.puts "  User #{ssh_info[:username]}"
					file.puts "  UserKnownHostsFile /dev/null"
					file.puts "  StrictHostKeyChecking no"
					file.puts "  PasswordAuthentication no"
					file.puts "  IdentityFile #{ssh_info[:private_key_path]}"
					file.puts "  IdentitiesOnly yes"
				end
			else
				raise Errors::SSHPortNotDetected if ssh_info[:port].nil?

				connect_socket
				forward_data

				exec 'nc', '127.0.0.1', ssh_info[:port].to_s
			end
		end
	end
end
Vagrant.commands.register(:"proxy-ssh") { Vagrant::Command::ProxySSH }
