(require 'cl-lib)

;; no tool bar, no menu bar, no scrollbar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(if (eq system-type 'windows-nt)
        (progn
          ;; set default font
          (set-face-attribute 'default nil
                              :font "Consolas"
                              :height 80
                              :background "black"
                              :foreground "white")
          (set-face-attribute 'tooltip nil :font "Consolas" :height 80))
  (eq system-type 'gnu/linux)
  ;;X system only
  (if window-system
      (progn
        ;; set default font
        (set-face-attribute 'default nil
                            :font "Terminus"
                            :height 80
                            :background "black"
                            :foreground "white")
        (set-face-attribute 'tooltip nil :font "Terminus" :height 80))))

;; don't display the intro page
(setq inhibit-default-init nil)
(setq inhibit-startup-screen t)

;; save emacs session
(desktop-save-mode 1)

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

(setq tab-stop-list
      '(2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40))
;; delete trailing whitespaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; automatically revert buffer
(global-auto-revert-mode t)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

(autoload 'ibuffer "ibuffer" "List buffers." t)

;; open files from dired in other frames
;; http://www.emacswiki.org/emacs/DiredFindFileOtherFrame

(defun dired-find-file-other-frame ()
  "In Dired, visit this file or directory in another window."
  (interactive)
  (find-file-other-frame (dired-get-file-for-visit)))
(eval-after-load "dired"
  '(define-key dired-mode-map "F" 'dired-find-file-other-frame))

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

;; org-mode
(require 'org-mode-conf)

;; dev stuff
(require 'dev-conf)

;; IRC, IM, Mail

;;(require 'social-conf)

;; Server, Browser
(unless (fboundp 'server-running-p)
  (server-start))

;;(require 'w3m-load)

;;(require 'malyon)
