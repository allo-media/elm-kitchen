elm-create-spa
==============

This is a modest attempt at providing a simplistic yet opinionated Elm SPA application skeleton based on rtfeldman's [Elm Example SPA](https://github.com/rtfeldman/elm-spa-example/), for Allo-Media's own needs.

## Features

- Multiple pages navigation & routing
- Page framing
- Flags
- Session
- SCSS styling integration
- Minified build
- Development server with hot reloading
- Sample HTTP request

## Usage

For now installation is based on forking and/or cloning this repository:

```
$ git clone https://github.com/allo-media/elm-create-spa.git myapp
$ cd myapp
$ rm -rf .git
$ npm install
```

To start the development server:

```
$ npm start
```

To build the application:

```
$ npm run build
```

The resulting build is available in the `build` folder.

Application is served at [http://localhost:3000](http://localhost:3000).

## License

[MIT](https://opensource.org/licenses/MIT)
