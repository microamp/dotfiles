(menu-bar-mode -1)  ;; hide menu bar
(tool-bar-mode -1)  ;; hide tool bar

;; disable automatic scrolling/re-centering
(setq-default scroll-step 1
              scroll-margin 0)

;; turn on font-lock mode to colour text in certain modes
(global-font-lock-mode t)

;; make sure spaces are used when indenting code
(setq-default indent-tabs-mode nil)

;; colour theme
(load-file "~/.emacs.d/themes/zenburn.el/zenburn.el")
(zenburn)

;; highlight current line
(global-hl-line-mode t)

;; colours
(custom-set-faces
 '(hl-line ((t (:background "gray25"))))
 '(linum ((t (:background "dim grey" :foreground "green"))))
)

;; erc
(require 'erc)
(erc-scrolltobottom-mode)
;;(erc :server "chat.freenode.net" :port 8002 :nick "microamp")

;; fill-column-indicator
(add-to-list 'load-path "~/.emacs.d/Fill-Column-Indicator/")
(require 'fill-column-indicator)
(setq-default fci-rule-column 80)
(setq-default fci-rule-color "yellow")

;; mode-specific hooks
(add-hook 'python-mode-hook 'fci-mode)
(add-hook 'python-mode-hook 'linum-mode)
