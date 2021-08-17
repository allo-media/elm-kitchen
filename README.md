# elm-kitten

[![Build Status](https://travis-ci.org/n1k0/elm-kitten.svg?branch=master)](https://travis-ci.org/n1k0/elm-kitten)

This project has been forken from [elm kitchen](https://github.com/allo-media/elm-kitten), which has been unmaintained for more than a year now.

> This is a modest attempt at providing a simplistic yet opinionated Elm [SPA](https://en.wikipedia.org/wiki/Single-page_application) application skeleton based on rtfeldman's [Elm Example SPA](https://github.com/rtfeldman/elm-spa-example/), for [Allo-Media](http://tech.allo-media.net/)'s own needs.

[Check for yourself](https://n1k0.github.io/elm-kitten/)

## Features

- Elm 0.19 ready
- Multiple pages navigation & routing, based on URL fragments
- Live development server with hot reloading
- [elm-test](https://github.com/elm-community/elm-test) support
- [SASS](https://sass-lang.com/) support
- JavaScript build minification using UglifyJS.

## Code organization

The application stores Elm source code in the `src` directory:

```
$ tree --dirsfirst skeleton/src
src
├── Data
│   └── Session.elm
├── Page
│   ├── Home.elm
│   └── SecondPage.elm
├── Request
│   └── Github.elm
├── Views
│   ├── Page.elm
│   └── Theme.elm
├── Main.elm
└── Route.elm
```

Richard Feldman explains this organization in a [dedicated blog post](https://dev.to/rtfeldman/tour-of-an-open-source-elm-spa).

## Installation

```
$ npm install -g elm-kitten
$ elm-kitten my-app
$ cd my-app
$ npm install
```

## Usage

To start the development server:

```
$ npm start
```

This will serve and recompile Elm code when source files change. Served application is available at [localhost:3000](http://localhost:3000/).

## Tests

```
$ npm test
```

Tests are located in the `tests` folder and are powered by [elm-test](https://github.com/elm-community/elm-test).

## Build

```
$ npm run build
```

The resulting build is available in the `build` folder.

## Deploy

A convenient `deploy` command is provided to publish code on [Github Pages](https://pages.github.com/).

```
$ npm run deploy
```

## License

[MIT](https://opensource.org/licenses/MIT)
