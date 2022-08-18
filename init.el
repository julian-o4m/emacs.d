(setq byte-compile-warnings '(cl-functions)) ;; TEMPORARY: turn off cl package deprecation warning

;; Increase garbage collection threshold to speed up initialization
(setq gc-cons-threshold (* 100 1000 1000))
(add-hook 'emacs-startup-hook
      (lambda ()
        (message "Emacs ready in %s with %d garbage collections."
             (format "%.2f seconds"
                 (float-time
                  (time-subtract after-init-time before-init-time)))
             gcs-done)))

;; whoami
(setq user-full-name "Julian Eng"
      user-mail-address "julian@outcomes4me.com")

;; Setup packages
(require 'package)
(setq package-enable-at-startup nil)

;; (setq package-archives
;;       '(("melpa" . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/melpa/")
;;         ("org"   . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/org/")
;;         ("gnu"   . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/gnu/")))
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t
      use-package-always-ensure t)
(setq load-prefer-newer t)

(add-to-list 'load-path "~/.emacs.d/elisp/")

(put 'overwrite-mode 'disabled t)

(require 'my-packages)
(require 'my-keybinds)
(require 'my-system)
(require 'my-ui)

;; Reset garbage collection threshold
(setq gc-cons-threshold (* 2 1000 1000))
(put 'overwrite-mode 'disabled nil)
(put 'narrow-to-region 'disabled nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "d89e15a34261019eec9072575d8a924185c27d3da64899905f8548cbd9491a36" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "f5b6be56c9de9fd8bdd42e0c05fecb002dedb8f48a5f00e769370e4517dde0e8" "d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" "4eb6fa2ee436e943b168a0cd8eab11afc0752aebb5d974bba2b2ddc8910fca8f" "6bdcff29f32f85a2d99f48377d6bfa362768e86189656f63adbf715ac5c1340b" "78c4238956c3000f977300c8a079a3a8a8d4d9fee2e68bad91123b58a4aa8588" "83e0376b5df8d6a3fbdfffb9fb0e8cf41a11799d9471293a810deb7586c131e6" "7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" "6b5c518d1c250a8ce17463b7e435e9e20faa84f3f7defba8b579d4f5925f60c1" "b494aae329f000b68aa16737ca1de482e239d44da9486e8d45800fd6fd636780" default))
 '(package-selected-packages
   '(lsp-ivy typescript-mode company-terraform terraform-mode docker-tramp minimap multiple-cursors focus solarized-theme zenburn-theme gruvbox-theme restclient ox-pandoc npm yasnippet-snippets yasnippet treemacs-projectile nyan-mode helpful lsp-ui lsp-mode markdown-mode rjsx-mode counsel-projectile org-bullets org-mode writeroom-mode writegood-mode which-key web-mode use-package undo-tree smex rainbow-delimiters projectile paredit molokai-theme magit flycheck exec-path-from-shell emmet-mode diminish delight counsel company beacon ace-window))
 '(server-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
