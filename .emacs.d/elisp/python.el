;; fill-column-indicator
(require 'fill-column-indicator)
(setq-default fci-rule-column 79)
(setq-default fci-rule-color "yellow")

;; flymake-python-pyflakes
(eval-after-load "flymake" '(require 'flymake-cursor))
(require 'flymake-python-pyflakes)
(setq flymake-python-pyflakes-executable "flake8")

;; jedi (auto-completion)
(require 'jedi)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)

;; python hooks
(add-hook 'python-mode-hook 'fci-mode)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'linum-mode)

(provide 'python)
