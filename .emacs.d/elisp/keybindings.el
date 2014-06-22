;; map RET to newline-and-indent
(define-key global-map (kbd "RET") 'newline-and-indent)

;; map M-N to other-window
(define-key global-map (kbd "M-N") 'other-window)
(define-key global-map (kbd "M-P") 'previous-multiframe-window)

;; map C-x s to open (multi-)eshell
(define-key global-map (kbd "C-x s") 'multi-eshell)
(define-key global-map (kbd "M-SPC") 'multi-eshell-switch)

;; Focus the new window after split
(global-set-key "\C-x2" (lambda ()
                          (interactive)
                          (split-window-below)
                          (other-window 1)))
(global-set-key "\C-x3" (lambda ()
                          (interactive)
                          (split-window-right)
                          (other-window 1)))

(provide 'keybindings)
