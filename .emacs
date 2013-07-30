;; Turn on font-lock mode to colour text in certain modes
(global-font-lock-mode t)

;; Make sure spaces are used when indenting code
(setq-default indent-tabs-mode nil)

;; erc
(add-to-list 'load-path "/usr/share/emacs/site-lisp/erc/")
(require 'erc)

;; org-mode
(add-to-list 'load-path "/usr/share/emacs/site-lisp/org/")
(require 'org-loaddefs)
