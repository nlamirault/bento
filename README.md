# Bento

Some boxes. See: https://atlas.hashicorp.com/nlamirault


## Usage

* Add a box :

        $ vagrant box add nlamirault/jessie-8.2

* Using a box in a Vagrantfile:

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "nlamirault/jessie-8.2"
end
```

## Pre-build boxes

|               | VirtualBox (5.0.12)       | Parallels (11.1.0)        |
| ------------- | ------------------        | -------------------       |
| debian-8.0    | [amd64][D80]              |                           |
| debian-8.1    | [amd64][D81]              |                           |
| debian-8.2    | [amd64][D82]              |                           |
| ubuntu-15.10  | [amd64][U1510]            |                           |
| archlinux     | [amd64][Arch]             |                           |


## Development

* Requirements : [Packer][]

* Virtualization provider: [Virtualbox][]

* Make the box :

        $ make virtualbox template=jessie-8.2-amd64

* Push to [Atlas][] a configuration build:

        $ make push template=jessie-8.2-amd64


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


[D80]: https://atlas.hashicorp.com/nlamirault/boxes/jessie-8.0
[D81]: https://atlas.hashicorp.com/nlamirault/boxes/jessie-8.1
[D82]: https://atlas.hashicorp.com/nlamirault/boxes/jessie-8.2

[Arch]: https://atlas.hashicorp.com/nlamirault/boxes/archlinux

[U1510]: https://atlas.hashicorp.com/nlamirault/boxes/ubuntu-15.10

[N1412]: https://atlas.hashicorp.com/nlamirault/boxes/nixos-1412
