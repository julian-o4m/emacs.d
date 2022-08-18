(setq backup-directory-alist '(("." . "~/.emacs-backups")))

(set-register ?E '(file . "~/.emacs.d/init.el"))
(set-register ?K '(file . "~/.emacs.d/elisp/my-keybinds.el"))
(set-register ?P '(file . "~/.emacs.d/elisp/my-packages.el"))
(set-register ?S '(file . "~/.emacs.d/elisp/my-system.el"))
(set-register ?U '(file . "~/.emacs.d/elisp/my-ui.el"))

(set-register ?i '(file . "~/org/INBOX.org"))
(set-register ?t '(file . "~/org/TODO.org"))
(set-register ?p '(file . "~/org/PROJECT.org"))
(set-register ?s '(file . "~/org/STANDUP.org"))




;; Coding stuff ===============================================================
(setq-default indent-tabs-mode nil
              tab-width 4)

;; Make C-x C-b group things in the specified way
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("magit" (or (mode . magit-status-mode)
                            (mode . magit-diff-mode)
                            (mode . magit-process-mode)))
               ("starred" (starred-name))
               ("dired" (mode . dired-mode))
               ("python" (mode . python-mode))
               ("org" (mode . org-mode))
               ("go" (mode . go-mode))
               ("typescript" (mode . typescript-mode))))))

(add-hook 'ibuffer-mode-hook (lambda () (ibuffer-switch-to-saved-filter-groups "default")))

(add-hook 'before-save-hook #'whitespace-cleanup)

(provide 'my-system)
