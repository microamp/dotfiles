# Python Setup

## Dependencies

-   `python3-pip`

    ``` bash
    apt install python3-pip
    ```

-   `python3-venv`

    ``` bash
    apt install python3-venv
    ```

## Virtual Environment under `$HOME/.local`

1.  Make sure `$HOME/.local/bin` is in the `$PATH`.

    ``` bash
    echo $PATH
    ```

2.  Set up a new Python virtual environment under `$HOME/.local`.

    ``` bash
    python3 -m venv ~/.local --system-site-packages
    source ~/.local/bin/activate
    ```

3.  Make sure `pip` points to `$HOME/.local/bin/pip`.

    ``` bash
    which pip
    ```

4.  Upgrade `pip`.

    ``` bash
    pip install --upgrade pip
    ```

5.  (Optional) Install other dependencies.

    ``` bash
    pip install black ipython isort pyright ruff
    ```

## Project-Specific Settings

``` bash
cd /path/to/your/python/project/
python -m venv .venv
```

``` bash
source .venv/bin/activate
pip install -U pip
pip install -U -r requirements.txt
pip install -U -r requirements.dev.txt
```

``` bash
cat .dir-locals.el
```

e.g.

``` commonlisp
((python-mode . ((devdocs-current-docs . ("python~3.9" "django~4.2"))
                 (python-shell-virtualenv-root . "/path/to/your/python/project/.venv"))))
```

(Optional)

``` bash
cat pyrightconfig.json
```

``` json
{
  "venvPath": ".",
  "venv": ".venv"
}
```
