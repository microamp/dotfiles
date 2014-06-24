;; ***** erc settings *****
(require 'erc)
(eval-after-load 'erc '(require 'erc-hl-nicks))

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
(erc-hl-nicks-enable)

;; connect via erc
(defun erc-connect ()
  (interactive)
  (erc :server "chat.freenode.net" :port 8002 :nick "microamp"))

;; ***** rcirc settings *****
(require 'rcirc)
(eval-after-load 'rcirc '(require 'rcirc-color))
(eval-after-load 'rcirc '(require 'rcirc-notify))

;; nicks in low contrast (ref: http://www.emacswiki.org/emacs-zh-cn/rcircColoredNicks)
(defsubst circe-w3-contrast-c-to-l (c)
  (if (<= c 0.03928)
      (/ c 12.92)
    (expt (/ (+ c 0.055) 1.055) 2.4)))

(defsubst circe-w3-contrast-relative-luminance (rgb)
  (apply '+
         (cl-mapcar (lambda (color coefficient)
                      (* coefficient
                         (circe-w3-contrast-c-to-l color)))
                    rgb
                    '(0.2126 0.7152 0.0722))))

(defsubst circe-w3-contrast-contrast-ratio (color1 color2)
  (let ((l1 (+ 0.05 (circe-w3-contrast-relative-luminance color1)))
        (l2 (+ 0.05 (circe-w3-contrast-relative-luminance color2))))
    (if (> l1 l2)
        (/ l1 l2)
      (/ l2 l1))))

(defsubst circe-w3-contrast-rand ()
  (/ (random 42001) 42000.0))

(defsubst circe-w3-contrast-l-to-c (m)
  (if (<= m (/ 0.03928 12.92))
      (* m 12.92)
    (- (* (expt m (/ 1 2.4))
          1.055)
       0.055)))

(defsubst circe-w3-contrast-nn (n)
  (cond ((< n 0) 0)
        ((> n 1) 1)
        (t n)))

(defsubst circe-w3-contrast-color-with-luminance-higher-than (N)
  (let* ((Rc 0.2126)
         (Gc 0.7152)
         (Bc 0.0722)

         (R-min-lum (circe-w3-contrast-nn (/ (- N Gc Bc) Rc)))
         (R-min-color (circe-w3-contrast-l-to-c R-min-lum))
         (R-color (+ R-min-color (* (circe-w3-contrast-rand) (- 1 R-min-color))))
         (R-lum (* Rc (circe-w3-contrast-c-to-l R-color)))

         (G-min-lum (circe-w3-contrast-nn (/ (- N R-lum Bc) Gc)))
         (G-min-color (circe-w3-contrast-l-to-c G-min-lum))
         (G-color (+ G-min-color (* (circe-w3-contrast-rand) (- 1 G-min-color))))
         (G-lum (* Gc (circe-w3-contrast-c-to-l G-color)))

         (B-min-lum (circe-w3-contrast-nn (/ (- N R-lum G-lum) Bc)))
         (B-min-color (circe-w3-contrast-l-to-c B-min-lum))
         (B-color (+ B-min-color (* (circe-w3-contrast-rand) (- 1 B-min-color))))
         (B-lum (* Bc (circe-w3-contrast-c-to-l B-color))))
    (list R-color G-color B-color)))

(defsubst circe-w3-contrast-color-with-luminance-lower-than (N)
  (let* ((Rc 0.2126)
         (Gc 0.7152)
         (Bc 0.0722)

         (R-max-lum (circe-w3-contrast-nn (/ N Rc)))
         (R-max-color (circe-w3-contrast-l-to-c R-max-lum))
         (R-color (* R-max-color (circe-w3-contrast-rand)))
         (R-lum (* Rc (circe-w3-contrast-c-to-l R-color)))

         (G-max-lum (circe-w3-contrast-nn (/ (- N R-lum) Gc)))
         (G-max-color (circe-w3-contrast-l-to-c G-max-lum))
         (G-color (* G-max-color (circe-w3-contrast-rand)))
         (G-lum (* Gc (circe-w3-contrast-c-to-l G-color)))

         (B-max-lum (circe-w3-contrast-nn (/ (- N R-lum G-lum) Bc)))
         (B-max-color (circe-w3-contrast-l-to-c B-max-lum))
         (B-color (* B-max-color (circe-w3-contrast-rand)))
         (B-lum (* Bc (circe-w3-contrast-c-to-l B-color))))
    (list R-color G-color B-color)))

(defsubst circe-w3-contrast-generate-contrast-color (color ratio)
  (let ((color-lum (circe-w3-contrast-relative-luminance color)))
    (if (< color-lum (- (/ 1.0 ratio) 0.05))
        (circe-w3-contrast-color-with-luminance-higher-than (+ (* (+ color-lum 0.05) ratio) 0.05))
      (circe-w3-contrast-color-with-luminance-lower-than (- (/ (+ color-lum 0.05) ratio) 0.05)))))

(defsubst circe-color-from-values (values)
  (apply 'concat
         (cons "#"
               (mapcar (lambda (val)
                         (format "%02x"
                                 (* (cond ((< val 0) 0)
                                          ((> val 1) 1)
                                          (t val))
                                    255)))
                       values))))

(setq rcirc-colors
      (let (colors)
        (dotimes (n 200)
          (setq colors
                (cons (circe-color-from-values
                       (circe-w3-contrast-generate-contrast-color
                        (mapcar (lambda (x) (/ x 65535.0))
                                (color-values (face-background 'default)))
                        7))
                      colors)))
        colors))

;; server list
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

;; turn on notification tracking
(rcirc-track-minor-mode 1)

;; connect via rcirc
;(rcirc nil)

(provide 'chat)
