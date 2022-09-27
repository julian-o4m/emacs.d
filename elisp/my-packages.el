(use-package molokai-theme
  :config
  (load-theme 'molokai)
  ;; Comments are hard to read
  (let ((comment-color "#799"))
    (set-face-foreground 'font-lock-comment-face comment-color)
    (set-face-foreground 'font-lock-comment-delimiter-face comment-color)))

(use-package emojify
  :bind (("C-x ." . emojify-insert-emoji))
  :config (setq emojify-display-style 'unicode
                emojify-emoji-styles '(github unicode))
  (global-emojify-mode 1))

;; (use-package moe-theme
;;   :config
;;   (load-theme 'moe-dark)
;;   (let ((comment-color "#799"))
;;     (set-face-foreground 'font-lock-comment-face comment-color)
;;     (set-face-foreground 'font-lock-comment-delimiter-face comment-color)))


;; We're reaaaaally gonna use ace-window this time!!!
(use-package ace-window
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)
        aw-scope 'global
        aw-dispatch-always nil)
  :bind
  ("M-o" . ace-window)
  ("C-x o" . other-window))

;; And avy!!!!
(use-package avy
  :bind (("C-'" . avy-goto-char-timer)
         (:map isearch-mode-map ("C-'" . avy-isearch))))

(use-package perspective
  :bind (("C-x C-b" . persp-ibuffer))
  :custom (persp-mode-prefix-key (kbd "s-b"))
  :config
  (persp-mode 1))

(use-package beacon :init (beacon-mode) :diminish "")

(use-package browse-kill-ring :bind (("C-M-Y" . browse-kill-ring)))

;; These all work together somehow ? ===========================================
;; (use-package company
;;   :diminish company-mode global-company-mode
;;   :init (add-hook 'after-init-hook 'global-company-mode))

;; (use-package counsel
;;   :bind (("M-x" . counsel-M-x)
;;          ("C-x C-f" . counsel-find-file)
;;          ("C-x 8 C-<return>" . counsel-unicode-char)))

;; (use-package smex)
;; (use-package diminish); Hide minor modes in modeline
;; (use-package delight); Change mode string in modeline

;; (use-package ivy :diminish ivy-mode
;;   :config
;;   (progn
;;     (ivy-mode 1)
;;     (setq ivy-use-virtual-buffers t)
;;     (setq ivy-initial-inputs-alist nil)
;;     (setq ivy-re-builders-alist
;;           '((t  .  ivy--regex-ignore-order)))
;;     (setq ivy-count-format "%d/%d ")))

(use-package vertico
  :init (vertico-mode)
  :custom (vertico-cycle t))

(use-package savehist
  :init
  (savehist-mode))

(use-package marginalia
  :after vertico
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package all-the-icons)

(use-package all-the-icons-completion
  :after (marginalia all-the-icons)
  :hook (marginalia-mode . all-the-icons-completion-marginalia-setup)
  :init
  (all-the-icons-completion-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))
;; ============================================================================

(use-package emmet-mode
  :diminish emmet-mode
  :hook ((html-mode . emmet-mode)
         (css-mode . emmet-mode)
         (js-mode . emmet-mode)
         (js-jsx.mode . emmet-mode)
         (typescript-mode . emmet-mode)
         (web-mode . emmet-mode)))

(setq typescript-indent-level 2
      js-indent-level 2)


(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(use-package flycheck)

(use-package hideshow
  :hook ((prog-mode . hs-minor-mode))
  :diminish hs-minor-mode
  :config
  (define-key hs-minor-mode-map (kbd "s-h") (lookup-key hs-minor-mode-map (kbd "C-c @")))
  (define-key hs-minor-mode-map (kbd "C-c @") nil))

(defun magit-display-buffer-traditional (buffer)
            "Display BUFFER the way this has traditionally been done."
            (display-buffer
             buffer (if (and (derived-mode-p 'magit-mode)
                             (not (memq (with-current-buffer buffer major-mode)
                                        '(magit-process-mode
                                          magit-revision-mode
                                          magit-diff-mode
                                          magit-stash-mode
                                          magit-status-mode))))
                        '(display-buffer-same-window)
                      nil)))

(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-c g" . magit-file-dispatch)
         ("s-g b" . magit-blame))
  :config (setq magit-display-buffer-function #'magit-display-buffer-traditional))

(use-package multiple-cursors
  :bind (("C-c m" . mc/edit-lines)))

;; Org mode ===================================================================
(use-package org
  :hook ((org-mode . auto-fill-mode)
         (org-mode . display-fill-column-indicator-mode))
  :bind (:map org-mode-map ("C-'" . avy-goto-char-timer))
  :bind (("C-c a" . org-agenda)
         ("C-c c" . org-capture)
         ("C-c l" . org-store-link))
  :config (setq
           org-adapt-indentation t
           org-catch-invisible-edits 'show-and-error
           org-enforce-todo-dependencies t
           org-hide-emphasis-markers nil
           org-hide-leading-stars t
           org-directory "~/org/"
           org-todo-keywords '((sequence "TODO(t)" "STARTED(s)" "CR(c)" "PR(p)" "TRAIN(r)" "BLOCKED(b)" "|" "DONE(D)" "CANCELLED(C)"))
           org-todo-keyword-faces '(("TODO" . "LightSteelBlue") ("STARTED" . "yellow")
                                    ("CR" . "ForestGreen") ("PR" . "LimeGreen")
                                    ("TRAIN" . "PaleGreen")
                                    ("BLOCKED" . "red")
                                    ("CANCELLED" . "gray") ("DONE" . "DodgerBlue"))
           org-agenda-files (list "~/org/STANDUP.org")
           org-format-latex-options (plist-put org-format-latex-options :scale 3.0)
           org-capture-templates '(("t" "Today" entry (file+headline "~/org/STANDUP.org" "Days")
                                    "*** %t\n**** Today\n**** NOTES\n**** TIL\n**** New Problems")))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((dot . t))))

(use-package graphviz-dot-mode)

(use-package org-bullets :config (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))



(set-face-foreground 'org-verbatim "#888")
(set-face-foreground 'org-block "#888")
(set-face-foreground 'org-code "turquoise")

;; ============================================================================

(use-package paredit
  :diminish paredit-mode
  :hook ((lisp-mode . paredit-mode)
         (emacs-lisp-mode . paredit-mode))
  :bind ((:map paredit-mode-map
               ("M-d" . paredit-forward-kill-word)))
  :config (progn (add-hook 'lisp-mode-hook #'paredit-mode)
                 (add-hook 'emacs-lisp-mode-hook #'paredit-mode)
                 (add-hook 'common-lisp-mode-hook #'paredit-mode)
                 (add-hook 'scheme-mode-hook #'paredit-mode)
                 (add-hook 'racket-mode-hook #'paredit-mode)))

(defun paredit-space-for-delimiter-p (endp delimiter)
  "Paredit spacing tweaks"
  (and (not (if endp (eobp)(bobp)))
       (memq (char-syntax (if endp (char-after)(char-before)))
             (list ?\" ;; REMOVED ?w ?_
                   (let ((matching (matching-paren delimiter)))
                     (and matching (char-syntax matching)))))))

(use-package projectile
  :diminish projectile-mode
  :bind (:map projectile-mode-map
              ("s-p" .  'projectile-command-map))
  :config (projectile-mode t)
  (setq projectile-switch-project-action #'magit))

;; (use-package counsel-projectile
;;   :diminish counsel-projectile-mode
;;   :config (counsel-projectile-mode t)
;;   (setq counsel-projectile-switch-project-action 'counsel-projectile-switch-project-action-dired))


(use-package rainbow-delimiters :diminish ""
  :config (add-hook 'prog-mode-hook #'rainbow-delimiters-mode-enable))

(use-package undo-tree
  :diminish ""
  :init (progn (global-undo-tree-mode)(setq undo-tree-visualizer-timestamps t))
  :bind (("s-u" . undo-tree-visualize))
  :config (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo-tree-history/"))
                undo-tree-auto-save-history t))


(use-package which-key
  :diminish which-key-mode
  :init (which-key-mode)
  :config (which-key-setup-side-window-right-bottom))

(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-enable-auto-indentation nil
        web-mode-enable-auto-quoting nil))

(use-package writegood-mode)
(use-package writeroom-mode
  :config
  (setq writeroom-width 80
        writeroom-fullscreen-effect 'maximized))

;; (defun setup-tide-mode ()
;; "Set up Tide mode."
;; (interactive)
;; (tide-setup)
;; (flycheck-mode + 1)
;; (setq flycheck-check-syntax-automatically '(save-mode-enabled))
;; (eldoc-mode + 1)
;; (tide-hl-identifier-mode + 1)
;; (company-mode + 1))

;; (use-package tide
;;   :ensure t
;;   :config
;; (setq company-tooltip-align-annotations t)
;; (add-hook 'before-save-hook 'tide-format-before-save)
;; (add-hook 'typescript-mode-hook #'setup-tide-mode))

(use-package rjsx-mode)
(use-package markdown-mode)

(use-package lsp-mode
  :commands lsp
  :hook ((js-mode
          js-jsx-mode
          typescript-mode
          web-mode) . lsp)
  :hook (lsp-mode . (lambda () (lsp-enable-which-key-integration)))
  :config
  (global-eldoc-mode -1)
  (setq lsp-disabled-clients '(eslint))
  (setq read-process-output-max (* 4 1024 1024)) ;; 4mb
)

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq
   lsp-ui-sideline-show-diagnostics t
   lsp-ui-sideline-show-hover t
   lsp-ui-sideline-show-code-actions t))



(use-package helpful)

(setq julian/nyan-is-wavy nil)
(defun nyan-nyan-nyan ()
  (interactive t)
  (nyan-mode t)
  (nyan-start-animation)
  (when (null julian/nyan-is-wavy)
    (nyan-toggle-wavy-trail)
    (setq julian/nyan-is-wavy t)))

(use-package nyan-mode
  :hook (prog-mode . (lambda () (nyan-nyan-nyan))))

(use-package treemacs-projectile)
(use-package treemacs
  :config
  (setq treemacs-width 45))

(use-package yasnippet
  :config (yas-global-mode 1)
  (setq yas-triggers-in-field t))

(use-package yasnippet-snippets)
(use-package npm)
(provide 'my-packages)
