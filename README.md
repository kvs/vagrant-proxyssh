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

Use `vagrant gem install vagrant-proxyssh` if you have a packaged installation of Vagrant.

Use `gem install vagrant-proxyssh` if you have Vagrant installed directly as a gem.

Use `gem "vagrant-proxyssh"` if you bundle Vagrant in a `Gemfile`.

Run `vagrant proxy-ssh --setup` somewhere with an active Vagrant to add the necessary
configuration to `~/.ssh/config`.

The setup routine assumes your login environment has the right Ruby-version in its path.

### OS X

On OS X, your login environment is determined by `~/.MacOSX/environment.plist`, and may
not reflect what you have in your `.bashrc`, `.zshrc`, or such.

Specifically, things may not work with Rubies installed with RVM, rbenv, or Homebrew,
since none of the usual paths are in the default environment.


## Usage

After installation and setup, you can `ssh vagrant` from your project directory,
and it'll work just like `vagrant ssh`.
