;; ***** erc settings *****
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
(eval-after-load 'erc '(require 'erc-hl-nicks))
(erc-hl-nicks-enable)

;; connect via erc
(defun erc-connect ()
  (interactive)
  (erc :server "chat.freenode.net" :port 8002 :nick "microamp"))

;; ***** rcirc settings *****
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

;; use the maximum frame width for line-wrapping
(setq rcirc-fill-column (quote frame-width))

;; include date in time stamp.
(setq rcirc-time-format "[%H:%M] ")

;; set coloured nicks
(eval-after-load 'rcirc '(require 'rcirc-color))

(eval-after-load 'rcirc '(require 'rcirc-notify))

;; turn on notification tracking
(rcirc-track-minor-mode 1)

;; connect via rcirc
;(rcirc nil)

(provide 'chat)
