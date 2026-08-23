;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; =============================================================================
;; System & Platform Detection
;; =============================================================================

(defconst IS-ANDROID
  (or (eq system-type 'android)
      (getenv "TERMUX_VERSION")
      (string-match-p "Android" (or (getenv "PATH") "")))
  "Non-nil if Emacs is running on Android / Termux.")

;; =============================================================================
;; User & Environment Integration
;; =============================================================================

(after! exec-path-from-shell
  (unless IS-ANDROID
    (dolist (var '("HYPRLAND_INSTANCE_SIGNATURE" "WAYLAND_DISPLAY" "XDG_RUNTIME_DIR"))
      (add-to-list 'exec-path-from-shell-variables var))))

;; =============================================================================
;; Visuals, Fonts & Display
;; =============================================================================

;; Line numbers
(setq display-line-numbers-type t)

;; Desktop-specific UI tweaks
(unless IS-ANDROID
  (setq doom-font (font-spec :family "Iosevka" :size 19 :weight 'semi-light)
        doom-variable-pitch-font (font-spec :family "Lucida Sans Unicode" :size 18))

  (setq doom-themes-custom-config-dir "~/.config/doom/themes/")
  (setq doom-theme 'doom-organic-chemistry-tutor)

  (let ((splash-path (expand-file-name "~/Pictures/MVC2.jpeg")))
    (when (file-exists-p splash-path)
      (setq fancy-splash-image splash-path)))

  ;; Frame transparency and performance settings
  (add-to-list 'default-frame-alist '(alpha-background . 75))
  (add-to-list 'default-frame-alist '(inhibit-double-buffering . t)))

;; Mobile font scaling adjustments (if running GUI Emacs on Android)
(when IS-ANDROID
  (setq doom-font (font-spec :family "Monospace" :size 14))
  (setq doom-theme 'doom-one))

;; Enable electric indent except on newlines
(setq electric-indent-chars (remq ?\n electric-indent-chars))

;; Performance / Behavior adjustments
(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)
(setq warning-suppress-types (append warning-suppress-types '((org-element-cache))))
(setq global-auto-revert-non-file-buffers t)

;; Evil setup
(setq evil-set-undo-system 'undo-redo)
(setq evil-want-C-i-jump nil)

;; =============================================================================
;; Org Core Settings & Directory Paths
;; =============================================================================

(setq org-directory (expand-file-name "~/org/"))
(setq org-mobile-directory (expand-file-name "~/org/"))

(after! org
  (setq org-group-tags t)
  (setq org-habit-graph-column 60)
  (setq org-agenda-start-day "-0d")
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-into-drawer t)
  (setq org-extend-today-until 3)
  (setq org-archive-location (expand-file-name "~/org/Archive/Archived Entries.org::"))
  (setq org-startup-with-inline-images (not IS-ANDROID))
  (setq org-enforce-todo-checkbox-dependencies t)

  ;; Visual Tweaks
  (setq org-ellipsis " ▼")
  (setq org-hide-emphasis-markers t)
  (setq writeroom-width 66)

  ;; Modern & Superstar Configuration
  (setq org-modern-star nil
        org-modern-todo nil
        org-modern-date-active nil
        org-modern-tag nil
        org-modern-list '((?- . "•") (?+ . "‣")))

  ;; Modules & Libraries
  (add-to-list 'org-modules 'org-habit)
  (require 'org-habit nil t)
  (require 'org-checklist nil t)

  ;; Agenda Files & Custom Commands
  (setq org-agenda-files (mapcar #'expand-file-name
                                 '("~/org/Main/Productivity/"
                                   "~/org/Main/Productivity/Domain"
                                   "~/org/Main/Agenda Specials")))

  (setq org-agenda-custom-commands
        '(("G" "Productivity view"
           ((todo "NEXT" ((org-agenda-overriding-header "Next")))
            (tags-todo "+inbox")))
          ("r" "Recurring"
           ((tags-todo "+habits"
                       ((org-agenda-overriding-header "Habits"))
                       (org-agenda-show-log t))
            (tags-todo "+dwmy"
                       ((org-agenda-overriding-header "Daily, Monthly, & Weekly"))
                       (org-agenda-show-log t))))
          ("c" "Daily clean view (no recur)" agenda ""
           ((org-agenda-span 1)
            (org-agenda-tag-filter-preset '("-recur"))))
          ("w" "Daily Work Agenda"
           ((agenda "" ((org-agenda-span 1)
                        (org-agenda-overriding-header "Daily Work Tasks")
                        (org-agenda-skip-function
                         '(org-agenda-skip-entry-if 'notregexp ":recur:"))))))
          ("u" "Active TODOs Only"
           ((agenda "" ((org-agenda-overriding-header "Daily Action Items")
                        (org-agenda-skip-function
                         '(org-agenda-skip-entry-if 'nottodo 'todo))))))))

  ;; Refile Targets
  (setq org-refile-targets
        (mapcar (lambda (entry) (cons (expand-file-name (car entry)) (cdr entry)))
                '(("~/org/Main/Productivity/Domain/Academics.org" :maxlevel . 9)
                  ("~/org/Main/Productivity/Domain/Cyber.org" :maxlevel . 9)
                  ("~/org/Main/Productivity/Domain/Debts & Financial Obligations.org" :maxlevel . 9)
                  ("~/org/Main/Productivity/Domain/Events.org" :maxlevel . 9)
                  ("~/org/Main/Productivity/Domain/Personal.org" :maxlevel . 9)
                  ("~/org/Main/Franchise Catalog.org" :maxlevel . 9)
                  ("~/org/Main/Music Matrix.org" :maxlevel . 9)
                  ("~/org/Main/Reading List.org" :maxlevel . 9)
                  ("~/org/Main/Recipe Record.org" :maxlevel . 9)
                  ("~/org/Main/Agenda Specials/Birthdays.org" :maxlevel . 1)
                  ("~/org/Main/Agenda Specials/Events.org" :maxlevel . 9)
                  ("~/org/Archive/Mega Archive.org" :maxlevel . 9)))))

;; =============================================================================
;; Org Ecosystem Packages (Roam, Excalidraw, Krita)
;; =============================================================================

(use-package! org-roam
  :after org
  :config
  (setq org-roam-v2-ack t)
  (setq org-roam-completion-everywhere t)
  (setq org-roam-directory (expand-file-name "~/org/Roam"))
  (setq org-roam-dailies-directory (expand-file-name "~/org/Roam/Journal"))

  (setq org-roam-capture-templates
        '(("d" "Default" plain "%?"
           :target (file+head "%<%Y%m%d%H%M%S>.org"
                              "#+title: ${title}\n#+filetags:")
           :unnarrowed t)))

  (setq org-roam-dailies-capture-templates
        '(("J" "Journal" entry "** %<%I:%M %p>: %?"
           :target (file+head+olp "%<%Y-%m-%d>.org"
                                  "#+title: %<%Y-%m-%d>\n#+filetags: daily\n\n* Reminders\n\n* Journal"
                                  ("Journal"))
           :unnarrowed t)))

  (add-to-list 'org-roam-capture-templates
               '("i" "Inbox / Quick Capture" entry
                 "* %?\n:PROPERTIES:\n:CAPTURED: %U\n:END:\n"
                 :target (file+head "inbox.org" "#+title: Inbox\n#+filetags: :inbox:\n")
                 :empty-lines 1)))

(unless IS-ANDROID
  (use-package! org-excalidraw
    :after org
    :config
    (setq org-excalidraw-directory (expand-file-name "~/org/excalidraw/"))
    (org-excalidraw-initialize))

  (use-package! org-krita
    :after org
    :config
    (add-hook 'org-mode-hook #'org-krita-mode)))

(use-package! org-superstar
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-prettify-item-bullets t)
  (setq org-superstar-remove-leading-stars t))

;; =============================================================================
;; Org Capture Templates
;; =============================================================================

(after! org
  (setq org-capture-templates
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

          ("dd" "Debts & Financial Obligations")
          ("de" "Events")
          ("da" "Academics")

          ("i" "Inbox")
          ("it" "Task")
          ("itn" "Task - NEXT" entry (file "~/org/Main/Productivity/Inbox.org") "* NEXT %?")
          ("its" "Task - TODO, SCHEDULED" entry (file "~/org/Main/Productivity/Inbox.org") "* TODO \n%?SCHEDULED: <%<%Y-%m-%d>>")
          ("itd" "Task - TODO, DEADLINE" entry (file "~/org/Main/Productivity/Inbox.org") "* TODO \n%?DEADLINE: <%<%Y-%m-%d>>")

          ("ie" "Regular entry" entry (file "~/org/Main/Productivity/Inbox.org") "* %?")
          ("ic" "Timestamp" entry (file "~/org/Main/Productivity/Inbox.org") "* %?\n<%<%Y-%m-%d>>"))))

;; =============================================================================
;; Custom Keybindings & Registers
;; =============================================================================

(global-unset-key (kbd "C-s"))
(global-unset-key (kbd "C-r"))

(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-r") 'swiper)

(unless IS-ANDROID
  (global-set-key [f12] '+treemacs/toggle))

(let ((reg-file (lambda (char path)
                  (set-register char (cons 'file (expand-file-name path))))))
  (funcall reg-file ?I "~/org/Main/Productivity/Inbox.org")
  (funcall reg-file ?A "~/org/Main/Productivity/Domain/Academics.org")
  (funcall reg-file ?C "~/org/Main/Productivity/Domain/Cyber.org")
  (funcall reg-file ?D "~/org/Main/Productivity/Domain/Debts & Financial Obligations.org")
  (funcall reg-file ?E "~/org/Main/Productivity/Domain/Events.org")
  (funcall reg-file ?P "~/org/Main/Productivity/Domain/Personal.org")
  (funcall reg-file ?h "~/org/Main/Agenda Specials/Habits.org")
  (funcall reg-file ?b "~/org/Main/Agenda Specials/Birthdays.org")
  (funcall reg-file ?d "~/org/Main/Agenda Specials/DWMY.org")
  (funcall reg-file ?S "~/org/Main/Agenda Specials/Study.org"))

;; =============================================================================
;; Helper Functions & Custom Defuns
;; =============================================================================

(defun denz/org-remove-logs-and-repeats ()
  "Remove all :LOGBOOK: drawers and :LAST_REPEAT: properties in current buffer."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "^[ \t]*:LOGBOOK:\\(?:\n\\|.\\)*?:END:[ \t]*\n?" nil t)
      (replace-match ""))
    (goto-char (point-min))
    (while (re-search-forward "^[ \t]*:LAST_REPEAT:.*\n?" nil t)
      (replace-match "")))
  (message "Cleaned up LOGBOOKs and LAST_REPEATs."))

(defun org-scratch-buffer ()
  "Create a new org-mode scratch buffer."
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
          (throw 'done (display-buffer buffer t)))))))

(defun denz/org-todo-with-date (&optional _arg)
  (interactive "P")
  (cl-letf* ((org-read-date-prefer-future nil)
             (my-current-time (org-read-date t t nil "when:" nil nil nil))
             ((symbol-function #'org-current-effective-time)
              (lambda () my-current-time)))
    (org-todo "DONE")))

(defun denz/org-todo-to-done-when-checkboxes-checked ()
  "Set TODO state to DONE when all checkboxes in the current entry are checked."
  (when (org-at-item-checkbox-p)
    (save-excursion
      (org-back-to-heading t)
      (let* ((todo-state (org-get-todo-state))
             (beg (point))
             (end (save-excursion (org-end-of-subtree t t) (point)))
             (unchecked (save-excursion
                          (goto-char beg)
                          (re-search-forward "^[ \t]*[-+*] \\[ \\]" end t))))
        (when (and todo-state (not unchecked))
          (denz/org-todo-with-date))))))

(defun denz/org-ongoing ()
  "Change Org todo state to ONGOING and start a pomodoro via shell."
  (interactive)
  (let* ((raw-title (nth 4 (org-heading-components)))
         (heading-title (string-trim
                         (replace-regexp-in-string "\\[\\([0-9]+/[0-9]+\\|[0-9]+%\\)\\]" "" raw-title))))
    (org-todo "ONGOING")
    (let ((initial-command (format "~/.config/eww/scripts/pomodoro.sh -t \"%s\"" heading-title)))
      (setq current-prefix-arg nil)
      (call-interactively
       (lambda (command)
         (interactive (list (read-shell-command "Shell command: " initial-command)))
         (async-shell-command command))))))

(defun denz/find-file/private ()
  (interactive)
  (counsel-find-file "~/org/Main/Private/"))

(defun denz/double-dashboard ()
  (interactive)
  (split-window-horizontally)
  (other-window 1)
  (+doom-dashboard/open)
  (other-window 1))

(defun denz/org-schedule-next-task ()
  (interactive)
  (org-todo "TODO")
  (org-schedule nil)
  (message "Changed NEXT task to TODO"))

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

;; =============================================================================
;; Hooks & Integrations
;; =============================================================================

(add-hook! 'org-checkbox-statistics-hook #'denz/org-todo-to-done-when-checkboxes-checked)
(add-hook! 'org-mode-hook #'doom-disable-line-numbers-h)
(add-hook! 'org-mode-hook #'org-fragtog-mode)

(unless IS-ANDROID
  (add-hook! 'fountain-mode-hook #'doom-disable-line-numbers-h)
  (add-hook! 'fountain-mode-hook #'olivetti-mode)
  (add-hook! 'writeroom-mode-enable-hook #'denz/comfort-mode-enable)
  (add-hook! 'writeroom-mode-disable-hook #'denz/comfort-mode-disable)
  (add-hook! 'org-mode-hook #'writeroom-mode)
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

(custom-theme-set-faces
 'user
 `(org-drawer ((t (:family "Iosevka"))))
 `(org-indent ((t (:family "Iosevka" :foreground "#000000"))))
 `(org-hide ((t (:family "Iosevka" :foreground "#000000"))))
 `(org-tag ((t (:inherit default)))))

;; =============================================================================
;; Safe Local Variables & Dynamic Face Configuration
;; =============================================================================

;; Mark variables safe without writing to custom.el
(add-to-list 'safe-local-variable-values '(org-enforce-todo-checkbox-dependencies . t))

;; Cross-platform Face Adjustments
(after! org
  (if IS-ANDROID
      ;; Mobile / Termux Fallback Faces
      (custom-theme-set-faces! 'user
        '(org-drawer :inherit default)
        '(org-indent :inherit default)
        '(org-hide   :inherit default)
        '(org-tag    :inherit default))
    ;; Desktop Custom Faces
    (custom-theme-set-faces! 'user
      '(org-drawer :family "Iosevka")
      '(org-indent :family "Iosevka" :foreground "#000000")
      '(org-hide   :family "Iosevka" :foreground "#000000")
      '(org-tag    :inherit default))))
