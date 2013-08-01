;; turn on font-lock mode to colour text in certain modes
(global-font-lock-mode t)

;; make sure spaces are used when indenting code
(setq-default indent-tabs-mode nil)

;; erc
(add-to-list 'load-path "/usr/share/emacs/site-lisp/erc/")
(require 'erc)
;;(erc :server "chat.freenode.net" :port 8002 :nick "microamp")

;; org
(add-to-list 'load-path "/usr/share/emacs/site-lisp/org/")
(require 'org-loaddefs)

;; zenburn colour theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn t)
