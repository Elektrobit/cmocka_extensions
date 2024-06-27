# cmocka_extensions

A collection of mocking related code extensions for cmocka used by [elos](https://github.com/Elektrobit/elos/) and other projects.
See [the documentation](documentation/documentation.md) for more details and [examples](examples) on how to use it.


## Building

cmocka_extensions uses CMake for building:

```bash
cmake -B ./build .
make -C ./build all
make -C ./build install
```

or use the CI hooks

```bash
./ci/build.sh [Release]
```

### Workspace setup

1. Please run the following git commands after cloning the repository:

   ```bash
   git config core.hooksPath .githooks
   ```

   to set the commit message template and to setup the project specific git hooks.

2. Usually it is a good idea to create a symlink to the compilation database
   created by cmake in the build directory. Run therefore:

   ```
   ln -s build/Debug/cmake/compile_commands.json
   ```

   or

   ```
   ln -s build/Release/cmake/compile_commands.json
   ```
## running the examples

the examples also get build with

```bash
./ci/build.sh [Release]
```

and can be run with

```bash
./ci/examples-run.sh
```

or found in

```
build/
└── <Debug|Release>/
   ├── ...
   └── examples/
      ├── ...
      └── test/
         ├── ...
         ├── extref/
         │  ├── ...
         │  ├── wrap/
         │  │  ├── ...
         │  │  └── wrap_extref_example
         │  └── weak/
         │     ├── ...
         │     └── weak_extref_example
         └── selfref/
            ├── ...
            └── weak_selfref_example
```

## Folders

### ci

Scripts to be used by CI pipelines to build , run various tests and checks.

### debian.native

Contains Debian packaging scripts for building the current source tree as .deb
packages. This is primarily for CI pipelines to automatically verify if the
packages are buildable or if anything needs to be changed.

See `debian.native/README.md` for more information.

### documentation

More detailed documentation of the mocked functions.

### src

Contains the actual productive sources.

#### src/cmocka_extensions

Contains code.

# License

MIT License

Copyright (c) [2023] [emlix GmbH, Elektrobit Automotive GmbH]

The full text of the license can be found in the [LICENSE](LICENSE) file in the repository root directory.

## Powered by EB

<img src="doc/source/_static/eb-logo.png" width=70 height=70 align="left">
elos is powered by elektrobit automotive gmbh.
Elektrobit is an automotive software company and developer of embedded software products for ECU, AUTOSAR, automated driving, connected vehicles and UX.
elos isan  integrated part of EB corbos Linux – built on Ubuntu is an open-source operating system for high-performance computing, leveraging the rich functionality of Linux while meeting security and industry regulations.


## Maintainers

* Wolfgang Gehrhardt wolfgang.gehrhardt@emlix.com [@gehwolf](https://github.com/gehwolf)
* Thomas Brinker thomas.brinker@emlix.com [@ThomasBrinker](https://github.com/ThomasBrinker)

## Credits

* Andreas Schickedanz
* Andreas Zdziarstek
* Anja Lehwess-Litzmann
* Annika Schmitt
* Anton Hillerband
* Benedikt Braunger
* Christian Steiger
* Daniel Glöckner
* Fabian Godehardt
* Friedrich Schwedler
* Isaac True
* Joerg Vehlow
* Maryniuk Bogdan
* Rainer Müller
* Sabrina Otto
* Thomas Brinker
* Vignesh Jayaraman
* Wolfgang Gehrhardt
