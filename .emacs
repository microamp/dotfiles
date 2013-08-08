(menu-bar-mode -1)  ;; hide menu bar
(tool-bar-mode -1)  ;; hide tool bar

;; packages
(require 'package)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))

;; disable automatic scrolling/re-centering
(setq-default scroll-step 1
              scroll-margin 0)

;; turn on font-lock mode to colour text in certain modes
(global-font-lock-mode t)

;; make sure spaces are used when indenting code
(setq-default indent-tabs-mode nil)

;; colours
(custom-set-faces
 '(hl-line ((t (:background "gray25"))))
 '(linum ((t (:background "gray20" :foreground "yellow"))))
)

;; colour theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/zenburn-theme-20130716.1457/")
(load-theme 'zenburn t)

;; highlight current line
(global-hl-line-mode t)

;; erc
(require 'erc)
(erc-scrolltobottom-mode)
;;(erc :server "chat.freenode.net" :port 8002 :nick "microamp")

;; fill-column-indicator
(add-to-list 'load-path "~/.emacs.d/elpa/fill-column-indicator-20130126.1540/")
(require 'fill-column-indicator)
(setq-default fci-rule-column 79)
(setq-default fci-rule-color "yellow")

;; ido
(require 'ido)
(ido-mode t)

;; autopair
(add-to-list 'load-path "~/.emacs.d/elpa/autopair-20121123.1829/")
(require 'autopair)
(autopair-global-mode)

;; flymake-python-pyflakes
(add-to-list 'load-path "~/.emacs.d/elpa/flymake-cursor-20121220.957/")
(add-to-list 'load-path "~/.emacs.d/elpa/flymake-easy-20130610.1705/")
(eval-after-load "flymake"
  '(require 'flymake-cursor))
(add-to-list 'load-path "~/.emacs.d/elpa/flymake-python-pyflakes-20130730.131/")
(require 'flymake-python-pyflakes)
(setq flymake-python-pyflakes-executable "flake8")

;; ipython
(setq py-shell-name "ipython")

;; mode-specific hooks
(add-hook 'python-mode-hook 'fci-mode)
(add-hook 'python-mode-hook 'linum-mode)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
(add-hook 'python-mode-hook
          '(lambda () (define-key python-mode-map "\C-m" 'newline-and-indent)))
