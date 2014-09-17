;; packages
(require 'package)

(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))

(require 'cl)
(defvar packages-list
  '(auto-complete
    bash-completion
    cider
    clojure-mode
    color-theme
    color-theme-buffer-local
    dired+
    dired-rainbow
    dired-toggle-sudo
    ein
    epc
    erc-hl-nicks
    fill-column-indicator
    flymake-cursor
    flymake-easy
    flymake-python-pyflakes
    highlight-parentheses
    hy-mode
    go-mode
    ido-load-library
    ipython
    jedi
    load-theme-buffer-local
    magit
    merlin
    mew
    monky
    mpc
    multi-eshell
    nodejs-repl
    org
    paredit
    rainbow-delimiters
    rcirc-color
    rcirc-notify
    starter-kit
    starter-kit-eshell
    starter-kit-lisp
    tuareg
    twittering-mode
    utop
    w3m
    zenburn-theme)
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

(require 'dired+)
(require 'dired-rainbow)
(require 'highlight-parentheses)
(require 'ido)
(require 'rainbow-delimiters)

(setq emacs-dir "~/.emacs.d")
(setq custom-lib-dir "elisp")

(menu-bar-mode -1)  ;; hide menu bar
(tool-bar-mode -1)  ;; hide tool bar

(blink-cursor-mode t)  ;; make cursor blink

(set-default-font "Terminus-8")  ;; default font

(setq visible-bell nil)  ;; turn visible bell off

;; always use utf-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; browse url using conkeror
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "conkeror")

;; dired+ for reusing dired buffers
(toggle-diredp-find-file-reuse-dir t)

;; dired-rainbow settings
(dired-rainbow-define media "#BC8383" ("mp3" "mp4" "MP3" "MP4" "avi" "mpg" "flv" "ogg"))
(dired-rainbow-define elisp "#DFAF8F" ("el"))
(dired-rainbow-define python "#F0DFAF" ("py"))
(dired-rainbow-define clojure "#F0DFAF" ("clj"))
(dired-rainbow-define cljs "#F0DFAF" ("cljs"))

;; disable automatic scrolling/re-centering
(setq-default scroll-step 1
              scroll-margin 0)

;; turn on font-lock mode to colour text in certain modes
(global-font-lock-mode t)

;; make sure spaces are used when indenting code
(setq-default indent-tabs-mode nil)

;; remove trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; doc-view-mode: continuous navigation via C-n/C-p
(setq-default doc-view-continuous 1)

;; highlight current line
;(global-hl-line-mode t)

;; ido
(ido-mode t)

;; electric-pair
(electric-pair-mode t)

;; rainbow-delimiters
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; highlight-parentheses
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;; map RET to newline-and-indent
(define-key global-map (kbd "RET") 'newline-and-indent)

;; map M-N to other-window
(define-key global-map (kbd "M-N") 'other-window)
(define-key global-map (kbd "M-P") 'previous-multiframe-window)

;; focus the new window after split
(global-set-key "\C-x2" (lambda ()
                          (interactive)
                          (split-window-below)
                          (other-window 1)))
(global-set-key "\C-x3" (lambda ()
                          (interactive)
                          (split-window-right)
                          (other-window 1)))

;; vi-style C-e/C-y
(defun vi-style-c-e (n)
  (interactive "p")
  (scroll-up n))

(defun vi-style-c-y (n)
  (interactive "p")
  (scroll-down n))

(global-set-key "\M-n" 'vi-style-c-e)
(global-set-key "\M-p" 'vi-style-c-y)

;; w3m keybindings
(add-hook 'w3m-mode-hook
          (lambda () (local-set-key (kbd "M-n") 'w3m-scroll-up)))
(add-hook 'w3m-mode-hook
          (lambda () (local-set-key (kbd "M-p") 'w3m-scroll-down)))

;; set tab width for go mode
(add-hook 'go-mode-hook
  (function
   (lambda ()
     (setq tab-width 2))))

;; load custom elisp libraries
(add-to-list 'load-path (concat emacs-dir "/" custom-lib-dir))
(load-library "microamp-chat")
(load-library "microamp-colours")
(load-library "microamp-lisp")
(load-library "microamp-mail")
(load-library "microamp-ocaml")
(load-library "microamp-org")
(load-library "microamp-python")
(load-library "microamp-shell")
