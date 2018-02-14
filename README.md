elm-create-spa
==============

This is a modest attempt at providing a simplistic yet opinionated Elm [SPA](https://en.wikipedia.org/wiki/Single-page_application) application skeleton based on rtfeldman's [Elm Example SPA](https://github.com/rtfeldman/elm-spa-example/), for [Allo-Media](http://tech.allo-media.net/)'s own needs.

![demo](https://cdn.rawgit.com/allo-media/elm-create-spa/9eefefeffbfb29c7ceddb79d9c95d38b4d33d6a6/assets/demo.svg)

[Check for yourself](https://allo-media.github.io/elm-create-spa/)

## Features

- Multiple pages navigation & routing
- Page framing
- Flags
- Session
- SCSS styling integration
- Minified build
- Development server with hot reloading
- Sample HTTP request
- Default test layout

## Code organization

The application stores Elm source code in the `src` directory:

```
src
├── Data
│   ├── Counter.elm
│   ├── Date.elm
│   └── Session.elm
├── Page
│   ├── Counter.elm
│   ├── CurrentTime.elm
│   └── Home.elm
├── Request
│   └── Github.elm
├── Views
│   └── Page.elm
├── Main.elm
└── Route.elm
```

Rtfeldman explains this organization in a [dedicated blog post](https://dev.to/rtfeldman/tour-of-an-open-source-elm-spa).

SCSS stylesheets are stored within the `style` folder (freely inspired by [SMACSS](https://smacss.com/)):

```
style
├── base
│   ├── _base.scss
│   └── _variables.scss
├── modules
│   ├── _module-counter.scss
│   ├── _module-header.scss
│   └── _module-page-content.scss
└── main.scss
```

## Installation

```
$ npm install -g elm-create-spa
$ elm-create-app my-app
$ cd my-app
$ npm install
```

## Usage

To start the development server:

```
$ npm start
```

This will serve and recompile Elm and SCSS code when source files change. Served application is available at [localhost:3000](http://localhost:3000/).

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
