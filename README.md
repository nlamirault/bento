# Bento

![bento](img/bento_process.png)

Some [Vagrant][] boxes . See [vagrant cloud](https://app.vagrantup.com/nlamirault)

* Master : [![Circle CI](https://circleci.com/gh/nlamirault/bento/tree/master.svg?style=svg)](https://circleci.com/gh/nlamirault/bento/tree/master)


## Prerequisites

* [Packer][]
* [Vagrant][]
* [VirtualBox][]


## Usage

Add a box :

    $ vagrant box add nlamirault/<box_name>

Using a box in a Vagrantfile:

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

## Boxes

### Debian

| Name           | VirtualBox (5.x) | Qemu  |
| -------------- | -----------------|-------|
| [8.4][D8.4]    | [x]              | [x]   |
| [8.5][D8.5]    | [x]              | [x]   |
| [9.0][D9.0]    | [x]              | [x]   |
| [9.1][D9.1]    | [x]              | [x]   |
| [9.2][D9.2]    | [x]              | [x]   |
| [9.3][D9.3]    | [x]              | [x]   |
| [9.4][D9.4]    | [x]              | [x]   |
| [9.5][D9.5]    | [x]              | [x]   |

### Archlinux

| Name                           | VirtualBox (5.x) | Qemu  |
| ------------------------------ | -----------------|-------|
| [2018.10.01][Arch2018.10.01]   | [x]              |       |
| [2017.07.01][Arch2017.07.01]   | [x]              |       |
| [2016.07.01][Arch2016.07.01]   | [x]              |       |

### BlackArch

| Name                                | VirtualBox (5.x) | Qemu  |
| ----------------------------------- | -----------------|-------|
| [2018.10.01][BlackArch2018.10.01]   | [x]              |       |

### Voidlinux

| Name                                | VirtualBox (5.x) | Qemu  |
| ----------------------------------- | -----------------|-------|
| [20170220][Voidlinux20170220]       | [x]              |       |

### CentOS

| Name                  | VirtualBox (5.x) | Qemu  |
| --------------------- | -----------------|-------|
| [7.2][C72]            | [x]              |       |

### Alpine Linux

| Name                  | VirtualBox (5.x) | Qemu  |
| --------------------- | -----------------|-------|
| [3.6][Alpine3.6]      | [x]              |       |
| [3.4][Alpine3.4]      | [x]              |       |
| [3.3][Alpine3.3]      | [x]              |       |

### FreeBSD

| Name                  | VirtualBox (5.x) | Qemu  |
| --------------------- | -----------------|-------|
| [11.0][FBSD110]       | [x]              |       |
| [10.3][FBSD103]       | [x]              |       |
| [10.2][FBSD102]       | [x]              |       |

### NetBSD

| Name                  | VirtualBox (5.x) | Qemu  |
| --------------------- | -----------------|-------|
| [7.0][NBSD70]         | [x]              |       |

### OpenBSD

| Name                  | VirtualBox (5.x) | Qemu  |
| --------------------- | -----------------|-------|
| [6.1][OBSD61]         | [x]              |       |
| [6.0][OBSD60]         | [x]              |       |
| [5.9][OBSD59]         | [x]              |       |


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
[D8.4]: https://app.vagrantup.com/nlamirault/boxes/debian-8/versions/8.4
[D8.5]: https://app.vagrantup.com/nlamirault/boxes/debian-8/versions/8.5

[D9]: https://app.vagrantup.com/nlamirault/boxes/debian-9
[D9.0]: https://app.vagrantup.com/nlamirault/boxes/debian-9/versions/9.0
[D9.1]: https://app.vagrantup.com/nlamirault/boxes/debian-9/versions/9.1
[D9.2]: https://app.vagrantup.com/nlamirault/boxes/debian-9/versions/9.2
[D9.3]: https://app.vagrantup.com/nlamirault/boxes/debian-9/versions/9.3
[D9.4]: https://app.vagrantup.com/nlamirault/boxes/debian-9/versions/9.4
[D9.5]: https://app.vagrantup.com/nlamirault/boxes/debian-9/versions/9.5

[Arch]: https://app.vagrantup.com/nlamirault/boxes/archlinux
[Arch2018.10.01]: https://app.vagrantup.com/nlamirault/boxes/archlinux/versions/2018.10.01
[Arch2017.07.01]: https://app.vagrantup.com/nlamirault/boxes/archlinux/versions/2017.07.01
[Arch2016.07.01]: https://app.vagrantup.com/nlamirault/boxes/archlinux/versions/2016.07.01

[BlackArch]: https://app.vagrantup.com/nlamirault/boxes/blackarch
[BlackArch2018.10.01]: https://app.vagrantup.com/nlamirault/boxes/blackarch/versions/2018.10.01

[Void]: https://app.vagrantup.com/nlamirault/boxes/voidlinux
[Voidlinux20170220]: https://app.vagrantup.com/nlamirault/boxes/voidlinux/versions/20170220

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
