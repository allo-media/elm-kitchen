# elm-kitchen

This is a modest attempt at providing a simplistic yet opinionated Elm [SPA](https://en.wikipedia.org/wiki/Single-page_application) application skeleton based on rtfeldman's [Elm Example SPA](https://github.com/rtfeldman/elm-spa-example/), for [Allo-Media](http://tech.allo-media.net/)'s own needs.

[Check for yourself](https://allo-media.github.io/elm-kitchen/)

## Features

- Multiple pages navigation & routing
- Page framing
- Flags
- Session
- [Bulma](http://bulma.io/) & SCSS styling integration
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
├── Main.elm
├── Page
│   └── Home.elm
├── Request
│   └── Github.elm
├── Route.elm
└── Views
    ├── Page.elm
    └── Theme.elm
```

Rtfeldman explains this organization in a [dedicated blog post](https://dev.to/rtfeldman/tour-of-an-open-source-elm-spa).

[elm-css](http://package.elm-lang.org/packages/rtfeldman/elm-css/latest) is used to style your app.

## Installation

```
$ npm install -g elm-kitchen
$ elm-kitchen my-app
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
