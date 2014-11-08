(require 'rcirc)
(eval-after-load 'rcirc '(require 'rcirc-color))
(eval-after-load 'rcirc '(require 'rcirc-notify))

;; server list
(setq rcirc-server-alist
      '(;("chat.freenode.net"
        ; :port 8002
        ; :nick "microamp"
        ; :channels ("#emacs #clojure #hy"))
        ("localhost"
         :port 6667
         :nick "microamp"
         :channels ("#microamp"))))

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

;; turn on notification tracking
(rcirc-track-minor-mode 1)

;; connect via rcirc
(global-set-key (kbd "C-c I") 'irc)

(provide 'microamp-chat)
