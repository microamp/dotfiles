(require 'smtpmail)

(setq smtpmail-debug-info t)

(setq user-mail-address "microamp@lavabit.com")
(setq mail-host-address "lavabit.com")

(setq gnus-message-archive-group  
      '((concat "sent-" (format-time-string "%Y-%B" (current-time)))))

;; imap settings
(setq gnus-select-method
      '(nnimap "lavabit"
        (nnimap-address "lavabit.com")
        (nnimap-server-port 993)
        (nnimap-stream ssl)))

;; smtp settings
(setq send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("lavabit.com" 3535 nil nil))
      smtpmail-auth-credentials (expand-file-name "~/.authinfo")
      smtpmail-default-smtp-server "lavabit.com"
      smtpmail-smtp-server "lavabit.com"
      smtpmail-smtp-service 3535)
