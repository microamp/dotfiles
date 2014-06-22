(require 'python-mode)
(require 'fill-column-indicator)
(eval-after-load "flymake" '(require 'flymake-cursor))
(eval-after-load "flymake" '(require 'flymake-python-pyflakes))
(require 'jedi)

;; fill-column-indicator
(setq-default fci-rule-column 79)
(setq-default fci-rule-color "yellow")

;; flymake-python-pyflakes
(setq flymake-python-pyflakes-executable "flake8")

;; jedi (auto-completion)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)
;(jedi:install-server)

;; python hooks
(add-hook 'python-mode-hook 'fci-mode)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'linum-mode)
(add-hook 'python-mode-hook (lambda nil (jedi:install-server)))

(provide 'python)
