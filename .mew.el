(setq mew-proto "%")
(setq mew-name "James Sangho Nah")
(setq mew-user "sangho.nah")
(setq mew-mail-domain "gmail.com")

(setq mew-imap-server "imap.gmail.com")
(setq mew-imap-ssl-port "993")
(setq mew-imap-user "sangho.nah@gmail.com")
(setq mew-imap-auth t)
(setq mew-imap-ssl t)

(setq mew-smtp-server "smtp.gmail.com")
(setq mew-smtp-ssl-port "465")
(setq mew-smtp-user "sangho.nah@gmail.com")
(setq mew-smtp-auth t)
(setq mew-smtp-ssl t)

(setq mew-use-unread-mark t)

(setq mew-biff-interval 1)
(setq mew-use-biff t)
(setq mew-use-biff-bell t)
(setq mew-passwd-timer-unit 60)
(setq mew-passwd-lifetime 8)

(setq mew-summary-form '(type " [" (4 year) "-" (5 date) " " (5 time) "] | " (30 from) " | " t (0 subj)))
(setq mew-summary-form-extract-rule '(address))

(defun mew-summary-form-date ()
  "A function to return a date, MM-DD."
  (let ((s (MEW-DATE)))
    (when (or (string= s "")
              (not (string-match mew-time-rfc-regex s)))
      (setq s (mew-time-ctz-to-rfc
               (mew-file-get-time (mew-expand-msg (MEW-FLD) (MEW-NUM))))))
    (if (string-match mew-time-rfc-regex s)
      (format "%02d-%02d"
              (mew-time-mon-str-to-int (mew-time-rfc-mon))
              (mew-time-rfc-day))
      "")))

(setq mew-ssl-verify-level 0)

(setq mew-use-cached-passwd t)
