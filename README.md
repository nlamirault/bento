# Bento

Some boxes. See: https://atlas.hashicorp.com/nlamirault


## Usage

* Add a box :

        $ vagrant box add nlamirault/jessie-8.2

* Using a bento box in a Vagrantfile:

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "nlamirault/jessie-8.2"
end
```

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
