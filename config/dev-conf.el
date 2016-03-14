;;; dev-conf.el --- Summary
;; Language modules
;;; Commentary:
;;; Code:

;; c
(defvar c-basic-offset)
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
(setq inferior-lisp-program "/usr/bin/sbcl")

(require 'slime)
(slime-setup)

;; assembly

(if (eq system-type 'gnu/linux)
    (progn
      (require 'gas-mode)
      (add-to-list 'auto-mode-alist '("\\.a?[sS]\\'" . gas-mode))))

;; git
(require 'magit-conf)

;; auctex

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

;; flycheck
(require 'let-alist)
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; php
(require 'php-mode)
(add-hook 'php-mode-hook 'php-enable-psr2-coding-style)
(add-hook 'php-mode-hook
          (lambda()
            (linum-mode t)))

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; erlang

(add-to-list 'load-path "/usr/lib/erlang/lib/tools-2.8.2/emacs/")
(setq erlang-root-dir "/usr/local/erlang")
(setq exec-path (cons "/usr/local/otp/erlang" exec-path))
(require 'erlang-start)

;; restclient
(require 'restclient)

;; R
(require 'ess-site)

(provide 'dev-conf)
;;; dev-conf ends here
