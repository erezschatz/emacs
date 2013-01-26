(require 'cl)

;; no tool bar, no menu bar, no scrollbar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; X system only
(if window-system
    (progn
      ;; set default font
      (set-face-attribute 'default nil
                          :font "Terminus"
                          :height 80
                          :background "black"
                          :foreground "white")
      (set-face-attribute 'tooltip nil :font "Terminus" :height 80)))

;; don't display the intro page
(setq inhibit-default-init nil)
(setq inhibit-startup-screen t)

;; highlight current line
(global-hl-line-mode t)

;; disable tabs
(setq-default indent-tabs-mode nil)

;; set title to buffer name
(setq frame-title-format "%b")

;; set mode-line to current file name
(setq mode-line-format "%f ")

;; show line and column number in bottom
(setq line-number-mode t)
(setq column-number-mode t)

;; turn on paren match highlighting
(show-paren-mode 1)

;; allow upcase/downcase region
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; save all backups in the temp folder
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-`((".*" ,temporary-file-directory t)))

;; set emerge to ignore whitespace diff
(setq emerge-diff-options "--ignore-all-space")

;; delete trailing whitespaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; automatically revert buffer
(global-auto-revert-mode t)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

(autoload 'ibuffer "ibuffer" "List buffers." t)

;; try to kill emacs in most straightforward way possible
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying Active processes exist query when you quit Emacs."
  (flet ((process-list ())) ad-do-it))
(setq confirm-kill-emacs 'yes-or-no-p)

;;keyboard remapping

(require 'key-binding)

;;helper modules

;;Distinguish buffers of the same filename
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;;tramp - Transparent Remote (file) Access, Multiple Protocol
(require 'tramp)

(require 'fit-frame)
(add-hook 'after-make-frame-functions 'fit-frame)

;; highlight 80th column
(require 'fill-column-indicator)

;; Language modules

;; c

(setq c-basic-offset 8)

;; perl

(require 'cperl-conf)

;; javascript
(require 'json)

(add-hook 'js-mode-hook
          (lambda()
            (linum-mode t)))

;; php
(load-file "~/emacs/site-lisp/php-mode-improved.el")
(require 'php-mode)
(require 'mmm-mode)

;; slime
(setq inferior-lisp-program "/usr/bin/sbcl")

(require 'slime)
(slime-setup)

;; android development

(require 'android-mode)
(setq android-mode-sdk-dir "~/dev/adt-bundle-linux-x86/sdk/")
(add-hook 'gud-mode-hook
          (lambda ()
            (add-to-list
             'gud-jdb-classpath
             "~/dev/adt-bundle-linux-x86/sdk/platforms/android-17/android.jar")))

;; auctex
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

;; development tools modules

;; full-ack
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)
(setq ack-executable (executable-find "/home/erez/perl5/bin/ack"))
(global-set-key (kbd "\C-x\C-a") 'ack)

;; git
(require 'magit-conf)

;; org-mode
(require 'org-mode-conf)

(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)

;; IRC

(eval-after-load "erc"
'(progn
   (setq erc-autojoin-channels-alist
         '(("freenode.net" "#emacs" "#plan9" "#archlinux")
           ("gnome.net" "#gnome-shell")))

   (erc-log-mode)
   (setq erc-log-channels-directory "~/.logs/")
   (setq erc-save-buffer-on-part t)))

(unless (server-running-p)
  (server-start))

(eshell)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cperl-hash-face ((t (:background "navy" :foreground "Red" :weight bold))))
 '(hl-line ((t (:inverse-video t)))))
