(require 'magit)
;;(require 'git-blame)

;; full screen magit-status
;; http://whattheemacsd.com//setup-magit.el-01.html
;; This code makes magit-status run alone in the frame,
;; and then restores the old window configuration when you quit out of magit.

(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(define-key magit-status-mode-map (kbd "q") 'magit-quit-session)

;; http://whattheemacsd.com//setup-magit.el-02.html
;; This adds W to toggle ignoring whitespace in magit.
(defun magit-toggle-whitespace ()
  (interactive)
  (if (member "-w" magit-diff-options)
      (magit-dont-ignore-whitespace)
    (magit-ignore-whitespace)))

(defun magit-ignore-whitespace ()
  (interactive)
  (add-to-list 'magit-diff-options "-w")
  (magit-refresh))

(defun magit-dont-ignore-whitespace ()
  (interactive)
  (setq magit-diff-options (remove "-w" magit-diff-options))
  (magit-refresh))

(define-key magit-status-mode-map (kbd "W") 'magit-toggle-whitespace)

;; for some reason.
(setq magit-last-seen-setup-instructions "1.4.0")

(provide 'magit-conf)
