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

;; remove trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

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

;; hide password in shell mode
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

;; doc-view-mode: continuous navigation via C-n/C-p
(setq-default doc-view-continuous 1)

;; colours
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "gray25"))))
 '(linum ((t (:background "black" :foreground "gray50")))))

;; colour theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/zenburn-theme-20140309.2358/")
(load-theme 'zenburn t)

;; highlight current line
(global-hl-line-mode t)

;; rainbow-delimiters
(add-to-list 'load-path "~/.emacs.d/elpa/rainbow-delimiters-20130307.340/")
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)

;; highlight-parentheses
(add-to-list 'load-path "~/.emacs.d/elpa/highlight-parentheses-20130523.1752/")
(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;; erc settings
(require 'erc)
(erc-scrolltobottom-mode)
(setq erc-timestamp-format-left nil)
(setq erc-timestamp-format-right "[%H:%M]")
;; column length depending on window size
(make-variable-buffer-local 'erc-fill-column)
(add-hook 'window-configuration-change-hook
          '(lambda ()
             (save-excursion
               (walk-windows
                (lambda (w)
                  (let ((buffer (window-buffer w)))
                    (set-buffer buffer)
                    (when (eq major-mode 'erc-mode)
                      (setq erc-fill-column (- (window-width w) 2)))))))))

;; erc: highlight nicks
(add-to-list 'load-path "~/.emacs.d/elpa/erc-hl-nicks-20130114.1648/")
(require 'erc-hl-nicks)
(erc-hl-nicks-enable)

;; connect via erc
;(erc :server "chat.freenode.net" :port 8002 :nick "microamp")

;; rcirc settings
(setq rcirc-server-alist
      '(("chat.freenode.net"
         :port 8002
         :nick "microamp"
         :channels ("#emacs #clojure #hy"))))

;; don't print /away messages
(defun rcirc-handler-301 (process cmd sender args)
  "/away message handler.")

;; keep input line at bottom
(add-hook 'rcirc-mode-hook
          (lambda ()
            (set (make-local-variable 'scroll-conservatively)
                 8192)))

;; adjust the colours of one of the faces.
(set-face-foreground 'rcirc-my-nick "red" nil)

;; use the maximum frame width for line-wrapping
(setq rcirc-fill-column (quote frame-width))

;; include date in time stamp.
(setq rcirc-time-format "[%Y-%m-%d %H:%M] ")

;; set colours
(setq rcirc-colors '("red" "green" "yellow" "blue" "magenta" "cyan" "white"
                     "color-81" "color-109" "color-172" "color-220"))

;; set coloured nicks
(add-to-list 'load-path "~/.emacs.d/elpa/rcirc-color-20140131.656/")
(eval-after-load 'rcirc '(require 'rcirc-color))

(add-to-list 'load-path "~/.emacs.d/elpa/rcirc-notify-20130905.203/")
(eval-after-load 'rcirc '(require 'rcirc-notify))

;; connect via rcirc
;;(rcirc nil)

;; fill-column-indicator
(add-to-list 'load-path "~/.emacs.d/elpa/fill-column-indicator-20130126.1540/")
(require 'fill-column-indicator)
(setq-default fci-rule-column 79)
(setq-default fci-rule-color "yellow")
(add-hook 'python-mode-hook 'fci-mode)

;; ido
(require 'ido)
(ido-mode t)

;; flymake-python-pyflakes
(add-to-list 'load-path "~/.emacs.d/elpa/flymake-cursor-20121220.957/")
(add-to-list 'load-path "~/.emacs.d/elpa/flymake-easy-20130610.1705/")
(eval-after-load "flymake"
  '(require 'flymake-cursor))
(add-to-list 'load-path "~/.emacs.d/elpa/flymake-python-pyflakes-20130730.131/")
(require 'flymake-python-pyflakes)
(setq flymake-python-pyflakes-executable "flake8")
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

;; jedi (auto-completion)
(add-to-list 'load-path "~/.emacs.d/elpa/epc-20130804.1428/")
(add-to-list 'load-path "~/.emacs.d/elpa/deferred-20130523.1007/")
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-20130724.1750/")
(add-to-list 'load-path "~/.emacs.d/elpa/jedi-20130714.1415/")
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)

;; other python hooks
(add-hook 'python-mode-hook 'linum-mode)
(add-hook 'python-mode-hook 'electric-pair-mode)

;; s
(add-to-list 'load-path "~/.emacs.d/elpa/s-20130820.1601")
(require 's)

;; clojure-mode
(add-to-list 'load-path "~/.emacs.d/elpa/clojure-mode-20130911.542")
(require 'clojure-mode)

;; dash
(add-to-list 'load-path "~/.emacs.d/elpa/dash-20130831.2329")
(require 'dash)

;; pkg-info
(add-to-list 'load-path "~/.emacs.d/elpa/pkg-info-20130817.2334")
(require 'pkg-info)

;; paredit
(add-to-list 'load-path "~/.emacs.d/elpa/paredit-20130722.1324/")
(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code."
  t)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook 'enable-paredit-mode)
(add-hook 'clojure-mode-hook 'enable-paredit-mode)
(add-hook 'hy-mode-hook 'enable-paredit-mode)

;; cider
(add-to-list 'load-path "~/.emacs.d/elpa/cider-20131204.1757")
(require 'cider)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t)
(setq cider-repl-tab-command 'indent-for-tab-command)
(setq cider-repl-pop-to-buffer-on-connect nil)
(setq cider-popup-stacktraces nil)
(setq cider-repl-popup-stacktraces t)
(setq cider-auto-select-error-buffer t)
(setq nrepl-buffer-name-separator "-")
(setq nrepl-buffer-name-show-port t)
(setq cider-repl-display-in-current-window t)
(setq cider-repl-wrap-history t)
(setq cider-repl-history-size 1000) ; the default is 500
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'nrepl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'enable-paredit-mode)
