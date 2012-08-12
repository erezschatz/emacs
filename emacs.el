(eval-when-compile (require 'cl))

(server-start)

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

(autoload 'ibuffer "ibuffer" "List buffers." t)

 (defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
   "Prevent annoying Active processes exist query when you quit Emacs."
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

;;yaml
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))

;;javascript
(autoload #'javascript-mode "javascript" "Start javascript-mode" t)
(add-to-list 'auto-mode-alist '("\\.js(on)?$" . javascript-mode))

(require 'json)

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

(setq org-agenda-files (quote ("~/org")))

;;automatically change to DONE when all children are done
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

;;Fontifying Code Buffers
(setq org-src-fontify-natively t)

(require 'org2blog)

(setq org2blog/wp-blog-alist
    '(("Repetition, Change, Contrast"
       :url "http://repeatchange.wordpress.com"
       :username "erez"
       :default-title ""
       :default-categories ("Cricket")
       :tags-as-categories nil)))

;;mobile org
(setq org-mobile-directory "~/emacs/mobile/")
(setq org-mobile-files "~/emacs/mobile/todo.org")

;;IRC

(require 'oauth)

(require 'erc)

(defun go-erc ()
  "Connect to IRC, Instant Messaging"
  (interactive)
  (erc :server "localhost"        :port 6667 :nick "erez")
  (erc :server "irc.freenode.net" :port 6667 :nick "erez")
  (erc :server "irc.perl.org"     :port 6667 :nick "erez")
  (erc :server "irc.oftc.net"     :port 6667 :nick "erez"))

(setq erc-autojoin-channels-alist
      '(("freenode.net" "#emacs")
        ("oftc.net" "#suckless")))

(erc-log-mode)
(setq erc-log-channels-directory "~/.logs/")
(setq erc-save-buffer-on-part t)

;; status-net

(require 'identica-mode)
(setq statusnet-server "statusnet.netvertise.co.il")
(setq statusnet-server-textlimit 140)

;;gnus

(setq gnus-select-method '(nntp "news.mixmin.net"))

(setq gnus-select-method '(nnimap "gmail"
				  (nnimap-address "imap.gmail.com")
				  (nnimap-server-port 993)
				  (nnimap-stream ssl)))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "moonbuzz@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

(shell)

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

;; override buffer menu
(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;; optional keyboard short-cut
(global-set-key "\C-xm" 'browse-url-at-point)

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
