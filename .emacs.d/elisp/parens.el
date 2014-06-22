(require 'rainbow-delimiters)
(require 'highlight-parentheses)

;; rainbow-delimiters
(global-rainbow-delimiters-mode)

;; highlight-parentheses
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

(provide 'parens)
