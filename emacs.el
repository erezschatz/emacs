(eval-when-compile (require 'cl))

;;X system only
(if window-system
    (progn
      ;;set default font
      (if (or (eq system-type 'gnu/linux)
              (eq system-type 'linux))
          (progn
            (set-face-attribute 'default nil :font "ProFontWindows-9")
            (set-face-attribute 'tooltip nil :font "ProFontWindows-9"))
        (set-face-attribute 'default nil :font "ProFontWindows-9.0"))

      ;;enable color-theme
      (require 'color-theme)

      ;;set color theme
      (color-theme-initialize)
      (color-theme-billw)
      ;;when color-themes change, they reset all definitionss
      (setq color-theme-is-cumulative nil)

      ;;highlight current line
      (global-hl-line-mode t))
  ;; this is only needed for non GUI
  (setq linum-format "%d "))

;;disable tabs
(setq-default indent-tabs-mode nil)

;;set line number
(global-linum-mode 1)

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
(add-to-list 'auto-mode-alist'("\\.tt2\\'" . tt-mode))

;;perltidy
(require 'perltidy)

;;javascript
(autoload #'javascript-mode "javascript" "Start javascript-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . javascript-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . javascript-mode))

(require 'json)

(if window-system
    (progn
      ;;nxhtml mode
      (load "nxhtml/autostart.el")

      ;;right margin
      (require 'fill-column-indicator)
      (setq fci-style 'rule)
      ;;(setq fci-style 'shading)
      (setq fci-handle-line-move-visual t)
      ;;(setq fci-shading-face "#3a4a2a")
      ;;(setq fci-rule-color "#637253")
      ;;(setq fci-rule-character ?|)
      (setq-default fill-column 80)
      (global-set-key (kbd "C-c C-f") 'fci-mode)))

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

;;keyboard mapping

;;search word with right-click like acme
(require 'acme-search)
(global-set-key [(mouse-3)] 'acme-search-forward)

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

;;force tab
(global-set-key (kbd "C-<tab>") 'tab-to-tab-stop)

;;delete trailing whitespaces
(global-set-key (kbd "C-x C-<backspace>") 'delete-trailing-whitespace)

;;eval expression
(global-set-key (kbd "C-x C-;") 'eval-expression)