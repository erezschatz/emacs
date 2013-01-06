;;Invoke M-x without the Alt key
(global-set-key "\C-x\C-m" 'execute-extended-command)

;;Prefer backward-kill-word over Backspace
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;; override buffer menu
(global-set-key (kbd "C-x C-b") 'ibuffer)

;;prevent suspend-frame
(global-unset-key (kbd "C-z"))

(provide 'key-binding)
