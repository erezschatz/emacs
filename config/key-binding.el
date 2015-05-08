;;Invoke M-x without the Alt key
(global-set-key "\C-x\C-m" 'execute-extended-command)

;; override buffer menu
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; force tab
(global-set-key (kbd "C-<tab>") 'tab-to-tab-stop)

;;prevent suspend-frame
(global-unset-key (kbd "C-z"))

(keyboard-translate ?\C-x ?\C-u)
(keyboard-translate ?\C-u ?\C-x)

(global-set-key (kbd "M-s") 'lookup-word-definition)

(provide 'key-binding)
