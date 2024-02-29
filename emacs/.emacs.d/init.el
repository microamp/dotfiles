;;; .emacs.d/init.el --- -*- lexical-binding: t; -*-

;;; Commentary:

;; Starting up anew

;;; Code:

;; Set up package archives
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("org" . "http://orgmode.org/elpa/")))

;; built-in (29+)
(require 'use-package)
(setq use-package-always-defer t
      use-package-verbose t)

(require 'bind-key)

;; Minimal UI
(setq-default default-frame-alist'((tool-bar-lines . 0)
				   (menu-bar-lines . 0)
				   (vertical-scroll-bars . nil)
				   (horizontal-scroll-bars . nil)
				   (left-fringe . nil)
				   (right-fringe . nil)
				   (internal-border-width . 1)))

(defalias 'yes-or-no-p 'y-or-n-p)

;; UTF-8 everywhere
(set-default-coding-systems 'utf-8)

;; Set defaults
(setq-default auto-save-interval 0
              auto-save-timeout nil
              auto-window-vscroll nil
              cursor-type 'box
              frame-inhibit-implied-resize t
              garbage-collection-messages t
              gc-cons-threshold 100000000
              indent-tabs-mode nil
              initial-scratch-message ""
              make-pointer-invisible t
              menu-bar-mode nil
              message-log-max 1000
              read-process-output-max (* 1024 1024 100)
              ring-bell-function 'ignore
              scroll-conservatively 1000
              scroll-down-aggressively 1
              scroll-margin 3
              scroll-preserve-screen-position t
              scroll-step 0
              tab-always-indent 'complete
              tool-bar-mode nil
              truncate-lines nil
              use-dialog-box nil
              use-file-dialog nil
              visible-bell t)

;; Set custom key bindings
(global-set-key (kbd "C-M-<return>") #'shell-command)
(global-set-key (kbd "C-x -") #'split-window-vertically)
(global-set-key (kbd "C-x l") #'delete-other-windows)
(global-set-key (kbd "C-x L") #'delete-window)
(global-set-key (kbd "C-x M-l") #'count-lines-page)
(global-set-key (kbd "C-x \\") #'split-window-horizontally)
(global-set-key (kbd "C-x k") #'kill-this-buffer)
(global-set-key [remap dabbrev-expand] 'hippie-expand)
(global-set-key [remap comment-dwim] #'comment-line)

(global-set-key (kbd "M-n") #'forward-paragraph)
(global-set-key (kbd "M-p") #'backward-paragraph)

;; (set-frame-parameter (selected-frame) 'alpha '(80))
;; (add-to-list 'default-frame-alist '(alpha . (80)))

(use-package ansi-color
  :ensure nil
  :hook ((compilation-filter . ansi-color-compilation-filter)))

(use-package autorevert
  :ensure nil
  :hook ((window-setup . global-auto-revert-mode)))

(use-package browse-url
  :ensure nil
  :custom
  (browse-url-browser-function 'browse-url-firefox))

(use-package comint
  :ensure nil
  :bind (:map comint-mode-map
         ("C-l" . comint-clear-buffer))
  :custom
  (comint-move-point-for-output t)
  (comint-scroll-to-bottom-on-input t)
  :init
  (defalias 'comint-scroll-to-bottom-on-output t))

(use-package compile
  :ensure nil
  :custom
  (compilation-ask-about-save nil)
  (compilation-auto-jump-to-first-error t)
  (compilation-always-kill t)
  (compilation-skip-threshold 2))

(use-package cus-edit
  :ensure nil
  :custom
  (custom-file "~/.emacs.d/custom.el"))
(load custom-file 'noerror 'nomessage)

(use-package delsel
  :ensure nil
  :hook ((after-init . delete-selection-mode)))

(use-package dired
  :ensure nil
  :custom
  (dired-listing-switches "-lah"))

(use-package display-line-numbers
  :ensure nil
  :hook ((prog-mode . display-line-numbers-mode)
         (restclient-mode . display-line-numbers-mode)))

(use-package ediff-init
  :ensure nil
  :custom
  (ediff-highlight-all-diffs t))

(use-package eglot
  :ensure nil
  :hook ((dockerfile-mode . eglot-ensure)
         (js-mode . eglot-ensure)
         (python-base-mode . eglot-ensure)
         (sh-mode . eglot-ensure)
         (terraform-mode . eglot-ensure)
         (typescript-mode . eglot-ensure)
         (yaml-mode . eglot-ensure))
  :bind (:map eglot-mode-map
	 ("C-c r v" . eglot-rename))
  :custom
  (eglot-autoshutdown t)
  :config
  (add-to-list 'eglot-server-programs '(dockerfile-mode . ("docker-langserver" "--stdio")))
  (add-to-list 'eglot-server-programs '(js-mode . ("typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs '(python-base-mode . ("pylsp")))
  (add-to-list 'eglot-server-programs '(sh-mode . ("bash-language-server" "start")))
  (add-to-list 'eglot-server-programs '(terraform-mode . ("terraform-ls" "serve")))
  (add-to-list 'eglot-server-programs '(typescript-mode . ("typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs '(yaml-mode . ("yaml-language-server" "--stdio"))))

(use-package eldoc
  :ensure nil
  :custom
  (eldoc-echo-area-use-multiline-p nil))

(use-package elisp-mode
  :ensure nil
  :bind (:map emacs-lisp-mode-map
         ("C-c C-k" . eval-buffer)))

(use-package eshell
  :ensure nil
  :config
  (setq eshell-buffer-maximum-lines 5000
        eshell-history-size 200
        eshell-hist-ignoredups t)
  (defun eshell-clear ()
    ;; NOTE: This erases shell content!
    (interactive)
    (let ((inhibit-read-only t))
      (erase-buffer))
    (eshell-send-input))
  (defun eshell-init ()
    (define-key eshell-mode-map (kbd "C-l") #'eshell-clear))
  (add-hook 'eshell-mode-hook #'eshell-init))

(use-package flymake
  :ensure nil
  :bind (:map prog-mode-map
         ("C-c f" . flymake-mode)
         ("C-c ! n" . flymake-goto-next-error)
         ("C-c ! p" . flymake-goto-prev-error))
  :config
  (add-hook 'eglot-managed-mode-hook
            (lambda () (cond ((derived-mode-p 'python-base-mode)
                              (remove-hook 'flymake-diagnostic-functions #'eglot-flymake-backend t)
                              (add-hook 'flymake-diagnostic-functions #'python-flymake nil t))
                             (t nil)))))

(use-package files
  :ensure nil
  :custom
  (backup-directory-alist '((".*" . "~/.emacs.d/.tmp")))
  (confirm-kill-emacs nil)
  (enable-remote-dir-locals t))

(use-package frame
  :ensure nil
  :hook ((after-init . blink-cursor-mode))
  :custom
  (blink-cursor-blinks 0))

(use-package fringe
  :ensure nil
  :config
  (set-fringe-mode 0))

(use-package help
  :ensure nil
  :custom
  (help-window-select t))

(use-package help-fns
  :ensure nil
  :bind (("C-h M-f" . describe-face)))

(use-package isearch
  :ensure nil
  :bind (:map minibuffer-local-isearch-map
         ("M-/" . isearch-complete-edit)
         :map isearch-mode-map
         ("C-g" . isearch-cancel)
         ("M-/" . isearch-complete)
	 ("M-j" . isearch-yank-symbol-or-char)
	 ("M-n" . isearch-yank-symbol-or-char))
  :custom
  (isearch-allow-scroll 'unlimited)
  (isearch-lazy-count t)
  (isearch-lazy-highlight t)
  (isearch-yank-on-move 'shift)
  (lazy-count-prefix-format nil)
  (lazy-count-suffix-format " (%s/%s)")
  (isearch-lazy-count t)
  (search-whitespace-regexp ".*?")
  :config
  (setq isearch-lax-whitespace t
	isearch-regexp-lax-whitespace nil))

(use-package js
  :ensure nil
  :mode ("\\.js\\'" . js-mode)
  :bind (:map js-mode-map
         ("M-." . xref-find-definitions)))

(use-package midnight
  :ensure nil
  :hook ((after-init . midnight-mode)))

(use-package minibuffer
  :ensure nil
  :custom
  (completion-cycle-threshold 3))

(use-package modus-themes
  :ensure nil
  :hook ((window-setup . (lambda () (load-theme 'modus-vivendi t))))
  :custom
  (modus-themes-bold-constructs nil)
  (modus-themes-completions '((matches . (background minimal))
                              (selection . (background minimal))
                              (popup . (background minimal))))
  (modus-themes-diffs nil)
  (modus-themes-headings '((1 . (background))
			   (2 . (rainbow))
			   (t . (semibold))))
  (modus-themes-links '(neutral-underline background))
  (modus-themes-mode-line '(borderless))
  (modus-themes-org-blocks 'gray-background)
  (modus-themes-paren-match nil)
  (modus-themes-prompts '(intense))
  (modus-themes-region '(bg-only))
  (modus-themes-subtle-line-numbers t)
  (modus-themes-syntax '(faint alt-syntax green-strings yellow-comments))
  (modus-themes-tabs-accented t))

(use-package mwheel
  :ensure nil
  :init
  (setq-default mouse-wheel-mode nil))

(use-package org
  :ensure nil
  :bind (:map org-mode-map
         ("C-c ;" . nil)
         ("C-j" . org-return-indent)
         ("M-H" . org-metaleft)
         ("M-J" . org-metadown)
         ("M-K" . org-metaup)
         ("M-L" . org-metaright)
         ("M-n" . org-next-visible-heading)
         ("M-p" . org-previous-visible-heading))
  :hook ((org-mode . visual-line-mode))
  :custom
  (org-clock-sound "~/Downloads/bell-ringing-05.wav")
  (org-export-with-author nil)
  ;; (org-export-with-tags nil)
  (org-export-with-title nil)
  (org-startup-with-inline-images t)
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages '((dot . t)
                               (emacs-lisp . t))))

(use-package project
  :ensure nil
  :bind-keymap ("C-c p" . project-prefix-map)
  :bind (:map project-prefix-map
         ("q" . consult-ripgrep)
         ("s" . consult-ripgrep)))

(use-package pulse
  :ensure nil
  :custom
  (pulse-delay 0.045)
  :init
  (defun nsh/pulse (&rest args)
    (pulse-momentary-highlight-one-line (point)))
  (let ((pulse-commands '(delete-other-windows
                          delete-window
                          diff-goto-source
                          diff-hunk-next
                          kill-this-buffer
                          log-view-msg-next
                          log-view-msg-prev
                          mode-line-other-buffer
                          other-window
                          recenter-top-bottom
                          scroll-down-command
                          scroll-up-command
                          xref-find-definitions
                          xref-go-back)))
    (dolist (command pulse-commands)
      (advice-add command :after #'nsh/pulse))))

;; Dependencies:
;; python -m pip install --user --upgrade python-lsp-server
;; python -m pip install --user --upgrade ipython
;; python -m pip install --user --upgrade black
;; python -m pip install --user --upgrade flake8
;; python -m pip install --user --upgrade isort
;; python -m pip install --user --upgrade ruff
(use-package python
  :ensure nil
  :mode ("\\.py\\'" . python-mode)
  :bind (:map python-mode-map
	 ("C-c C-n" . python-nav-forward-statement)
	 ("C-c C-p" . python-nav-backward-statement)
         ("C-c C-c" . python-shell-send-statement)
         ("C-c C-f" . python-shell-send-defun)
         ("C-c C-k" . python-shell-send-buffer)
         ("C-c C-r" . python-shell-send-region)
         ("C-c C-z" . run-python)
         ("M-[" . python-nav-backward-defun)
         ("M-]" . python-nav-forward-defun)
         :map inferior-python-mode-map
         ("C-l" . comint-clear-buffer))
  :custom
  (python-flymake-command '("ruff" "--quiet" "--stdin-filename=stdin" "-"))
  (python-indent-guess-indent-offset-verbose nil)
  (python-shell-interpreter "ipython")
  (python-shell-interpreter-args "--simple-prompt -i --pprint --nosep --no-banner --no-confirm-exit"))

(use-package recentf
  :ensure nil
  :hook ((after-init . recentf-mode))
  :custom
  (recentf-max-menu-items 100)
  (recentf-max-saved-items 100))

(use-package repeat
  :ensure nil
  :hook ((after-init . repeat-mode))
  :config
  (defvar flymake-goto-next-prev-error-repeat-map
    (let ((map (make-sparse-keymap)))
      (define-key map "n" #'flymake-goto-next-error)
      (define-key map "p" #'flymake-goto-prev-error)
      map))

  (dolist (command '(flymake-goto-next-error
                     flymake-goto-prev-error))
    (put command 'repeat-map 'flymake-goto-next-prev-error-repeat-map))

  (defvar next-previous-line-repeat-map
    (let ((map (make-sparse-keymap)))
      (define-key map "p" #'previous-line)
      (define-key map "n" #'next-line)
      map))

  (dolist (command '(previous-line
		     next-line))
    (put command 'repeat-map 'next-previous-line-repeat-map))

  (defvar org-backward-forward-element-repeat-map
    (let ((map (make-sparse-keymap)))
      (define-key map "p" #'org-backward-element)
      (define-key map "n" #'org-forward-element)
      (define-key map "{" #'org-backward-element)
      (define-key map "}" #'org-forward-element)
      map))

  (dolist (command '(org-backward-element
		     org-forward-element))
    (put command 'repeat-map 'org-backward-forward-element-repeat-map))

  (defvar org-next-previous-visible-heading-repeat-map
    (let ((map (make-sparse-keymap)))
      (define-key map "p" #'org-previous-visible-heading)
      (define-key map "n" #'org-next-visible-heading)
      map))

  (dolist (command '(org-previous-visible-heading
		     org-next-visible-heading))
    (put command 'repeat-map 'org-next-previous-visible-heading-repeat-map))

  (defvar org-roam-dailies-goto-note-repeat-map
    (let ((map (make-sparse-keymap)))
      (define-key map "b" #'org-roam-dailies-goto-previous-note)
      (define-key map "f" #'org-roam-dailies-goto-next-note)
      (define-key map "d" #'org-roam-dailies-goto-today)
      (define-key map "t" #'org-roam-dailies-goto-tomorrow)
      (define-key map "y" #'org-roam-dailies-goto-yesterday)
      map))

  (dolist (command '(org-roam-dailies-goto-previous-note
                     org-roam-dailies-goto-next-note
                     org-roam-dailies-goto-today
                     org-roam-dailies-goto-tomorrow
                     org-roam-dailies-goto-yesterday))
    (put command 'repeat-map 'org-roam-dailies-goto-note-repeat-map))

  (defvar forward-backward-paragraph-repeat-map
    (let ((map (make-sparse-keymap)))
      (define-key map "{" #'backward-paragraph)
      (define-key map "}" #'forward-paragraph)
      (define-key map "[" #'backward-paragraph)
      (define-key map "]" #'forward-paragraph)
      (define-key map "p" #'backward-paragraph)
      (define-key map "n" #'forward-paragraph)
      map))

  (dolist (command '(backward-paragraph
                     forward-paragraph))
    (put command 'repeat-map 'forward-backward-paragraph-repeat-map))

  (defvar markdown-forward-backward-paragraph-repeat-map
    (let ((map (make-sparse-keymap)))
      (define-key map "{" #'markdown-backward-paragraph)
      (define-key map "}" #'markdown-forward-paragraph)
      (define-key map "[" #'markdown-backward-paragraph)
      (define-key map "]" #'markdown-forward-paragraph)
      (define-key map "p" #'markdown-backward-paragraph)
      (define-key map "n" #'markdown-forward-paragraph)
      map))

  (dolist (command '(markdown-backward-paragraph
                     markdown-forward-paragraph))
    (put command 'repeat-map 'markdown-forward-backward-paragraph-repeat-map))

  (defvar python-nav-forward-backward-statement-repeat-map
    (let ((map (make-sparse-keymap)))
      (define-key map "p" #'python-nav-backward-statement)
      (define-key map "n" #'python-nav-forward-statement)
      map))

  (dolist (command '(python-nav-forward-statement
		     python-nav-backward-statement))
    (put command 'repeat-map 'python-nav-forward-backward-statement-repeat-map))

  (defvar mode-line-other-buffer-repeat-map
    (let ((map (make-sparse-keymap)))
      (define-key map "n" #'mode-line-other-buffer)
      map))

  (dolist (command '(mode-line-other-buffer))
    (put command 'repeat-map 'mode-line-other-buffer-repeat-map))

  (defvar winner-undo-redo-map
    (let ((map (make-sparse-keymap)))
      (define-key map "h" #'winner-undo)
      (define-key map "l" #'winner-redo)
      map))

  (dolist (command '(winner-undo winner-redo))
    (put command 'repeat-map 'winner-undo-redo-map)))

(use-package register
  :ensure nil
  :bind (("C-x j j" . jump-to-register)
         ("C-x j i" . window-configuration-to-register)
         ("C-x j w" . window-configuration-to-register))
  :custom
  (register-preview-delay 0))

(use-package savehist
  :ensure nil
  :hook ((after-init . savehist-mode)))

(use-package simple
  :ensure nil
  :bind (("M-c" . capitalize-dwim)
	 ("M-l" . downcase-dwim)
	 ("M-u" . upcase-dwim))
  :config
  (add-to-list 'write-file-functions #'delete-trailing-whitespace))

(use-package tooltip
  :ensure nil
  :init
  (setq-default tooltip-mode nil))

(use-package treesit
  :ensure nil
  :init
  (setq treesit-language-source-alist
   '((bash . ("https://github.com/tree-sitter/tree-sitter-bash"))
     (c . ("https://github.com/tree-sitter/tree-sitter-c"))
     (cpp . ("https://github.com/tree-sitter/tree-sitter-cpp"))
     (css . ("https://github.com/tree-sitter/tree-sitter-css"))
     (go . ("https://github.com/tree-sitter/tree-sitter-go"))
     (html . ("https://github.com/tree-sitter/tree-sitter-html"))
     (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript"))
     (json . ("https://github.com/tree-sitter/tree-sitter-json"))
     (ocaml . ("https://github.com/tree-sitter/tree-sitter-ocaml" "ocaml/src" "ocaml"))
     (python . ("https://github.com/tree-sitter/tree-sitter-python"))
     (php . ("https://github.com/tree-sitter/tree-sitter-php"))
     (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "typescript/src" "typescript"))
     (ruby . ("https://github.com/tree-sitter/tree-sitter-ruby"))
     (rust . ("https://github.com/tree-sitter/tree-sitter-rust"))
     (toml . ("https://github.com/tree-sitter/tree-sitter-toml"))))
  (defun nsh/treesit-install-all-languages ()
    (interactive)
    (let ((langs (mapcar 'car treesit-language-source-alist)))
      (dolist (lang langs)
	(treesit-install-language-grammar lang)))))

(use-package vc-hooks
  :ensure nil
  :custom
  (vc-follow-symlinks t))

(use-package warnings
  :ensure nil
  :custom
  (warning-minimum-level :error))

(use-package window
  :ensure nil
  :config
  (defun nsh/focus-other-window (&rest args)
    (other-window 1))
  (advice-add 'split-window-horizontally :after #'nsh/focus-other-window)
  (advice-add 'split-window-vertically :after #'nsh/focus-other-window))

(use-package winner-mode
  :ensure nil
  :bind (:map winner-mode-map
         ("C-c h" . winner-undo)
         ("C-c l" . winner-redo))
  :init
  (winner-mode 1))

(use-package xref
  :ensure nil
  :config
  (advice-add 'xref-go-back
              :after #'(lambda (&rest args) (recenter))))

;; Font

;; (set-frame-font "IBM Plex Mono:pixelsize=14" nil t)
(set-frame-font "monospace:pixelsize=13" nil t)

;; Dependencies: packages

(use-package blacken
  :ensure t
  :after python
  :hook ((python-base-mode . blacken-mode)))

(use-package bm
  :ensure t
  :bind (("C-M-;" . bm-toggle)
         ("C-M->" . bm-next)
         ("C-M-<" . bm-previous)))

(use-package browse-at-remote
  :ensure t
  :bind (("C-c m w" . browse-at-remote)))

;; M-x customize-variable chatgpt-shell-openai-key
(use-package chatgpt-shell
  :ensure t
  :hook ((chatgpt-shell-mode . visual-line-mode))
  :commands (chatgpt-shell)
  :init
  (global-set-key (kbd "C-h M-g") #'chatgpt-shell)
  :custom
  (chatgpt-shell-model-version 6))

(use-package consult
  :ensure t
  :bind (("C-x b" . consult-buffer)
	 ("M-g M-g" . consult-goto-line)
	 ("M-s M-l" . consult-line)
	 ("M-s M-j" . consult-imenu)
	 ("C-x r b" . consult-bookmark)
	 ("C-c r y" . consult-yank-pop)
	 ("M-y" . consult-yank-pop)
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)
         ("M-s e" . consult-isearch-history)
         ("M-s M-l" . consult-line)
         ("M-s L" . consult-line-multi))
  :custom
  (consult-async-min-input 3)
  (consult-ripgrep-args "rg --null --hidden --line-buffered --color=never --max-columns=1000 --path-separator / --smart-case --no-heading --line-number --no-column"))

(use-package consult-org-roam
  :ensure t
  :after org-roam
  :bind (("C-c j b" . consult-org-roam-backlinks)
         ("C-c j f" . consult-org-roam-file-find)
	 ("C-c j q" . consult-org-roam-search)
	 ("C-c j s" . consult-org-roam-search))
  :custom
  (consult-org-roam-grep-func #'consult-ripgrep))

(use-package corfu
  :ensure t
  :after orderless
  :hook ((prog-mode . corfu-mode))
  :custom
  (corfu-auto nil)
  (corfu-count 12)
  (corfu-cycle t)
  (corfu-echo-documentation t)
  (corfu-on-exact-match nil)
  (corfu-preselect-first t)
  (corfu-preview-current nil)
  (corfu-quit-at-boundary nil)
  (corfu-quit-no-match nil)
  (corfu-scroll-margin 5)
  (corfu-separator ?\s))

(use-package csv-mode
  :ensure t
  :mode ("\\.csv\\'" . csv-mode))

(use-package diminish
  :ensure t)

(use-package docker
  :ensure t
  :bind ("C-c d" . docker))

(use-package dockerfile-mode
  :ensure t)

(use-package eat
  :ensure t
  :bind ("C-c t" . eat))

(use-package edit-indirect
  :ensure t)

(use-package exec-path-from-shell
  :ensure t
  :hook ((after-init . exec-path-from-shell-initialize))
  :custom
  (exec-path-from-shell-variables '("PATH" "MANPATH" "GOPATH" "GOBIN")))

(use-package expand-region
  :ensure t
  :bind ("C-c ;" . er/expand-region)
  :custom ((expand-region-contract-fast-key "C-;")))

(use-package flymake-sqlfluff
  :ensure t
  :hook ((sql-mode . flymake-sqlfluff-load)))

(use-package jinja2-mode
  :ensure t)

(use-package json-mode
  :ensure t
  :mode ("\\.[json|tpl|asl]\\'" . json-mode)
  :config
  (setq js-indent-level 2))

(use-package magit
  :ensure t
  :bind (("C-c m b" . magit-blame-addition)
         ("C-c m L" . magit-log-buffer-file)
         ("C-c m d" . vc-root-diff)
         ("C-c m l" . magit-log-current)
         ("C-c m m" . magit-show-refs-head)
         ("C-c m s" . magit-status))
  :custom
  (magit-diff-refine-hunk t)
  :config
  (setq magit-status-buffer-switch-function 'switch-to-buffer)
  (advice-add 'magit-show-refs-head :after
	      #'(lambda (&rest args) (delete-other-windows)))
  (advice-add 'magit-status :before
	      #'(lambda (&rest args) (save-buffer)))
  (use-package magit-section
    :ensure t)
  (use-package transient
    :ensure t
    :custom
    (transient-default-level 5)))

(use-package marginalia
  :ensure t
  :after vertico
  :bind (:map minibuffer-local-map
	 ("M-A" . marginalia-cycle))
  :custom
  (marginalia-align 'right)
  :init
  (marginalia-mode))

(use-package markdown-mode
  :ensure t
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)))

(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-S-c C-S-a" . mc/mark-all-like-this))
  :config
  (setq mc/insert-numbers-default 1))

(use-package mwim
  :ensure t
  :bind (("C-a" . mwim-beginning-of-code-or-line)))

(use-package nodejs-repl
  :ensure t
  :commands (nodejs-repl-send-buffer
             nodejs-repl-send-last-expression
             nodejs-repl-send-line
             nodejs-repl-send-region
             nodejs-repl-switch-to-repl)
  :init
  (add-hook 'js-mode-hook
            #'(lambda ()
                (define-key js-mode-map (kbd "C-c C-c") #'nodejs-repl-send-line)
                (define-key js-mode-map (kbd "C-c C-e") #'nodejs-repl-send-last-expression)
                (define-key js-mode-map (kbd "C-c C-k") #'nodejs-repl-send-buffer)
                (define-key js-mode-map (kbd "C-c C-r") #'nodejs-repl-send-region)
                (define-key js-mode-map (kbd "C-c C-z") #'nodejs-repl-switch-to-repl))))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  :init
  (setq completion-category-defaults nil))

(use-package org-present
  :ensure t
  :bind (:map org-mode-map
         ("C-c M-p" . org-present)))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/.emacs.d/notes")
  (org-roam-completion-everywhere t)
  (org-roam-dailies-directory "~/.emacs.d/notes/dailies")
  :bind (("C-c j l" . org-roam-buffer-toggle)
	 ("C-c j j" . org-roam-node-find)
	 ("C-c j i" . org-roam-node-insert)
	 :map org-mode-map
	 ("C-M-i" . completion-at-point)
         :map org-roam-dailies-map
         ("T" . org-roam-dailies-capture-tomorrow)
         ("Y" . org-roam-dailies-capture-yesterday))
  :bind-keymap
  ("C-c j d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies)
  (org-roam-setup))

(use-package org-roam-ui
  :ensure t
  :after org-roam
  :bind (("C-c j u" . org-roam-ui-mode))
  :custom
  (org-roam-ui-follow t))

(use-package ox-pandoc
  :ensure t
  :custom
  (org-pandoc-options-for-gfm '((toc . nil)
				(wrap . "none"))))

(use-package password-generator
  :ensure t)

(use-package prettier-js
  :ensure t
  :hook ((js-mode . prettier-js-mode)))

(use-package python-isort
  :ensure t
  :after python
  :hook ((python-base-mode . python-isort-on-save-mode)))

(use-package pyvenv
  :ensure t
  :after python
  :bind (:map python-base-mode-map
         ("C-c v a" . pyvenv-activate)
         ("C-c v d" . pyvenv-deactivate)))

(use-package restclient
  :ensure t
  :mode ("\\.http\\'" . restclient-mode))

(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :hook ((after-init . smartparens-global-mode))
  :bind (("C-k" . sp-kill-hybrid-sexp)
         :map smartparens-mode-map
         ("C-(" . sp-forward-barf-sexp)
         ("C-)" . sp-forward-slurp-sexp)
         ("C-<left>" . sp-forward-barf-sexp)
         ("C-<left_bracket>" . sp-select-previous-thing)
         ("C-<right>" . sp-forward-slurp-sexp)
         ("C-M-<backspace>" . sp-splice-sexp-killing-backward)
         ("C-M-<delete>" . sp-splice-sexp-killing-forward)
         ("C-M-<left>" . sp-backward-slurp-sexp)
         ("C-M-<right>" . sp-backward-barf-sexp)
         ("C-M-]" . sp-select-next-thing)
         ("C-M-a" . sp-backward-down-sexp)
         ("C-M-b" . sp-backward-sexp)
         ("C-M-d" . sp-down-sexp)
         ("C-M-e" . sp-up-sexp)
         ("C-M-f" . sp-forward-sexp)
         ("C-M-k" . sp-kill-sexp)
         ("C-M-n" . sp-next-sexp)
         ("C-M-p" . sp-previous-sexp)
         ("C-M-t" . sp-transpose-sexp)
         ("C-M-u" . sp-backward-up-sexp)
         ("C-M-w" . sp-copy-sexp)
         ("C-S-<backspace>" . sp-splice-sexp-killing-around)
         ("C-S-a" . sp-end-of-sexp)
         ("C-S-d" . sp-beginning-of-sexp)
         ("C-\"" . sp-change-inner)
         ("C-]" . sp-select-next-thing-exchange)
         ("M-<backspace>" . sp-backward-unwrap-sexp)
         ("M-<delete>" . sp-unwrap-sexp)
         ("M-B" . sp-backward-symbol)
         ("M-D" . sp-splice-sexp)
         ("M-F" . sp-forward-symbol)
         ("M-i" . sp-change-enclosing)
         ("S-<left>" . sp-forward-barf-sexp)
         ("S-<right>" . sp-forward-slurp-sexp))
  :config
  (require 'smartparens-config))

(use-package sqlup-mode
  :ensure t
  :hook ((sql-interactive-mode . sqlup-mode)
         (sql-mode . sqlup-mode))
  :custom
  (sqlup-blacklist '("ref")))

(use-package terraform-mode
  :ensure t
  :mode ("\\.tf\\'" . terraform-mode))

(use-package typescript-mode
  :ensure t
  :mode ("\\.ts\\'" . typescript-mode))

(use-package vertico
  :ensure t
  :hook ((after-init . vertico-mode))
  :bind (("C-c r r" . vertico-repeat)
	 :map vertico-map
	 ("C-M-n" . vertico-next-group)
	 ("C-M-p" . vertico-previous-group)
         :map minibuffer-local-map
         ("C-<return>" . vertico-exit-input))
  :custom
  (vertico-scroll-margin 0)
  (vertico-resize nil)
  (vertico-count 10)
  (vertico-cycle t)
  (vertico-multiform-categories '((consult-grep buffer)
                                  (consult-location buffer)
                                  (consult-ripgrep buffer)
                                  (file grid reverse)
                                  (imenu buffer)
                                  (minor-mode reverse)
                                  (t reverse)))
  (vertico-multiform-commands '((consult-buffer unobtrusive)))
  :config
  (add-hook 'minibuffer-setup-hook #'vertico-repeat-save)
  (vertico-multiform-mode 1))

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :hook ((after-init . which-key-mode)))

(use-package yaml-mode
  :ensure t
  :mode (("\\.yml\\'" . yaml-mode)
         ("\\.yaml\\'" . yaml-mode)))

;; Print init time

(message (format "Init: %s" (emacs-init-time)))

;;; init.el ends here
