elm-create-spa
==============

This is a modest attempt at providing a simplistic yet opinionated Elm [SPA](https://en.wikipedia.org/wiki/Single-page_application) application skeleton based on rtfeldman's [Elm Example SPA](https://github.com/rtfeldman/elm-spa-example/), for [Allo-Media](github.com/allo-media)'s own needs.

## Features

- Multiple pages navigation & routing
- Page framing
- Flags
- Session
- SCSS styling integration
- Minified build
- Development server with hot reloading
- Sample HTTP request

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

SCSS stylesheets are stored within the `style` folder:

```
style
├── base
│   └── _variables.scss
├── modules
│   ├── _module-counter.scss
│   ├── _module-header.scss
│   └── _module-page-content.scss
└── main.scss
```

## Installation

For now installation is based on forking and/or cloning this repository:

```
$ git clone https://github.com/allo-media/elm-create-spa.git myapp
$ cd myapp
$ rm -rf .git
$ npm install
```

## Usage

To start the development server:

```
$ npm start
```

This will serve and recompile Elm and SCSS code when source files change. Served application is available at [localhost:3000](http://localhost:3000/).

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
