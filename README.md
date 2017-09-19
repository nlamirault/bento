# Bento

![bento](img/bento_process.png)

Some [Vagrant][] boxes . See [vagrant cloud](https://app.vagrantup.com/nlamirault)

* Master : [![Circle CI](https://circleci.com/gh/nlamirault/bento/tree/master.svg?style=svg)](https://circleci.com/gh/nlamirault/bento/tree/master)
* Develop : [![Circle CI](https://circleci.com/gh/nlamirault/bento/tree/develop.svg?style=svg)](https://circleci.com/gh/nlamirault/bento/tree/develop)


## Prerequisites

* [Packer][]
* [Vagrant][]
* [VirtualBox][]


## Usage

* Add a box :

        $ vagrant box add nlamirault/<box_name>

* The following boxes are built from this repository's templates :

| Name           | Link                 | VirtualBox (5.x) | Qemu  |
| -------------- | -------------------  | -----------------|-------|
| debian-8       | [amd64][D8]          | [x]              | [x]   |
| debian-9       | [amd64][D9]          | [x]              |       |
| archlinux      | [amd64][Arch]        | [x]              | [x]   |
| voidlinux      | [amd64][Void]        | [x]              | [x]   |
| centos-7.2     | [amd64][C72]         | [x]              |       |
| kali           | [amd64][Kali]        |                  |       |
| freebsd-10.2   | [amd64][FBSD102]     | [x]              |       |
| freebsd-10.3   | [amd64][FBSD103]     | [x]              |       |
| freebsd-11.0   | [amd64][FBSD110]     | [x]              |       |
| openbsd-5.9    | [amd64][OBSD59]      | [x]              |       |
| openbsd-6.0    | [amd64][OBSD60]      | [x]              |       |
| openbsd-6.1    | [amd64][OBSD61]      |                  |       |
| netbsd-7.0     | [amd64][NBSD70]      | [x]              |       |
| alpine 3.3     | [x86_64][Alpine3.3]  | [x]              |       |
| alpine 3.4     | [x86_64][Alpine3.4]  | [x]              |       |
| alpine 3.6     | [x86_64][Alpine3.6]  | [x]              |       |
| blackarch      | [amd64][BlackArch]   |                  |       |

* Using a box in a Vagrantfile:

```ruby
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "nlamirault/<box_name>"
  config.ssh.forward_agent = true
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.gui = true
  end
end
```


## Build boxes

* Install [Packer][]

* Setup your [Vagrant-cloud](https://app.vagrantup.com/) settings :

        $ export VAGRANTCLOUD_TOKEN="xxxxxxxxxxxx"
        $ export VAGRANTCLOUD_USERNAME="xxxxxxxxxxxx"

### Debian

    $ make virtualbox template=debian-9-amd64.json
    $ cd vagrant/debian
    $ vagrant up

### Archlinux

    $ make virtualbox template=archlinux.json
    $ cd vagrant/archlinux
    $ vagrant up

### Voidlinux

    $ make virtualbox template=voidlinux.json
    $ cd vagrant/voidlinux
    $ vagrant up

### Kali Linux

    $ make virtualbox template=kali-amd64.json
    $ cd vagrant/kali-amd64
    $ vagrant up

### CentOS

    $ make virtualbox template=centos-7.x-x86_64.json
    $ cd vagrant/centos
    $ vagrant up
    $> startxfce4

### FreeBSD

    $ make virtualbox template=freebsd-xxx-amd64.json
    $ cd vagrant/freebsd
    $ vagrant up

### NetBSD

`WARNING`: You must type *Enter* on the first menu (NetBSD Installation CD)

Make the virtualbox box:

    $ make virtualbox template=netbsd-xxx-amd64.json
    $ cd vagrant/netbsd
    $ vagrant up
    $ vagrant ssh
    NetBSD 7.0 (GENERIC.201509250726Z)

    Welcome to NetBSD!

    -bash-4.3$

### OpenBSD




## License

See [LICENSE][] for the complete license.


## Changelog

A changelog is available [here](ChangeLog.md).


## Contact

Nicolas Lamirault <nicolas.lamirault@gmail.com>



[LICENSE]: https://github.com/nlamirault/bento/blob/master/LICENSE

[Packer]: https://www.packer.io
[Vagrant]: https://www.vagrantup.com
[VirtualBox]: https://www.virtualbox.org

[D8]: https://app.vagrantup.com/nlamirault/boxes/debian-8
[D9]: https://app.vagrantup.com/nlamirault/boxes/debian-9

[Arch]: https://app.vagrantup.com/nlamirault/boxes/archlinux

[Void]: https://app.vagrantup.com/nlamirault/boxes/voidlinux

[Kali]: https://app.vagrantup.com/nlamirault/boxes/kali

[U1510]: https://app.vagrantup.com/nlamirault/boxes/ubuntu-15.10

[C72]: https://app.vagrantup.com/nlamirault/boxes/centos-7.2

[N1412]: https://app.vagrantup.com/nlamirault/boxes/nixos-1412

[FBSD102]: https://app.vagrantup.com/nlamirault/boxes/freebsd-10.3
[FBSD103]: https://app.vagrantup.com/nlamirault/boxes/freebsd-10.2
[FBSD110]: https://app.vagrantup.com/nlamirault/boxes/freebsd-11.0

[NBSD70]: https://app.vagrantup.com/nlamirault/boxes/netbsd-7.0

[OBSD59]: https://app.vagrantup.com/nlamirault/boxes/openbsd-5.9
[OBSD60]: https://app.vagrantup.com/nlamirault/boxes/openbsd-6.0
[OBSD61]: https://app.vagrantup.com/nlamirault/boxes/openbsd-6.1

[Alpine3.3]: https://app.vagrantup.com/nlamirault/boxes/alpine-3.3
[Alpine3.4]: https://app.vagrantup.com/nlamirault/boxes/alpine-3.4
[Alpine3.6]: https://app.vagrantup.com/nlamirault/boxes/alpine-3.6

[BlackArch]: https://blackarch.org/
