;;; package --- Summary

;;; Commentary:

;; IRC

;;; Code:

(defvar erc-log-channels-directory)
(defvar erc-save-buffer-on-part)
(defvar smtpmail-smtp-service)
(defvar smtpmail-smtp-server)

(eval-after-load "erc"
'(progn
;;   (setq erc-autojoin-channels-alist
;;         '(("freenode.net" "#emacs")
;;           ("gnome.net" "#gnome-shell")))

   (erc-log-mode)
   (setq erc-log-channels-directory "~/.log/erc")
   (setq erc-save-buffer-on-part t)))

(defun bitlbee ()
  "Connect to IM networks using bitlbee."
  (interactive)
  (erc :server "localhost" :port 6667 :nick "erez"))

;; twitter

;;(require 'twittering-mode)
;;(setq twittering-use-master-password t)

;;(setq twittering-initial-timeline-spec-string
;;      '(":replies"))

;; (add-hook 'twittering-edit-mode-hook
;;           (lambda ()
;;             (ispell-minor-mode) (flyspell-mode)))

;;(twit)

;; GNUS

(setq send-mail-function (quote smtpmail-send-it))
(setq smtpmail-smtp-server "smtp.googlemail.com")
(setq smtpmail-smtp-service 587)

(provide 'social-conf)

;;; social-conf.el ends here
