(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)
(setq mac-function-modifier 'hyper)

(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-c C-w") 'whitespace-cleanup)
(global-set-key (kbd "M-SPC") 'cycle-spacing)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "M-j") 'join-line)
(global-set-key (kbd "s-a") 'mark-whole-buffer)
(global-set-key (kbd "s-c") 'clipboard-kill-ring-save)
(global-set-key (kbd "s-v") 'clipboard-yank)
(global-set-key (kbd "s-`") 'other-frame)
(global-set-key (kbd "s-=") 'text-scale-increase)
(global-set-key (kbd "s--") 'text-scale-decrease)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x C-M-t") 'transpose-regions)
(global-set-key (kbd "M-u") 'upcase-dwim)
(global-set-key (kbd "M-l") 'downcase-dwim)
(global-set-key (kbd "M-c") 'capitalize-dwim)

;; https://emacs.stackexchange.com/questions/14823/how-to-disable-command-h-hide-in-emacs-mac-port-railwaycat
(setq mac-pass-command-to-system nil)
;(global-set-key (kbd "s-h") 'hs-toggle-hiding)

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(global-set-key (kbd "C-x |") 'toggle-window-split)

(defun snakify-region (start end)
  (interactive "r")
  (save-excursion
    (goto-char start)
    (while
        (prog1  
          (search-forward " " end t)
          (replace-match "_")))
    (message "Start %d end %d" start end)))

(provide 'my-keybinds)
