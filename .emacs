;; packages
(require 'package)
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))

(require 'cl)
(defvar packages-list
  '(rainbow-delimiters
    zenburn-theme
    highlight-parentheses
    erc-hl-nicks
    rcirc-color
    rcirc-notify
    fill-column-indicator
    mew
    flymake-cursor
    flymake-easy
    flymake-python-pyflakes
    epc
    deferred
    auto-complete
    jedi
    s
    clojure-mode
    dash
    pkg-info
    paredit
    multi-eshell
    cider
    w3m
    starter-kit
    starter-kit-eshell
    starter-kit-lisp)
  "List of packages needs to be installed at launch")

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

(menu-bar-mode -1)  ;; hide menu bar
(tool-bar-mode -1)  ;; hide tool bar

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
 '(hl-line ((t (:background "gray25"))))
 '(linum ((t (:background "black" :foreground "gray50")))))

;; colour theme
(load-theme 'zenburn t)

;; highlight current line
(global-hl-line-mode t)

;; rainbow-delimiters
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)

;; highlight-parentheses
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
(eval-after-load 'rcirc '(require 'rcirc-color))

(eval-after-load 'rcirc '(require 'rcirc-notify))

;; turn on notification tracking
(rcirc-track-minor-mode 1)

;; connect via rcirc
;;(rcirc nil)

;; mew configs
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)

;; optional setup ('Read Mail' menu):
(setq read-mail-command 'mew)

;; optional setup (e.g. C-xm for sending a message):
(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'mew-user-agent
      'mew-user-agent-compose
      'mew-draft-send-message
      'mew-draft-kill
      'mew-send-hook))

;; fill-column-indicator
(require 'fill-column-indicator)
(setq-default fci-rule-column 79)
(setq-default fci-rule-color "yellow")

;; ido
(require 'ido)
(ido-mode t)

;; flymake-python-pyflakes
(eval-after-load "flymake" '(require 'flymake-cursor))
(require 'flymake-python-pyflakes)
(setq flymake-python-pyflakes-executable "flake8")

;; jedi (auto-completion)
(require 'jedi)

(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)

;; other python hooks

;; s
(require 's)

;; clojure-mode
(require 'clojure-mode)

;; dash
(require 'dash)

;; pkg-info
(require 'pkg-info)

;; paredit
(require 'paredit)
(autoload 'enable-paredit-mode "paredit" t)

;; cider
(require 'cider)
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

;; paredit hooks for lisp
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook 'enable-paredit-mode)
(add-hook 'clojure-mode-hook 'enable-paredit-mode)
(add-hook 'hy-mode-hook 'enable-paredit-mode)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'nrepl-mode-hook 'paredit-mode)

;; python hooks
(add-hook 'python-mode-hook 'fci-mode)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'linum-mode)
(add-hook 'python-mode-hook 'electric-pair-mode)
