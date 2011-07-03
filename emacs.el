(eval-when-compile (require 'cl))

;;highlight current line
(global-hl-line-mode t)

;;disable tabs
(setq-default indent-tabs-mode nil)

;;set line number
(setq linum-format "%d ")

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
          (lambda() (linum-mode t)))

(global-set-key (kbd "C-h P") 'perldoc)

;;load cperl-mode for test files
(add-to-list 'auto-mode-alist '("\\.t$" . cperl-mode))

;;add local::lib path to PATH to get perldoc working
(load "cl-seq")

;;; Prepend perlbrew paths to exec-path
(mapc (lambda (x) (add-to-list 'exec-path x))
      (mapcar (lambda (x) (concat (getenv "HOME") x))
              (list "/perl5/bin" "/perl5/lib/perl5")))

;; set PATH to be the same as exec-path, clobber the old PATH value.
(setenv "PATH"
        (reduce
         (lambda (a b) (concatenate 'string a ":" b))
         exec-path))

;;make cperl-mode always highlight scalar variables
(setq cperl-highlight-variables-indiscriminately t)

;;load tt mode
(require 'tt-mode)
(add-to-list 'auto-mode-alist'("\\.tt\\'" . tt-mode))

;;perltidy
(require 'perltidy)

;;php
(require 'php-mode)
;;javascript
(autoload #'javascript-mode "javascript" "Start javascript-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . javascript-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . javascript-mode))

(require 'json)

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

;;auctex
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

;;keywiz
(require 'keywiz)

;;erc

(require 'erc)

(setq erc-autojoin-channels-alist
      '(("freenode.net" "#emacs" "#fedora")
        ("shadowcat" "#dbix-class" "#moose" "#catalyst" "#dancer" "#perl")
        ("llarian" "#dbix-class" "#moose" "#catalyst" "#dancer" "#perl")
        ("netgamers.org" "#battrick")))

;;jabber

(require 'jabber-autoloads)
(setq jabber-username "moonbuzz@gmail.com")
(setq jabber-nickname "erez")
(setq jabber-connection-type (quote ssl))
(setq jabber-network-server "talk.google.com")
(setq jabber-server "gmail.com")

;;microblogging

;;identica

(when (require 'netrc nil t)
  (autoload 'identica-mode "identica-mode" nil t)
  (let ((identica (netrc-machine (netrc-parse "~/.netrc") "identi.ca")))
    (setq identica-password (netrc-get identica "password")
          identica-username (netrc-get identica "login"))))

;;twitter
(require 'twittering-mode)
(setq twittering-use-master-password t)

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
(global-set-key (kbd "\C-x\C-b") 'buffer-menu-other-window)

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
