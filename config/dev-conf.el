;; Language modules

;; c
(setq c-basic-offset 8)

;; perl
(require 'cperl-conf)

;; javascript
(require 'json)
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$\\'" . js2-mode))

(add-hook 'js-mode-hook
          (lambda()
            (linum-mode t)))

(add-hook 'js2-mode-hook
          (lambda()
            (linum-mode t)))

(setq js2-basic-offset 4)

;; slime
;;(setq inferior-lisp-program "/usr/bin/sbcl")

;;(require 'slime)
;;(slime-setup)

;; assembly
(require 'gas-mode)
(add-to-list 'auto-mode-alist '("\\.a?[sS]\\'" . gas-mode))

;; git
(require 'magit-conf)

(provide 'dev-conf)
