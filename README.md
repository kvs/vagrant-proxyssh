# `vagrant-proxyssh`

A small hack to enable ssh'ing to Vagrant VMs directly from the command-line.

My personal use-case is in system-level tests where `ssh` is used as a part of the program.
It's much easier just to have a test-specific hostname (`vagrant`), than having to write
special-cased code to do a `vagrant ssh`, or having to add a custom host to `~/.ssh/config`
for each Vagrant VM.


## Requirements

Requires `nc` (netcat). It also currently only works when the Vagrant VMs have a standard
SSH-setup.


## Installation

Either use `vagrant gem`, or add a `gem "vagrant-proxyssh"` to your `Gemfile`.

Before first use, you can run `vagrant proxy-ssh --setup` to add the necessary
configuration to `~/.ssh/config`.

The setup routine is hard-coded for `rbenv`, and assumes Vagrant is bundled with
each project. Simply modify the `ProxyCommand` line in `~/.ssh/config` if you use
a system-Ruby, or RVM, or have Vagrant installed as a system gem.


## Usage

After installation and setup, you can `ssh vagrant` from your project directory,
and it'll work just like `vagrant ssh`.
