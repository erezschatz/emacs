(eval-when-compile (require 'cl))

(server-start)

;;X system only
(if window-system
    (progn
      ;;set default font
      (if (or (eq system-type 'gnu/linux)
              (eq system-type 'linux))
          (progn
            (set-face-attribute 'default nil
                                :font "Terminus"
                                :height 80
                                :background "black"
                                :foreground "white")
            (set-face-attribute 'tooltip nil :font "Terminus" :height 80))
        (set-face-attribute 'default nil :font "ProFontWindows-9.0"))

  ;; this is only needed for non GUI
  (setq linum-format "%d ")))

;;highlight current line
(global-hl-line-mode t)

;;disable tabs
(setq-default indent-tabs-mode nil)

;;no tool bar, no menu bar, no scrollbar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;;don't display the intro page
(setq inhibit-default-init nil)
(setq inhibit-startup-screen t)

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

;;adhere to the system set browser
(setq browse-url-browser-function 'browse-url-generic)

;;save all backups in the temp folder
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;set emerge to ignore whitespace diff
(setq emerge-diff-options "--ignore-all-space")

;;Run ‘save-buffers-kill-emacs’ without process-killing query
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent Active processes exist query when quit."
  (flet ((process-list ())) ad-do-it))
;;c
(setq c-basic-offset 8)

;;perl

;;map perl editing to cperl-mode
(mapc
 (lambda (pair)
   (if (eq (cdr pair) 'perl-mode)
       (setcdr pair 'cperl-mode)))
 (append auto-mode-alist interpreter-mode-alist))

;;cperl indents

(setq cperl-indent-level 4
      cperl-close-paren-offset -4
      cperl-continued-statement-offset 4
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
              (flymake-mode t))))

(global-set-key (kbd "C-h P") 'perldoc)

;;load cperl-mode for test files
(add-to-list 'auto-mode-alist '("\\.t$" . cperl-mode))

(defun flymake-perl-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
	 (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "perl" (list "-wc -Ilib -I/home/erez/perl5/lib/perl5 " local-file))))

;;make cperl-mode always highlight scalar variables
(setq cperl-highlight-variables-indiscriminately t)

;;load tt mode
(require 'tt-mode)
(add-to-list 'auto-mode-alist'("\\.tt[0-9]?\\'" . tt-mode))

;;perltidy
(require 'perltidy)

;;pod-mode
(require 'pod-mode)
(add-to-list 'auto-mode-alist '("\\.pod$" . pod-mode))
(add-hook 'pod-mode-hook 'font-lock-mode)

;; yaml
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))

;;javascript
(autoload #'javascript-mode "javascript" "Start javascript-mode" t)
(add-to-list 'auto-mode-alist '("\\.js(on)?$" . javascript-mode))

(require 'json)

;;auctex
;;(load "auctex.el" nil t t)
;;(load "preview-latex.el" nil t t)

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

;;fossil
(autoload 'vc-fossil-registered "vc-fossil")
(add-to-list 'vc-handled-backends 'Fossil)

;;tramp - Transparent Remote (file) Access, Multiple Protocol
(require 'tramp)

;;org-mode
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;;automatically change to DONE when all children are done

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

(setq org-mobile-directory "~/Dropbox/orgfiles")
(setq org-directory "~/emacs/orgfiles")
(setq org-mobile-inbox-for-pull "~/Dropbox/orgfiles")

;;keywiz
(require 'keywiz)

;;IRC

(require 'erc)

(setq erc-autojoin-channels-alist
      '(("freenode.net" "#emacs")
        ("shadowcat" "#dbix-class" "#moose" "#catalyst" "#dancer")
        ("llarian" "#dbix-class" "#moose" "#catalyst" "#dancer")
        ("eggebuh" "#dbix-class" "#moose" "#catalyst" "#dancer")
        ("oftc.net" "#munin" "#debian-perl" "#debian-next")))


(require 'emms-setup)
(emms-standard)
(emms-default-players)
(require 'emms-streams)

;;helper modules

;;fill-column-indicator
(require 'fill-column-indicator)
(setq-default fill-column 80)
(global-set-key "\C-xf" 'fci-mode)

;;Distinguish buffers of the same filename
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;;keyboard remapping

;;Invoke M-x without the Alt key
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;;Prefer backward-kill-word over Backspace
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;;when opening buffer menu, switch to it
(global-set-key "\C-x\C-b" 'buffer-menu-other-window)

;;delete trailing whitespaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;automatically revert buffer
(global-auto-revert-mode t)

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
 '(hl-line ((t (:inverse-video t)))))
