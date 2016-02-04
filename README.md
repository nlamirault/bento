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
| debian-8.0    | [amd64][D80]              |
| debian-8.1    | [amd64][D81]              |
| debian-8.2    | [amd64][D82]              |
| debian-8.3    | [amd64][D83]              |
| ubuntu-15.10  | [amd64][U1510]            |
| archlinux     | [amd64][Arch]             |
| centos-7.2    | [amd64][C72]              |
| freebsd-10.2  | [amd64][FBSD102]          |




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


[D80]: https://atlas.hashicorp.com/nlamirault/boxes/debian-8.0
[D81]: https://atlas.hashicorp.com/nlamirault/boxes/debian-8.1
[D82]: https://atlas.hashicorp.com/nlamirault/boxes/debian-8.2
[D83]: https://atlas.hashicorp.com/nlamirault/boxes/debian-8.3

[Arch]: https://atlas.hashicorp.com/nlamirault/boxes/archlinux

[U1510]: https://atlas.hashicorp.com/nlamirault/boxes/ubuntu-15.10

[C72]: https://atlas.hashicorp.com/nlamirault/boxes/centos-7.2

[N1412]: https://atlas.hashicorp.com/nlamirault/boxes/nixos-1412

[FBSD102]: https://atlas.hashicorp.com/nlamirault/boxes/freebsd-10.2
