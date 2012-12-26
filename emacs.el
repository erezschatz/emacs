(require 'cl)

;;no tool bar, no menu bar, no scrollbar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;;X system only
(if window-system
    (progn
      ;;set default font
      (set-face-attribute 'default nil
                          :font "Terminus"
                          :height 80
                          :background "black"
                          :foreground "white")
      (set-face-attribute 'tooltip nil :font "Terminus" :height 80)))

(setq confirm-kill-emacs 'yes-or-no-p)

;;highlight current line
(global-hl-line-mode t)

;;disable tabs
(setq-default indent-tabs-mode nil)

;;set title to buffer name
(setq frame-title-format "%b")

;;set mode-line to current file name
(setq mode-line-format "%f ")

;;show line and column number in bottom
(setq line-number-mode t)
(setq column-number-mode t)

;;turn on paren match highlighting
(show-paren-mode 1)

;;allow upcase/downcase region
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;;save all backups in the temp folder
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;set emerge to ignore whitespace diff
(setq emerge-diff-options "--ignore-all-space")

;;delete trailing whitespaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;automatically revert buffer
(global-auto-revert-mode t)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

(autoload 'ibuffer "ibuffer" "List buffers." t)

(require 'fit-frame)
(add-hook 'after-make-frame-functions 'fit-frame)

(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying Active processes exist query when you quit Emacs."
  (flet ((process-list ())) ad-do-it))

;;c

(setq c-basic-offset 8)

(require 'yasnippet)

;;perl

;;map perl editing to cperl-mode
(mapc
 (lambda (pair)
   (if (eq (cdr pair) 'perl-mode)
       (setcdr pair 'cperl-mode)))
 (append auto-mode-alist interpreter-mode-alist))

;;cperl indents
(setq cperl-indent-level 8
      cperl-close-paren-offset -8
      cperl-continued-statement-offset 8
      cperl-indent-parens-as-block t
      cperl-tab-always-indent t)

(eval-after-load 'cperl-mode
  '(progn
     (define-key cperl-mode-map (kbd "RET")
       'reindent-then-newline-and-indent)))

(add-hook 'cperl-mode-hook
          (lambda()
            (progn
              (linum-mode t)
              (flymake-mode t)
              (yas-minor-mode))))

(global-set-key (kbd "C-h P") 'perldoc)

;;load cperl-mode for test files
(add-to-list 'auto-mode-alist '("\\.t$" . cperl-mode))

;;load cperl-mode for psgi file
(add-to-list 'auto-mode-alist '("\\.psgi$" . cperl-mode))

(defun flymake-create-temp-intemp (file-name prefix)
  (unless (stringp file-name)
    (error "Invalid file-name"))
  (or prefix
      (setq prefix "flymake"))
  (let* ((name (concat
                (file-name-nondirectory
                 (file-name-sans-extension file-name))
                "_" prefix))
         (ext  (concat "." (file-name-extension file-name)))
         (temp-name (make-temp-file name nil ext)))
    (flymake-log 3 "create-temp-intemp: file=%s temp=%s" file-name temp-name)
    temp-name))

(setq temporary-file-directory "~/.emacs.d/tmp/")

(defun flymake-perl-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-intemp))
        (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "perl"
          (list "-I/home/erez/.perl5/lib/perl5" "-Ilib" "-wc" local-file))))

;;make cperl-mode always highlight scalar variables
(setq cperl-highlight-variables-indiscriminately t)

;;load tt mode
(require 'tt-mode)
(add-to-list 'auto-mode-alist'("\\.tt[0-9]?$" . tt-mode))

;;perltidy
(require 'perltidy)

;;pod-mode
(eval-after-load "pod-mode"
  '(progn
     (add-to-list 'auto-mode-alist '("\\.pod$" . pod-mode))
     (add-hook 'pod-mode-hook 'font-lock-mode)))

;;yaml
(eval-after-load "yaml-mode"
  (add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode)))

(require 'mmm-mode)

;;javascript
(require 'json)

(add-hook 'js-mode-hook
          (lambda()
            (linum-mode t)))

;;php
(load-file "~/emacs/site-lisp/php-mode-improved.el")
(require 'php-mode)

;;slime
(setq inferior-lisp-program "/usr/bin/sbcl")

(require 'slime)
(slime-setup)

;;auctex
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

;;full-ack
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)
(setq ack-executable (executable-find "/home/erez/perl5/bin/ack"))
(global-set-key (kbd "\C-x\C-a") 'ack)

;;git

(require 'magit)
(require 'git-blame)

;; full screen magit-status
;; http://whattheemacsd.com//setup-magit.el-01.html
;; This code makes magit-status run alone in the frame,
;; and then restores the old window configuration when you quit out of magit.

(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(define-key magit-status-mode-map (kbd "q") 'magit-quit-session)

;;tramp - Transparent Remote (file) Access, Multiple Protocol
(require 'tramp)

;;org-mode
(eval-after-load "org-install"
  '(progn
     (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
     (global-set-key "\C-cl" 'org-store-link)
     (global-set-key "\C-cc" 'org-capture)
     (global-set-key "\C-ca" 'org-agenda)
     (global-set-key "\C-cb" 'org-iswitchb)
     (setq org-agenda-files (quote ("~/org")))))

;;automatically change to DONE when all children are done
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

;;Fontifying Code Buffers
(setq org-src-fontify-natively t)

(eval-after-load "org2blog"
  (setq org2blog/wp-blog-alist
        '(("Repetition, Change, Contrast"
           :url "http://repeatchange.wordpress.com"
           :username "erez"
           :default-title ""
           :default-categories ("Cricket")
           :tags-as-categories nil))))

(eval-after-load "org-latex"
  '(progn
     (unless (boundp 'org-export-latex-classes)
       (setq org-export-latex-classes nil))
     (add-to-list 'org-export-latex-classes
                  '("article"
                    "\\documentclass{article}"
                    ("\\section{%s}" . "\\section*{%s}")))))

(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)

;;IRC

(eval-after-load "erc"
'(progn
   (setq erc-autojoin-channels-alist
         '(("freenode.net" "#emacs" "#plan9" "#archlinux")
           ("gnome.net" "#gnome-shell")))

   (erc-log-mode)
   (setq erc-log-channels-directory "~/.logs/")
   (setq erc-save-buffer-on-part t)))

;; status-net

(require 'oauth)

(require 'identica-mode)
(setq statusnet-server "identi.ca")
(setq identica-username "erez")

;; twitter

(require 'twittering-mode)
(setq twittering-use-master-password t)

;;helper modules

;;Distinguish buffers of the same filename
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(unless (server-running-p)
  (server-start))

(eshell)

;;keyboard remapping

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

;;don't display the intro page
(setq inhibit-default-init nil)
(setq inhibit-startup-screen t)

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
