(require 'python-mode)
(require 'fill-column-indicator)
(eval-after-load "flymake" '(require 'flymake-cursor))
(eval-after-load "flymake" '(require 'flymake-python-pyflakes))
(require 'jedi)

;; turn on smart indentation
(setq py-smart-indentation t)

;; use IPython as default shell
(setq-default py-shell-name "ipython")

;; switch to interpreter after executing code
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)

;; fill column indicator
(setq-default fci-rule-column 79)
(setq-default fci-rule-color "yellow")

;; flake8 linting
(setq flymake-python-pyflakes-executable "flake8")

;; jedi (for auto-completion)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)
(jedi:install-server)

;; use indent-according-to-mode instead of py-indent-line
(define-key (current-global-map)
  [remap py-indent-line]
  'indent-according-to-mode)

;; python hooks
(add-hook 'python-mode-hook 'fci-mode)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'linum-mode)

(provide 'python)
