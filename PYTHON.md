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
    pip install python-lsp-server ipython black isort
    ```
