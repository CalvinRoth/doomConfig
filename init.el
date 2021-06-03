(setq user-full-name "Calvin Roth"
      user-mail-address "rothx195@umn.edu")

(setq doom-theme 'doom-one)

(setq display-line-numbers-type `relative)

(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)

(set-face-attribute 'default nil :height 200)

(setq emojify-emoji-set "twemoji-v2")

(after! org
  (setq org-pretty-entities t)
)

(after! org
  (setq org-hide-emphasis-markers t)
)

(after! org
  (setq org-directory "~/org/")
  (setq org-agenda-files "/org/weekly.org")
)

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE✅" "TODO🌊"))))
    ;; I included the statistics here.
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

(after! org
  (use-package! org-bullets
      :config
      (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
)

(after! org)
(font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "🔹"))))))
