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
          (list "-I/home/erez/.perl5/lib/perl5" "-I./lib/" "-wc" local-file))))

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

(provide 'cperl-conf)
