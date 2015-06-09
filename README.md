# miqrow

Twitter client made of Ruby + QML

## installing

```
$ git clone https://github.com/polamjag/miqrow.git
$ cd miqrow
$ bundle install
```

### tip

you should set `prefix` for `qml` gem like:

```
$ bundle config build.qml --with-libffi-dir=$(brew --prefix libffi) --with-qt-dir=$(brew --prefix qt5)
```
