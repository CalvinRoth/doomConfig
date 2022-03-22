(setq user-full-name "Calvin Roth"
      user-mail-address "rothx195@umn.edu")

(setq doom-theme 'doom-dracula)

(setq display-line-numbers-type `relative)

(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)

(set-face-attribute 'default nil :height 200)

(setq emojify-emoji-set "twemoji-v2")

(setq org-babel-python-command "/Users/calvinroth/miniconda3/bin/python")



(after! org
  (setq org-pretty-entities nil)
)

(after! org
  (setq org-hide-emphasis-markers nil)
)

(map! :leader
      (:prefix-map ("i" . "insert")
      :desc "New Heading" "h" #'org-insert-heading
      )
)

(defun add-date-post ()
   "Add  YEAR-MONTH-DAY- to current file"
   (interactive)
   (setq full-name (epa-read-file-name "~/projects/CalvinRoth.github.io/_posts/"))
   (setq dpart (file-name-directory full-name))
   (setq localpart (file-name-nondirectory full-name))
   (setq newnamelocal (concat (format-time-string "%Y-%m-%d-") localpart))
   (setq newnametotal (concat dpart newnamelocal))
   (rename-file full-name newnametotal)
)

(map! :leader
      (:prefix-map ("d" . "dates")
        :desc "DatePosts" "w" #'add-date-post
      )
)

(map! :leader
      (:prefix-map ("(" . "Comments")
        :desc "Toggle Comment Region" "t" #'comment-or-uncomment-region
        :desc "Comment Region" "c" #'comment-region
        :desc "Uncomment Region" "u" #'uncomment-region
      )
)

(after! org
  (setq org-directory "~/org/")
  (setq org-agenda-files "~/org/weekly.org")
)

(use-package! org
  :config
  (setq org-todo-keywords
    '((sequence "TODO🌊(t)" "ARCH📜(a) " "LOOP(l) " "PROG👷(p)" "WAIT(w)" "HOLD(h)" "IDEA(i)" "GOAL🥅(g)" "|" "DONE✅(d)" "KILL(k)")
     (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")
     (sequence "|" "OKA👌🏻Y(o)" "YES(y)" "NO(n)"))
  )
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
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "-"))))))

(after! org
   (setq org-roam-directory "~/paperNotes")
)

(setq org-archive-mark-done t)
(setq org-archive-location "~/org/archive.org:: ")

  (require 'ox-publish)

  (setq org-publish-project-alist
    `(
          ("org-notes"
         :base-directory "~/org/webDrafts"
         :base-extension "org"
         :publishing-directory "~/projects/CalvinRoth.github.io/_posts/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         )
        ("org-static"
         :base-directory "~/org/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/projects/CalvinRoth.github.io/_posts/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("org" :components ("org-notes" "org-static"))
    )
)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
    (ipython . t)
    )
)

(add-hook 'org-babel-after-execute 'org-display-inline-images 'append)

;; (use-package! latex-math-preview)
(auto-insert-mode)
 ;; *NOTE* Trailing slash important
(setq auto-insert-directory "~/latex/templates/")
(setq auto-insert-query nil)
(define-auto-insert "\\.tex$" "gen-template.tex")

(unless (string-match-p "^Power N/A" (battery))
  (display-battery-mode 1))

(setq-default major-mode 'org-mode)

(add-load-path! "~/emacs.d/emmet-mode")
(require 'emmet-mode)
(add-hook 'html-mode-hook 'emmet-mode t)
