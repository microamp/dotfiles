(menu-bar-mode -1)  ;; hide menu bar
(tool-bar-mode -1)  ;; hide tool bar

;; disable automatic scrolling/re-centering
(setq scroll-step 1
      scroll-margin 0)

;; turn on font-lock mode to colour text in certain modes
(global-font-lock-mode t)

;; make sure spaces are used when indenting code
(setq-default indent-tabs-mode nil)

;; zenburn colour theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn t)

;; highlight current line
(global-hl-line-mode t)
(set-face-background 'hl-line "gray25")

;; erc
(require 'erc)
(erc-scrolltobottom-mode t)
;;(erc :server "chat.freenode.net" :port 8002 :nick "microamp")

;; fill-column-indicator
(add-to-list 'load-path "/home/microamp/.emacs.d/fill-column-indicator/")
(require 'fill-column-indicator)
(setq-default fci-rule-column 80)
(setq-default fci-rule-color "yellow")

;; mode-specific hooks
(add-hook 'python-mode-hook 'fci-mode)
(add-hook 'python-mode-hook 'linum-mode)
