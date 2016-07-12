# Bento

* Master :
[![Circle CI](https://circleci.com/gh/nlamirault/bento/tree/master.svg?style=svg)](https://circleci.com/gh/nlamirault/bento/tree/master)

* Develop :
[![Circle CI](https://circleci.com/gh/nlamirault/bento/tree/develop.svg?style=svg)](https://circleci.com/gh/nlamirault/bento/tree/develop)


Some desktop boxes . See: https://atlas.hashicorp.com/nlamirault


## Usage

* Add a box :

        $ vagrant box add nlamirault/<box_name>

* Using a box in a Vagrantfile:

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "nlamirault/<box_name>"
end
```

## Pre-build boxes

The following boxes are built from this repository's templates :

| Name          | VirtualBox (5.0.12)       |
| ------------- | ------------------        |
| debian-8.x    | [amd64][D8]              |
| ubuntu-15.10  | [amd64][U1510]            |
| archlinux     | [amd64][Arch]             |
| centos-7.x    | [amd64][C7]              |
| freebsd-10.x  | [amd64][FBSD10]          |

### Debian

### Archlinux

### CentOS

Make the virtualbox box:

    $ make virtualbox template=netbsd-7-amd64.json

`WARNING`: You must type *Enter* on the first menu (NetBSD Installation CD)

### FreeBSD

### NetBSD

### OpenBSD


## Development

* Requirements : [Packer][]

* Virtualization provider: [Virtualbox][]

* Make the box on localhost

        $ make virtualbox template=debian-8.2-amd64

* Push to [Atlas][] a configuration build:

        $ make push template=debian-8.2-amd64

* Then on [Atlas][] website, performed a build. And edit settings to make the box public.


## License

See [LICENSE][] for the complete license.


## Changelog

A changelog is available [here](ChangeLog.md).


## Contact

Nicolas Lamirault <nicolas.lamirault@gmail.com>




[LICENSE]: https://github.com/nlamirault/bento/blob/master/LICENSE



[Packer]: https://www.packer.io/
[Atlas]:  https://atlas.hashicorp.com
[Virtualbox]: https://www.virtualbox.org/


[D8]: https://atlas.hashicorp.com/nlamirault/boxes/debian-8

[Arch]: https://atlas.hashicorp.com/nlamirault/boxes/archlinux

[U1510]: https://atlas.hashicorp.com/nlamirault/boxes/ubuntu-15.10

[C7]: https://atlas.hashicorp.com/nlamirault/boxes/centos-7

[N1412]: https://atlas.hashicorp.com/nlamirault/boxes/nixos-1412

[FBSD10]: https://atlas.hashicorp.com/nlamirault/boxes/freebsd-10
