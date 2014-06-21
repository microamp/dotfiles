;; packages
(require 'package)
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))

(require 'cl)
(defvar packages-list
  '(zenburn-theme
    dired+
    rainbow-delimiters
    highlight-parentheses
    erc-hl-nicks
    rcirc-color
    rcirc-notify
    mew
    fill-column-indicator
    flymake-cursor
    flymake-easy
    flymake-python-pyflakes
    epc
    deferred
    auto-complete
    jedi
    s
    dash
    pkg-info
    clojure-mode
    paredit
    cider
    multi-eshell
    w3m
    mpc
    starter-kit
    starter-kit-eshell
    starter-kit-lisp)
  "List of packages needs to be upgraded/installed at launch")

(defun has-package-not-installed ()
  (loop for p in packages-list
        when (not (package-installed-p p)) do (return t)
        finally (return nil)))

(when (has-package-not-installed)
  ;; check for new packages (package versions)
  (message "%s" "Checking package versions...")
  (package-refresh-contents)
  (message "%s" " done")
  ;; install missing packages
  (dolist (p packages-list)
    (when (not (package-installed-p p))
      (package-install p))))

(setq emacs-dir "~/.emacs.d")
(setq custom-lib-dir "elisp")

(menu-bar-mode -1)  ;; hide menu bar
(tool-bar-mode -1)  ;; hide tool bar

;; always use utf-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; browse url using firefox
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")

;; dired+ for reusing dired buffers
(toggle-diredp-find-file-reuse-dir t)

;; disable automatic scrolling/re-centering
(setq-default scroll-step 1
              scroll-margin 0)

;; turn on font-lock mode to colour text in certain modes
(global-font-lock-mode t)

;; make sure spaces are used when indenting code
(setq-default indent-tabs-mode nil)

;; remove trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; hide password in shell mode
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

;; doc-view-mode: continuous navigation via C-n/C-p
(setq-default doc-view-continuous 1)

;; highlight current line
(global-hl-line-mode t)

;; ido
(require 'ido)
(ido-mode t)

;; electric-pair
(electric-pair-mode t)

;; load custom elisp libraries
(add-to-list 'load-path (concat emacs-dir "/" custom-lib-dir))
(load-library "theme-and-colours")
(load-library "chat")
(load-library "mail")
(load-library "parens")
(load-library "python")
(load-library "lisp")
(load-library "keybindings")
