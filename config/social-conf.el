;;; package --- Summary

;;; Commentary:

;; IRC

;;; Code:

(defvar erc-log-channels-directory)
(defvar erc-save-buffer-on-part)

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

(defvar smtpmail-smtp-service)
(defvar smtpmail-smtp-server)
(defvar gnus-ignored-newsgroups)
(defvar gnus-select-method)

(setq send-mail-function (quote smtpmail-send-it))
(setq smtpmail-smtp-server "smtp.googlemail.com")
(setq smtpmail-smtp-service 587)

(setq gnus-select-method
      '(nnimap "gmail"
	       (nnimap-address "imap.gmail.com")
	       (nnimap-server-port "imaps")
	       (nnimap-stream ssl)))

(setq smtpmail-smtp-service 587
      gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

(provide 'social-conf)

;;; social-conf.el ends here
