# Vagrant box for OpenCog

Download & install Vagrant for any supported OS

http://downloads.vagrantup.com/

## Linux

If using Linux, it's faster to use the vagrant-lxc provider over the default virtualbox. For Ubuntu or Debian:

```
sudo apt-get install lxc lxc-templates cgroup-lite redir
sudo vagrant plugin install vagrant-lxc
sudo vagrant box add precise64-lxc http://bit.ly/vagrant-lxc-precise64-2013-10-23
export VAGRANT_DEFAULT_PROVIDER=lxc
export VAGRANT_LOG=INFO
cd vagrant-lxc

```

# Run

```
vagrant up
vagrant ssh
```
