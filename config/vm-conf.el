(require 'vm-autoloads)

(setq
 mail-signature t
 mail-signature-file "~/.signature"
 message-send-mail-function 'smtpmail-send-it
 send-mail-function 'smtpmail-send-it
 smtpmail-auth-credentials (expand-file-name "~/.authinfo")
 smtpmail-debug-info t
 smtpmail-default-smtp-server "smtp.gmail.com"
 smtpmail-smtp-server "smtp.gmail.com"
 smtpmail-smtp-service 587
 smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
 starttls-use-gnutls t
 vm-enable-external-messages '(imap)
 vm-folder-directory "~/mail"
 vm-imap-folder-cache-directory "~/mail/cache"
 vm-imap-max-message-size 512
 vm-mime-attachment-save-directory "~/mail/tmp"
 vm-mutable-frames nil
 vm-mutable-windows nil
 vm-pop-folder-cache-directory "~/mail/cache"
 vm-preview-lines nil
 vm-primary-inbox "~/mail/inbox"
 vm-stunnel-program "/usr/bin/stunnel"

 vm-imap-account-alist
 '(
   ("imap-ssl:imap.googlemail.com:993:inbox:login:moonbuzz@gmail.com:*" "gmail")
   )
 )

(provide 'vm-conf)
