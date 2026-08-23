;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:

(setq doom-font (font-spec :family "Iosevka" :size 19 :weight 'semi-light))
(setq doom-variable-pitch-font (font-spec :family "Lucida Sans Unicode" :size 18))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-themes-custom-config-dir "~/.config/doom/themes/")
(setq doom-theme 'doom-organic-chemistry-tutor)
(setq fancy-splash-image "/home/denz/Pictures/MVC2.jpeg")
;; (setq +doom-dashboard-functions
;;       '(doom-dashboard-widget-banner
;;         doom-dashboard-widget-footer))
;; (assoc-delete-all "Open project" +dashboard-menu-sections)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-mobile-directory "~/org/")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! exec-path-from-shell
  (dolist (var '("HYPRLAND_INSTANCE_SIGNATURE" "WAYLAND_DISPLAY" "XDG_RUNTIME_DIR"))
    (add-to-list 'exec-path-from-shell-variables var)))

(after! org
  (use-package! org-excalidraw
  :config
  (setq org-excalidraw-directory "~/org/excalidraw/"))
  (org-excalidraw-initialize)
  (with-eval-after-load 'org-roam
  (add-to-list 'org-roam-capture-templates
               '("i" "Inbox / Quick Capture" entry
                 "* %?\n:PROPERTIES:\n:CAPTURED: %U\n:END:\n"
                 :target (file+head "inbox.org" "#+title: Inbox\n#+filetags: :inbox:\n")
                 :empty-lines 1)))
  (setq org-roam-v2-ack t)
  (setq org-roam-dailies-capture-templates
          '(("J" "Journal" entry "** %<%I:%M %p>: %?"
             :target (file+head+olp "%<%Y-%m-%d>.org"
                                   "#+title: %<%Y-%m-%d>\n#+filetags: daily\n\n* Reminders\n\n* Journal"
                                    ("Journal"))
             :unnarrowed t)))
  (setq org-roam-completion-everywhere t)
  (setq org-roam-directory "~/org/Roam")
  (setq org-roam-dailies-directory "~/org/Roam/Journal")
  (setq org-roam-capture-templates
      '(("d" "Default" plain "%?"
         :target (file+head "%<%Y%m%d%H%M%S>.org"
                            "#+title: ${title}\n#+filetags:")
         :unnarrowed t)))

  (use-package! org-krita
  :config
  (add-hook! 'org-mode-hook 'org-krita-mode))

  (setq org-refile-targets
      '(;; Productivitys
        ("~/org/Main/Productivity/Domain/Academics.org" :maxlevel . 9)
        ("~/org/Main/Productivity/Domain/Cyber.org" :maxlevel . 9)
        ("~/org/Main/Productivity/Domain/Debts & Financial Obligations.org" :maxlevel . 9)
        ("~/org/Main/Productivity/Domain/Events.org" :maxlevel 9)
        ("~/org/Main/Productivity/Domain/Personal.org" :maxlevel . 9)
        ;; Outerorgs
        ("~/org/Main/Franchise Catalog.org" :maxlevel . 9)
        ("~/org/Main/Music Matrix.org" :maxlevel . 9)
        ("~/org/Main/Reading List.org" :maxlevel . 9)
        ("~/org/Main/Recipe Record.org" :maxlevel . 9)
        ;; MECs
        ("~/org/Main/Agenda Specials/Birthdays.org" :maxlevel . 1)
        ("~/org/Main/Agenda Specials/Events.org" :maxlevel . 9)
        ;; Archive
        ("~/org/Archive/Mega Archive.org" :maxlevel . 9)
        ))

  (add-to-list 'org-modules 'org-habit)
  ;; (add-to-list 'org-agenda-custom-commands
  ;;              '("W" "Clean agenda (week)" agenda ""
  ;;                ((org-super-agenda-groups
  ;;                  '((:discard (:tag ("recur")))))
  ;;                 (org-agenda-span 7))))
  ;; (add-to-list 'org-agenda-custom-commands
  ;;              '("3" "Clean agenda (3 days)" agenda ""
  ;;                ((org-super-agenda-groups
  ;;                  '((:discard (:tag ("recur")))))
  ;;                 (org-agenda-span 3))))
  ;; (add-to-list 'org-agenda-custom-commands
  ;;              '("D" "Clean agenda (day)" agenda ""
  ;;                ((org-super-agenda-groups '((:discard (:tag ("recur")))))
  ;;                 (org-agenda-span 'day))))
  ;; (add-to-list 'org-agenda-custom-commands
  ;;              '("R" "Recurring agenda view" agenda ""
  ;;                ((org-super-agenda-groups '((:tag ("recur"))))
  ;;                 (org-agenda-span 'day))))
  (setq org-group-tags t)
  (setq org-habit-graph-column 60)
  (setq org-agenda-start-day "-0d")
  (setq org-agenda-files ` ("~/org/Main/Productivity/"
                            "~/org/Main/Productivity/Domain"
                            "~/org/Main/Agenda Specials"))
  (setq org-agenda-custom-commands
      '(("G" "Productivity view"
         ((todo "NEXT"
                ((org-agenda-overriding-header "Next")))
          (tags-todo "+inbox")))
        ("r" "Recurring"
         ((tags-todo "+habits"
        ((org-agenda-overriding-header "Habits"))
        (org-agenda-show-log t))
          (tags-todo "+dwmy"
        ((org-agenda-overriding-header "Daily, Monthly, & Weekly"))
        (org-agenda-show-log t))
          ))
        ("c" "Daily clean view (no recur)" agenda ""
     ((org-agenda-span 1)
      (org-agenda-tag-filter-preset '("-recur"))))
        ("w" "Daily Work Agenda"
         ((agenda "" ((org-agenda-span 1) ;; Shows just one day
                      (org-agenda-overriding-header "Daily Work Tasks")
                      (org-agenda-skip-function
                       '(org-agenda-skip-entry-if 'notregexp ":recur:"))))))
        ("u" "Active TODOs Only"
         ((agenda "" ;; Matches any TODO state
                ((org-agenda-overriding-header "Daily Action Items")
                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'nottodo 'todo))))))))

  (setq org-agenda-start-with-log-mode t)
  ;; (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-extend-today-until 3)

  ;; org-beautification
  (setq org-ellipsis " ▼")
  (setq org-hide-emphasis-markers t)
  ;; (setq org-hide-leading-stars nil)
  ;; (setq org-superstar-leading-bullet ?\s)
  ;; (setq org-indent-mode-turns-on-hiding-stars nil)
  ;; (setq org-hide-leading-stars t)
  ;; (setq org-superstar-leading-bullet ?\s)
  ;; (setq org-superstar-remove-leading-stars t)
  ;; (setq org-indent-mode-turns-on-hiding-stars nil)
  
  (setq writeroom-width 66)
  (setq org-modern-star nil)
  (setq org-modern-todo nil)
  (setq org-modern-date-active nil)
  (setq org-modern-tag nil)
  ;; (setq org-modern-todo nil)
  ;; (setq org-modern-priority nil)
  ;; (setq org-modern-table nil)
  (setq org-modern-list nil)
  (setq org-superstar-prettify-item-bullets nil)
  (setq org-modern-list 
   '((?- . "•")
     (?+ . "‣")))

  (setq org-capture-templates
        ;; `(
        ;;   ("is" "Scratch" entry (file "~/org/Main/Productivity/Inbox.org") "* %? :scratch:")
        ;;   ("ie" "Event" entry (file "~/org/Main/Productivity/Inbox.org") "*  \n%?<%<%Y-%m-%d>>")
        ;;   ("n" "Inbox [NWO]" entry (file "~/org/Main/No World Order/Inbox.org") "* %?")
        `(("d" "Direct")

          ("dc" "Cyberspace management")

          ("dcl" "Linux")

          ("dclh" "Hyprland")
          ("dclhn" "Task - NEXT" entry (file+headline "~/org/Main/Productivity/Domain/Cyber.org" "Hyprland") "* NEXT %?")
          ("dclhs" "Task - TODO, SCHEDULED" entry (file+headline "~/org/Main/Productivity/Domain/Cyber.org" "Hyprland") "* TODO \n%?SCHEDULED: <%<%Y-%m-%d>>")
          ("dclhd" "Task - TODO, DEADLINE" entry (file+headline "~/org/Main/Productivity/Domain/Cyber.org" "Hyprland") "* TODO \n%?DEADLINE: <%<%Y-%m-%d>>")

          ("dcle" "Emacs")
          ("dclen" "Task - NEXT" entry (file+headline "~/org/Main/Productivity/Domain/Cyber.org" "Emacs") "* NEXT %?")
          ("dcles" "Task - TODO, SCHEDULED" entry (file+headline "~/org/Main/Productivity/Domain/Cyber.org" "Emacs") "* TODO \n%?SCHEDULED: <%<%Y-%m-%d>>")
          ("dcled" "Task - TODO, DEADLINE" entry (file+headline "~/org/Main/Productivity/Domain/Cyber.org" "Emacs") "* TODO \n%?DEADLINE: <%<%Y-%m-%d>>")

          ("dcll" "Linux")
          ("dclln" "Task - NEXT" entry (file+headline "~/org/Main/Productivity/Domain/Cyber.org" "Linux") "* NEXT %?")
          ("dclls" "Task - TODO, SCHEDULED" entry (file+headline "~/org/Main/Productivity/Domain/Cyber.org" "Linux") "* TODO \n%?SCHEDULED: <%<%Y-%m-%d>>")
          ("dclld" "Task - TODO, DEADLINE" entry (file+headline "~/org/Main/Productivity/Domain/Cyber.org" "Linux") "* TODO \n%?DEADLINE: <%<%Y-%m-%d>>")

          ("dcw" "Windows")
          ("dcwn" "Task - NEXT" entry (file+headline "~/org/Main/Productivity/Domain/Cyber.org" "Windows") "* NEXT %?")
          ("dcws" "Task - TODO, SCHEDULED" entry (file+headline "~/org/Main/Productivity/Domain/Cyber.org" "Windows") "* TODO \n%?SCHEDULED: <%<%Y-%m-%d>>")
          ("dcwd" "Task - TODO, DEADLINE" entry (file+headline "~/org/Main/Productivity/Domain/Cyber.org" "Windows") "* TODO \n%?DEADLINE: <%<%Y-%m-%d>>")

          ("dca" "Android")
          ("dcan" "Task - NEXT" entry (file+headline "~/org/Main/Productivity/Domain/Cyber.org" "Android") "* NEXT %?")
          ("dcas" "Task - TODO, SCHEDULED" entry (file+headline "~/org/Main/Productivity/Domain/Cyber.org" "Android") "* TODO \n%?SCHEDULED: <%<%Y-%m-%d>>")
          ("dcad" "Task - TODO, DEADLINE" entry (file+headline "~/org/Main/Productivity/Domain/Cyber.org" "Android") "* TODO \n%?DEADLINE: <%<%Y-%m-%d>>")

          ("dci" "Internet")
          ("dcin" "Task - NEXT" entry (file+headline "~/org/Main/Productivity/Domain/Cyber.org" "Internet") "* NEXT %?")
          ("dcis" "Task - TODO, SCHEDULED" entry (file+headline "~/org/Main/Productivity/Domain/Cyber.org" "Internet") "* TODO \n%?SCHEDULED: <%<%Y-%m-%d>>")
          ("dcid" "Task - TODO, DEADLINE" entry (file+headline "~/org/Main/Productivity/Domain/Cyber.org" "Internet") "* TODO \n%?DEADLINE: <%<%Y-%m-%d>>")

          ("dp" "Personal")

          ("dpp" "Personal")
          ("dppn" "Task - NEXT" entry (file "~/org/Main/Productivity/Domain/Personal.org") "* NEXT %?")
          ("dpps" "Task - TODO, SCHEDULED" entry (file "~/org/Main/Productivity/Domain/Personal.org") "* TODO \n%?SCHEDULED: <%<%Y-%m-%d>>")
          ("dppd" "Task - TODO, DEADLINE" entry (file "~/org/Main/Productivity/Domain/Personal.org") "* TODO \n%?DEADLINE: <%<%Y-%m-%d>>")

          ("dps" "Shopping list")
          ("dpsn" "Task - NEXT" entry (file+headline "~/org/Main/Productivity/Domain/Personal.org" "Shopping list") "* NEXT %?")
          ;; ("dpss" "Task - TODO, SCHEDULED" entry (file+headline "~/org/Main/Productivity/Domain/Personal" "Shopping list") "* TODO \n%?SCHEDULED: <%<%Y-%m-%d>>")
          ;; ("dpsd" "Task - TODO, DEADLINE" entry (file+headline "~/org/Main/Productivity/Domain/Personal" "Shopping list") "* TODO \n%?DEADLINE: <%<%Y-%m-%d>>")

          ("dd" "Debts & Financial Obligations")

          ("de" "Events")

          ("da" "Academics")

          ("i" "Inbox")

          ("it" "Task")
          ("itn" "Task - NEXT" entry (file "~/org/Main/Productivity/Inbox.org") "* NEXT %?")
          ("its" "Task - TODO, SCHEDULED" entry (file "~/org/Main/Productivity/Inbox.org") "* TODO \n%?SCHEDULED: <%<%Y-%m-%d>>")
          ("itd" "Task - TODO, DEADLINE" entry (file "~/org/Main/Productivity/Inbox.org") "* TODO \n%?DEADLINE: <%<%Y-%m-%d>>")

          ("ie" "Regular entry" entry (file "~/org/Main/Productivity/Inbox.org") "* %?")
          ("ic" "Timestamp" entry (file "~/org/Main/Productivity/Inbox.org") "* %?\n<%<%Y-%m-%d>>")

          ;; (org-super-agenda-mode t)
          ))

  ;; (setq org-todo-keyword-faces
  ;;     '(
  ;;       ;; ("DONE" . (:inherit (org-modern-todo)))
  ;;       ;; ("PROG" . (:foreground "#BF616A")))
  ;;       ;; ("NEXT" . (:inherit (org-modern-todo)))
  ;;       ))
  
  (setq org-archive-location "~/org/Archive/Archived Entries.org::")
  (setq org-startup-with-inline-images t)
  (setq org-enforce-todo-checkbox-dependencies t)

  ;; (eval-after-load "org-present"
  ;; '(progn
  ;;    (add-hook 'org-present-mode-hook
  ;;              (lambda ()
  ;;                (org-present-big)
  ;;                (org-display-inline-images)
  ;;                (org-present-hide-cursor)
  ;;                (org-present-read-only)))
  ;;    (add-hook 'org-present-mode-quit-hook
  ;;              (lambda ()
  ;;                (org-present-small)
  ;;                (org-remove-inline-images)
  ;;                (org-present-show-cursor)
  ;;                (org-present-read-write)))))

  (use-package! org-superstar
  :hook (org-mode . org-superstar-mode)
  :config
  ;; Enable item bullets (change to nil if you ONLY want heading stars)
  (setq org-superstar-prettify-item-bullets t)
  ;; Ensure leading stars are hidden smoothly
  (setq org-superstar-remove-leading-stars t))
  ;; (require 'org-superstar)
  (require 'org-habit)
  (require 'org-checklist)
  (require 'phscroll)
  )

(setq electric-indent-chars (remq ?\n electric-indent-chars))

;; evil mode
(setq evil-set-undo-system 'undo-redo)
(setq evil-want-C-i-jump nil)

;; Global preferences
(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)
(setq warning-suppress-types (append warning-suppress-types '((org-element-cache))))

;; Doom Emacs performace boost recommendations
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
;; (setq company-idle-delay nil)
(setq global-auto-revert-non-file-buffers t)


;; Custom keybindings
;; (global-unset-key (kbd "M-o"))
(global-unset-key (kbd "C-s"))
(global-unset-key (kbd "C-r"))
;; (global-unset-key (kbd "C-c n d"))
;; (global-unset-key (kbd "C-x D C-f"))

(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-r") 'swiper)
;; (global-set-key (kbd "C-x o") 'org-capture)
;; (global-set-key (kbd "M-o") 'other-window)
(global-set-key [f12] '+treemacs/toggle)
;; (global-set-key (kbd "M-i") 'treemacs-select-window)

(defun denz/org-remove-logs-and-repeats ()
  "Remove all :LOGBOOK: drawers and :LAST_REPEAT: properties in the current buffer."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    ;; Remove LOGBOOK drawers
    ;; Matches :LOGBOOK: ... :END: including the newlines
    (while (re-search-forward "^[ \t]*:LOGBOOK:\\(?:\n\\|.\\)*?:END:[ \t]*\n?" nil t)
      (replace-match ""))
    
    (goto-char (point-min))
    ;; Remove LAST_REPEAT properties
    (while (re-search-forward "^[ \t]*:LAST_REPEAT:.*\n?" nil t)
      (replace-match "")))
  (message "Cleaned up LOGBOOKs and LAST_REPEATs."))

;; defuns
(defun org-scratch-buffer ()
"Create a new scratch buffer -- \*hello-world\*"
(interactive)
  (let ((n 0)
        bufname buffer)
    (catch 'done
      (while t
        (setq bufname (concat "*org-scratch"
          (if (= n 0) "" (int-to-string n))
            "*"))
        (setq n (1+ n))
        (when (not (get-buffer bufname))
          (setq buffer (get-buffer-create bufname))
          (with-current-buffer buffer
            (org-mode))
          ;; When called non-interactively, the `t` targets the other window (if it exists).
          (throw 'done (display-buffer buffer t))) ))))

(defun denz/org-todo-to-done-when-checkboxes-checked ()
  "Set TODO state to DONE when all checkboxes in the current entry are checked."
  (when (org-at-item-checkbox-p)
    (save-excursion
      ;; Go to the heading of the current subtree
      (org-back-to-heading t)
      (let* ((todo-state (org-get-todo-state))
             (beg (save-excursion
                    (org-back-to-heading t)
                    (point)))
             (end (save-excursion
                    (org-end-of-subtree t t)
                    (point)))
             (unchecked (save-excursion
                          (goto-char beg)
                          (re-search-forward "^[ \t]*[-+*] \\[ \\]" end t))))
        ;; Only act if this is a TODO heading
        (when (and todo-state (not unchecked))
          ;(org-todo 'done)
          (denz/org-todo-with-date)
          )))))

;; Add the function to the checkbox statistics hook

(defun denz/org-ongoing ()
  "Change Org todo state to ONGOING and start a pomodoro with the heading title, 
ignoring progress cookies like [/] or [%]."
  (interactive)
  (let* ((raw-title (nth 4 (org-heading-components)))
         ;; Clean the title: remove [2/3], [50%], etc., and trim whitespace
         (heading-title (string-trim 
                         (replace-regexp-in-string "\\[\\([0-9]+/[0-9]+\\|[0-9]+%\\)\\]" "" raw-title))))
    ;; 1. Change the TODO state to ONGOING
    (org-todo "ONGOING")
    ;; 2. Prepare the command string
    (let ((initial-command (format "~/.config/eww/scripts/pomodoro.sh -t \"%s\"" heading-title)))
      (setq current-prefix-arg nil) ; Ensure no prefix args interfere
      (call-interactively 
       (lambda (command)
         (interactive 
          (list (read-shell-command "Shell command: " initial-command)))
         (async-shell-command command))))))

(defun denz/org-todo-with-date (&optional arg)
  (interactive "P")
  (cl-letf* ((org-read-date-prefer-future nil)
             (my-current-time (org-read-date t t nil "when:" nil nil nil))
            ((symbol-function #'org-current-effective-time)
             #'(lambda () my-current-time)))
    (org-todo "DONE")
    )) 

(defun denz/find-file/private ()
  (interactive)
  (counsel-find-file "~/org/Main/Private/"))

(defun denz/double-dashboard ()
  (split-window-horizontally)
  (other-window 1)
  (dashboard-open)
  (other-window 1))

(defun denz/org-schedule-next-task ()
    (interactive)
    (org-todo "TODO")
    (org-schedule nil)
    (message "Changed NEXT task to TODO"))

;; (defun denz/comfort-mode-enable ()
;;   (blink-cursor-mode 1)
;;   (setq-local cursor-type 'bar)
;;   (setq-local line-spacing 2))

;; (when (eq major-mode 'org-mode)
;;   ;; (org-modern-mode 1)
;;   (let* ((variable-tuple
;;           (cond ((x-list-fonts "Lucida Sans Unicode") '(:font "Lucida Sans Unicode"))))
;;          (headline `(:weight bold)))
;;     (custom-theme-set-faces
;;      'user
;;      `(org-drawer ((t (:family "Adwaita Mono"))))
;;      ;; '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
;;      ;; `(org-table ((t (:family "Adwaita Mono"))))
;;      `(org-tag ((t (:inherit default))))
;;      `(org-level-8 ((t (,@headline ,@variable-tuple))))
;;      `(org-level-7 ((t (,@headline ,@variable-tuple))))
;;      `(org-level-6 ((t (,@headline ,@variable-tuple))))
;;      `(org-level-5 ((t (,@headline ,@variable-tuple))))
;;      `(org-level-4 ((t (,@headline ,@variable-tuple))))
;;      `(org-level-3 ((t (,@headline ,@variable-tuple))))
;;      `(org-level-2 ((t (,@headline ,@variable-tuple))))
;;      `(org-level-1 ((t (,@headline ,@variable-tuple)))))))

(defvar-local denz/comfort-face-remap-cookies nil
  "Stores cookies for buffer-local face remappings.")

;; (defun denz/comfort-mode-enable ()
;;   ;; (setq denz/comfort-face-remap-cookies
;;   ;;       (list
;;   ;;        (face-remap-add-relative 'org-hide :family "Lucida Sans Unicode" :foreground "#000000")
;;   ;;        (face-remap-add-relative 'org-indent :inherit 'org-hide)))
;;   (blink-cursor-mode 1)
;;   (setq-local cursor-type 'bar)
;;   (setq-local line-spacing 2)
;;   ;; (org-indent-mode -1)
;;   ;; (setq-local org-hide-leading-stars nil)
;;   ;; (setq-local org-superstar-leading-bullet ?\s)
;;   ;; (setq-local org-indent-mode-turns-on-hiding-stars nil)
;;   ;;
;;   ;; (setq-local org-superstar-remove-leading-stars t)
;;   ;;
;;   (org-superstar-restart)
;;   ;; (setq org-superstar-leading-bullet ?\s)
;;   ;; (setq org-superstar-remove-leading-stars t)
;;   (hl-line-mode -1))
  ;; (org-indent-mode -1)
  ;; (setq org-hide-leading-stars t)
  ;; (setq org-superstar-remove-leading-stars t)
  ;; (setq org-adapt-indentation nil)
  ;; Obsidian-style heading scaling (Only inside Writeroom)
  ;; (when (eq major-mode 'org-mode)
  ;;   (setq-local face-remapping-alist
  ;;               '((org-level-1 :weight bold :inherit variable-pitch)
  ;;                 (org-level-2 :weight bold :inherit variable-pitch)
  ;;                 (org-level-3 :weight bold :inherit variable-pitch)
  ;;                 (org-level-4 :weight bold :inherit variable-pitch)
  ;;                 (org-level-5 :weight bold :inherit variable-pitch)
  ;;                 (org-level-6 :weight bold :inherit variable-pitch)
  ;;                 (org-level-7 :weight bold :inherit variable-pitch)
  ;;                 (org-level-8 :weight bold :inherit variable-pitch)))))

;; (defun denz/comfort-mode-disable ()
;;   (blink-cursor-mode -1)
;;   (setq-local cursor-type 'box)
;;   (setq-local line-spacing nil)
;;   (when (eq major-mode 'org-mode)
;;     (custom-theme-set-faces
;;      'user
;;      `(org-drawer ((t (:family "Adwaita Mono"))))
;;      `(org-tag ((t (:inherit default))))
;;      `(org-indent ((t (:inherit fixed-pitch :foreground ,(face-background 'default nil t)))))
;;      `(org-tag ((t (:inherit default))))
;;      `(org-level-8 ((t (:inherit outline-8))))
;;      `(org-level-7 ((t (:inherit outline-7))))
;;      `(org-level-6 ((t (:inherit outline-6))))
;;      `(org-level-5 ((t (:inherit outline-5))))
;;      `(org-level-4 ((t (:inherit outline-4))))
;;      `(org-level-3 ((t (:inherit outline-3))))
;;      `(org-level-2 ((t (:inherit outline-2))))
;;      `(org-level-1 ((t (:inherit outline-1)))))))

;; (defun denz/comfort-mode-disable ()
;;   ;; (mapc #'face-remap-remove-relative denz/comfort-face-remap-cookies)
;;   ;; (setq denz/comfort-face-remap-cookies nil)
;;   (blink-cursor-mode -1)
;;   (setq-local cursor-type 'box)
;;   (setq-local line-spacing nil)
;;   ;;
;;   ;; (setq-local org-superstar-remove-leading-stars nil)
;;   ;; (org-indent-mode 1)
;;   ;;
;;   ;;
;;   ;; (setq-local org-hide-leading-stars t)
;;   ;; (setq-local org-superstar-leading-bullet " ․")
;;   ;; (setq-local org-indent-mode-turns-on-hiding-stars t)
;;   ;;
;;   (org-superstar-restart)
  
;;   ;; Restore standard theme scaling when leaving Writeroom
;;   (when (eq major-mode 'org-mode)
;;     (setq-local face-remapping-alist nil)))

(defun denz/comfort-mode-enable ()
  (blink-cursor-mode 1)
  (setq-local cursor-type 'bar)
  (setq-local line-spacing 2)
  (when (require 'org-superstar nil t)
    (org-superstar-restart))
  (hl-line-mode -1))

(defun denz/comfort-mode-disable ()
  (blink-cursor-mode -1)
  (setq-local cursor-type 'box)
  (setq-local line-spacing nil)
  (when (require 'org-superstar nil t)
    (org-superstar-restart))
  (when (eq major-mode 'org-mode)
    (setq-local face-remapping-alist nil)))

;; Registers
(set-register ?I (cons 'file "~/org/Main/Productivity/Inbox.org"))
(set-register ?A (cons 'file "~/org/Main/Productivity/Domain/Academics.org"))
(set-register ?C (cons 'file "~/org/Main/Productivity/Domain/Cyber.org"))
(set-register ?D (cons 'file "~/org/Main/Productivity/Domain/Debts & Financial Obligations.org"))
(set-register ?E (cons 'file "~/org/Main/Productivity/Domain/Events.org"))
(set-register ?P (cons 'file "~/org/Main/Productivity/Domain/Personal.org"))
(set-register ?h (cons 'file "~/org/Main/Agenda Specials/Habits.org"))
(set-register ?b (cons 'file "~/org/Main/Agenda Specials/Birthdays.org"))
(set-register ?d (cons 'file "~/org/Main/Agenda Specials/DWMY.org"))
(set-register ?S (cons 'file "~/org/Main/Agenda Specials/Study.org"))

;; org override drawer face
;; org override drawer face
(custom-theme-set-faces
 'user
 `(org-drawer ((t (:family "Iosevka"))))
 `(org-indent ((t (:family "Iosevka" :foreground "#000000"))))
 `(org-hide ((t (:family "Iosevka" :foreground "#000000"))))
 ;; Change fixed-pitch to variable-pitch here:
 ;; `(org-indent ((t (:inherit variable-pitch :foreground ,(face-background 'default nil t)))))
 `(org-tag ((t (:inherit default))))
 )

;; activities.el
;; (use-package! activities
;;   :init
;;   (activities-mode)
;;   (add-hook! 'emacs-startup-hook #'activities-tabs-mode)
;;   ;; Prevent `edebug' default bindings from interfering.
;;   (setq edebug-inhibit-emacs-lisp-mode-bindings t)
;;   ;; (add-hook! 'emacs-startup-hook #'activities-tabs-mode)

;;   :bind
;;   (("C-x C-a C-n" . activities-new)
;;    ("C-x C-a C-d" . activities-define)
;;    ("C-x C-a C-a" . activities-resume)
;;    ("C-x C-a C-s" . activities-suspend)
;;    ("C-x C-a C-k" . activities-kill)
;;    ("C-x C-a RET" . activities-switch)
;;    ("C-x C-a b" . activities-switch-buffer)
;;    ("C-x C-a g" . activities-revert)
;;    ("C-x C-a l" . activities-list)))

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(require 'calfw)
(require 'calfw-org)

;; Add hooks
(add-hook! 'org-checkbox-statistics-hook #'denz/org-todo-to-done-when-checkboxes-checked)
;; (add-hook! 'kill-emacs-hook (lambda ()
;;                              (shell-command "(sleep 5 && cd /home/denz/org/ && git push origin artyom) &")))
;; (remove-hook '+dashboard-functions #'+dashboard-widget-shortmenu)
;; (remove-hook '+dashboard-functions #'dashboard-widget-spacer)
(add-hook! 'org-mode-hook #'doom-disable-line-numbers-h)
;; Remove this line from your init file
;; (add-hook! 'org-agenda-finalize-hook #'org-modern-agenda)

(add-hook! 'org-mode-hook #'doom-disable-line-numbers-h)
(add-hook! 'fountain-mode-hook #'doom-disable-line-numbers-h)
(add-hook! 'fountain-mode-hook #'olivetti-mode)
(add-hook! 'writeroom-mode-enable-hook #'denz/comfort-mode-enable)
(add-hook! 'writeroom-mode-disable-hook #'denz/comfort-mode-disable)
(add-hook! 'fountain-mode-hook (lambda ()
                            (setq buffer-face-mode-face '(:family "Lucida Sans Unicode"))
                            (buffer-face-mode)))
(add-hook! 'org-mode-hook 'org-fragtog-mode)
(add-hook! 'org-mode-hook 'writeroom-mode)
;; (add-hook 'org-todo-repeat-hook #'org-reset-checkbox-state-subtree)
;; (add-hook! 'org-mode-hook (lambda () (org-superstar-mode 1)))
;; (add-hook 'org-mode-hook #'org-modern-indent-mode 90)
;;(add-hook! 'emacs-startup-hook #'denz/command-log-mode-on-startup)
;;(add-hook! 'emacs-startup-hook #'denz/double-dashboard)

;; Alpha background
(add-to-list 'default-frame-alist '(alpha-background . 75))

;; (add-to-list 'safe-local-variable-values '(org-enforce-todo-checkbox-dependencies . nil))
;; (add-to-list 'safe-local-eval-forms '(writeroom-mode -1))

;;;;;;;;;;
;; TEST ;;
;;;;;;;;;;

;; 1. Point to your custom GIF file
;; (setq fancy-splash-image "/path/to/your/animated-logo.gif")

;; 2. Logic to animate the GIF inside the dashboard buffer
;; (defun my-animate-doom-dashboard-gif-v3 ()
;;   "Scan the dashboard buffer for any parsed image properties and forcefully animate them."
;;   (with-current-buffer (get-buffer "+doom-dashboard")
;;     (save-excursion
;;       (goto-char (point-min))
;;       ;; Search through the entire buffer for image text properties
;;       (let ((pos (point)))
;;         (while (< pos (point-max))
;;           (let ((prop (get-text-property pos 'display)))
;;             (when (and (eq (car-safe prop) 'image)
;;                        (plist-get (cdr prop) :type)
;;                        (eq (plist-get (cdr prop) :type) 'gif))
;;               ;; Found it! Force Emacs to begin looping the frames
;;               (image-animate prop nil t)))
;;           (setq pos (next-property-change pos nil (point-max))))))))

;; ;; Use a generic advice layer instead of a basic hook to ensure it executes 
;; ;; *after* Doom's internal redraw finishes painting the screen.
;; (advice-add #'+doom-dashboard/redisplay :after #'my-animate-doom-dashboard-gif-v3)
