;;Invoke M-x without the Alt key
(global-set-key "\C-x\C-m" 'execute-extended-command)

;; override buffer menu
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; force tab
(global-set-key (kbd "C-<tab>") 'tab-to-tab-stop)

;; alt-~ like in gnome-shell
(if (eq system-type 'windows-nt)
    (global-set-key (kbd "M-`") 'other-frame))

;;prevent suspend-frame
(global-unset-key (kbd "C-z"))

;;(keyboard-translate ?\C-x ?\C-u)
;;(keyboard-translate ?\C-u ?\C-x)

(global-set-key (kbd "M-s") 'lookup-word-definition)

(provide 'key-binding)
