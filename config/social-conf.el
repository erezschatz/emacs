
;; IRC

(eval-after-load "erc"
'(progn
   (setq erc-autojoin-channels-alist
         '(("freenode.net" "#emacs")
           ("gnome.net" "#gnome-shell")))

   (erc-log-mode)
   (setq erc-log-channels-directory "~/.logs/")
   (setq erc-save-buffer-on-part t)))

(defun bitlbee ()
  "Connect to IM networks using bitlbee."
  (interactive)
  (erc :server "localhost" :port 6667 :nick "erez"))

;; twitter

(require 'twittering-mode)
(setq twittering-use-master-password t)
(twit)

(provide 'social-conf)
