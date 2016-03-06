;;; package --- Summary

;;; Commentary:

;; IRC

;;; Code:

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

(provide 'social-conf)

;;; social-conf.el ends here
