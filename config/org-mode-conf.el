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

(eval-after-load "org-latex"
  '(progn
     (unless (boundp 'org-export-latex-classes)
       (setq org-export-latex-classes nil))
     (add-to-list 'org-export-latex-classes
                  '("article"
                    "\\documentclass{article}"
                    ("\\section{%s}" . "\\section*{%s}")))))

(provide 'org-mode-conf)
