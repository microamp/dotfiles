;; turn on font-lock mode to colour text in certain modes
(global-font-lock-mode t)

;; make sure spaces are used when indenting code
(setq-default indent-tabs-mode nil)

;; erc
(require 'erc)
;;(erc :server "chat.freenode.net" :port 8002 :nick "microamp")

;; org
(add-to-list 'load-path "/home/microamp/.emacs.d/elpa/org-20130729/")
(require 'org)

;; zenburn colour theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn t)

;; highlight current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "gray25")

;; fill-column-indicator
(add-to-list 'load-path "/home/microamp/.emacs.d/others/")
(require 'fill-column-indicator)
(add-hook 'python-mode-hook 'fci-mode)
(setq-default fci-rule-column 80)
(setq-default fci-rule-color "yellow")
