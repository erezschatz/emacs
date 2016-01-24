;; map perl editing to cperl-mode
(mapc
 (lambda (pair)
   (if (eq (cdr pair) 'perl-mode)
       (setcdr pair 'cperl-mode)))
 (append auto-mode-alist interpreter-mode-alist))

;; cperl indents
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
              (linum-mode t)))

(global-set-key (kbd "C-h P") 'perldoc)

;; load cperl-mode for test files
(add-to-list 'auto-mode-alist '("\\.t$" . cperl-mode))

;; load cperl-mode for psgi file
(add-to-list 'auto-mode-alist '("\\.psgi$" . cperl-mode))

;; make cperl-mode always highlight scalar variables
(setq cperl-highlight-variables-indiscriminately t)

;; set @INC to include local::lib directory
(setq flycheck-perl-include-path '("/home/erez/.perl5/lib/perl5"))

(autoload 'tt-mode "tt-mode")
(setq auto-mode-alist
      (append '(("\\.tt2*$" . tt-mode)) auto-mode-alist ))

(provide 'cperl-conf)
