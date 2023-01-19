# Node.js Setup

## Dependencies

-   `nodejs`

    ``` bash
    apt install nodejs
    ```

-   `npm`

    ``` bash
    apt install npm
    ```

## Run Executables with `npx`

``` bash
cd $HOME
```

``` bash
npm install -D typescript-language-server
```

``` bash
npx typescript-language-server
```

``` text
Usage: typescript-language-server [options]

Options:
  -V, --version           output the version number
  --stdio                 use stdio
  --log-level <logLevel>  A number indicating the log level (4 = log, 3 = info, 2 = warn, 1 = error). Defaults to
                          `2`.
  -h, --help              display help for command
```

## Language Server in Node.js

1.  Install LSP servers.

    ``` bash
    npm install -D \
        bash-language-server \
        dockerfile-language-server-nodejs \
        typescript-language-server \
        yaml-language-server
    ```

2.  Update `eglot-server-programs` accordingly to include the `npx` command in the beginning.
