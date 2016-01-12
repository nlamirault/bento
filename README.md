# Bento

Some boxes. See: https://atlas.hashicorp.com/nlamirault


## Usage

* Add a box and launch it :

        $ vagrant init nlamirault/jessie
        $ vagrant up --provider virtualbox

## Development

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
