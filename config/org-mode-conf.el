;;; Package: --- summary

;;; Commentary:

;;; Code:

;; defvars

(defvar org-src-fontify-natively)
(defvar org-export-latex-classes)
(defvar org-link-frame-setup)
(defvar org-agenda-files)

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
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

;;Fontifying Code Buffers
(setq org-src-fontify-natively t)

(eval-after-load "org-latex"
  '(progn
     (unless (boundp 'org-export-latex-classes)
       (setq org-export-latex-classes nil))
     (add-to-list 'org-export-latex-classes
                  '("article"
                    "\\documentclass{article}"
                    ("\\section{%s}" . "\\section*{%s}")))))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((perl . t)
   (emacs-lisp . t)
   (latex . t)
   (sh . t)
   (sql . t)
   (sqlite . t)))

(setq org-link-frame-setup
      (quote
       ((gnus . org-gnus-no-new-news)
        (file . find-file-other-frame)
        (wl . wl-other-frame))))

(provide 'org-mode-conf)
;;; org-mode-conf ends here
