(require 'cl-lib)

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
  (let ((process-list ())) ad-do-it))
(setq confirm-kill-emacs 'yes-or-no-p)

;;keyboard remapping

(require 'key-binding)

;;helper modules

;;Distinguish buffers of the same filename
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;;tramp - Transparent Remote (file) Access, Multiple Protocol
(require 'tramp)

;; frame commands

(require 'fit-frame)
(setq fit-frame-min-width 82)
(setq fit-frame-min-height 35)
(add-hook 'after-make-frame-functions 'fit-frame)

(defun run-command-other-frame (command)
  "Run COMMAND in a new frame."
  (interactive "CC-x 5 M-x ")
  (select-frame (new-frame))
  (call-interactively command)
  (fit-frame))
(global-set-key "\C-x5\M-x" 'run-command-other-frame)

;; highlight 80th column
(require 'fill-column-indicator)

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
(setq inferior-lisp-program "/usr/bin/sbcl")

(require 'slime)
(slime-setup)

;; auctex
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

;; development tools modules

;; git
(require 'magit-conf)

;; org-mode
(require 'org-mode-conf)

;; IRC, IM and twitter

;;(require 'social-conf)

;; Server, Shell, Browser

(unless (fboundp 'server-running-p)
  (server-start))

;; shell
(require 'shell-switcher)
(setq shell-switcher-mode t)

;; opens shell for switcher
(shell-switcher-switch-buffer)

(add-hook 'eshell-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c h")
                           (lambda ()
                             (interactive)
                             (insert
                              (ido-completing-read
                               "Eshell history: "
                               (delete-dups
                                (ring-elements eshell-history-ring))))))
            (local-set-key (kbd "C-c C-h") 'eshell-list-history)))

;; because I'm lazy to reformat these

(custom-set-variables)

(custom-set-faces
 '(cperl-hash-face
   ((t (:background "navy" :foreground "Red" :weight bold))))
 '(hl-line
((t (:inverse-video t)))))
