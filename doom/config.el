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
;;

(setq doom-font (font-spec :family "Adwaita Mono" :size 16 :weight 'semi-light))
(setq doom-variable-pitch-font (font-spec :family "Lucida Sans Unicode" :size 15))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)
(setq fancy-splash-image "~/Pictures/Splash/Spamtenna.png")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

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

(setq evil-set-undo-system 'undo-redo)
(setq evil-want-C-i-jump nil)
;;; Global preferences
(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)
(setq warning-suppress-types (append warning-suppress-types '((org-element-cache))))

;;; Doom Emacs performace boost recommendations
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
(setq company-idle-delay nil)
(setq global-auto-revert-non-file-buffers t)
(setq org-startup-with-inline-images t)

;;; Custom keybindings

;; hyper key shortcuts: http://ergoemacs.org/emacs/emacs_hyper_super_keys.html
;; (setq ns-function-modifier 'hyper)  ; make Fn key do Hyper

(global-unset-key (kbd "M-o"))
(global-unset-key (kbd "C-s"))
(global-unset-key (kbd "C-r"))
(global-unset-key (kbd "C-c n d"))
(global-unset-key (kbd "C-x D C-f"))

(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-r") 'swiper)
(global-set-key (kbd "C-x o") 'org-capture)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key [f12] '+treemacs/toggle)
(global-set-key (kbd "M-i") 'treemacs-select-window)

;;; defuns
(defun denz/find-file/private ()
  (interactive)
  (counsel-find-file "~/org/Main/Private/"))

(defun denz/double-dashboard ()
  (split-window-horizontally)
  (other-window 1)
  (dashboard-open)
  (other-window 1))
;; (defun denz/org-archive-done-tasks ()
;;   (interactive)
;;   (org-map-entries
;;    (lambda ()
;;      (org-archive-subtree)
;;      (setq org-map-continue-from (org-element-property :begin (org-element-at-point))))
;;    "/+DONE" 'tree))
;; (defun denz/command-log-mode-on-startup ()
;; (clm/toggle-command-log-buffer)
;; (other-window 1)
;; (text-scale-adjust))
(defun denz/org-schedule-next-task ()
    (interactive)
    (org-todo "TODO")
    (org-schedule nil)
    (message "Changed NEXT task to TODO"))

;;; Registers
(set-register ?I (cons 'file "~/org/Main/Productivity/Inbox.org"))
(set-register ?S (cons 'file "~/org/Main/Productivity/S&S.org"))
(set-register ?A (cons 'file "~/org/Main/Productivity/Domain/Academics.org"))
(set-register ?C (cons 'file "~/org/Main/Productivity/Domain/Cyber.org"))
(set-register ?D (cons 'file "~/org/Main/Productivity/Domain/Debts & Financial Obligations.org"))
(set-register ?E (cons 'file "~/org/Main/Productivity/Domain/Events.org"))
(set-register ?P (cons 'file "~/org/Main/Productivity/Domain/Personal.org"))
(set-register ?h (cons 'file "~/org/Main/Agenda Specials/Habits.org"))
(set-register ?b (cons 'file "~/org/Main/Agenda Specials/Birthdays.org"))
(set-register ?d (cons 'file "~/org/Main/Agenda Specials/DWMY.org"))

;;;;;;;;;;;;;;;
;; ADD HOOKS ;;
;;;;;;;;;;;;;;;

(add-hook! 'org-mode-hook #'doom-disable-line-numbers-h)
(add-hook! 'org-mode-hook #'doom-disable-line-numbers-h)
(add-hook! 'fountain-mode-hook #'doom-disable-line-numbers-h)
(add-hook! 'fountain-mode-hook #'olivetti-mode)
(add-hook 'writeroom-mode-enable-hook #'denz/comfort-mode-enable)
(add-hook 'writeroom-mode-disable-hook #'denz/comfort-mode-disable)
;;(add-hook! 'emacs-startup-hook #'denz/command-log-mode-on-startup)
;;(add-hook! 'emacs-startup-hook #'denz/double-dashboard)

;;; org beautification
(setq org-modern-list nil)


;;;; org override drawer face
(custom-theme-set-faces
     'user
     `(org-drawer ((t (:family "Adwaita Mono")))))
;; (custom-set-faces '(org-table ((t (:family "Adwaita Mono")))))

(setq org-hide-emphasis-markers t)
(setq org-hide-leading-stars nil)
(setq org-superstar-leading-bullet ?\s)
(setq org-indent-mode-turns-on-hiding-stars nil)
;; (setq org-modern-star nil)
;; (setq org-modern-todo nil)
;; (setq org-modern-priority nil)
;;(setq org-modern-table nil)
(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

;;; org-capture
(after! org
  ;; (setq org-extend-today-until 4)
  (setq org-ellipsis " ▼")



  (add-hook 'org-todo-repeat-hook #'org-reset-checkbox-state-subtree)
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
          )))

;;; org-roam
(setq org-roam-v2-ack t)
;; (setq org-roam-dailies-capture-templates
;;         '(("J" "Journal" entry "** %<%I:%M %p>: %?"
;;            :target (file+head+olp "%<%Y-%m-%d>.org"
;;                                  "#+title: %<%Y-%m-%d>\n#+filetags: daily\n\n* Reminders\n\n* Journal"
;;                                   ("Journal"))
;;            :unnarrowed t)))

(setq org-roam-completion-everywhere t)
(setq org-roam-directory "~/org/Roam")
(setq org-roam-dailies-directory "~/org/Roam/Journal")
(setq org-roam-capture-templates '(("d" "default" plain "%?"
                                    :target (file+head "%<%Y%m%d%H%M%S>.org"
                                                       "#+title: ${title}\n#+filetags: ")
                                    :unnarrowed t)))
(use-package! org-roam
  ;; :bind (("C-c n l" . org-roam-buffer-toggle)
  ;;      ("C-c n j" . org-roam-node-find)
  ;;      ("C-c n i" . org-roam-node-insert)
  ;;      :map org-mode-map
  ;;      ("C-M-i" . completion-at-point)
  ;;      :map org-roam-dailies-map
  ;;      ("Y" . org-roam-dailies-capture-yesterday)
  ;;      ("T" . org-roam-dailies-capture-tomorrow))
  ;; :bind-keymap
  ;; ("C-c C-n C-d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies)
  (org-roam-db-autosync-mode))


;; (setq org-excalidraw-directory "~/org/Excalidraw")

;;; org mode productivity
(require 'org-habit)
(add-to-list 'org-modules 'org-habit)
(setq org-habit-graph-column 60)

(setq org-pomodoro-length 50)
(setq org-pomodoro-short-break-length 10)

(setq org-agenda-start-with-log-mode t)
(setq org-log-done 'time)
(setq org-log-into-drawer t)

(setq org-agenda-files ` ("~/org/Main/Productivity/"
                          "~/org/Main/Productivity/Domain"
                          "~/org/Main/Agenda Specials"))

(setq org-agenda-custom-commands
      '(("G" "Productivity view"
         ((todo "NEXT"
                ((org-agenda-overriding-header "Next")))
          (tags-todo "+inbox"
        	     ((org-agenda-overriding-header "Inbox")))
          (tags-todo "+snooze"
        	     ((org-agenda-overriding-header "Snooze")))
          (tags-todo "+someday"
        	     ((org-agenda-overriding-header "Someday")))
          ))
        ("r" "Recurring"
         ((tags-todo "+habits"
        	     ((org-agenda-overriding-header "Habits"))
        	     (org-agenda-show-log t))
          (tags-todo "+dwm"
        	     ((org-agenda-overriding-header "Daily, Monthly, & Weekly"))
        	     (org-agenda-show-log t))
          ))))

;;archive
(setq org-archive-location "~/org/Archive/Archived Entries.org::")

;; Agenda-centric
(setq org-agenda-start-day "-0d")
(after! org (org-super-agenda-mode t))
(add-to-list 'org-agenda-custom-commands
             '("W" "Clean agenda (week)" agenda ""
               ((org-super-agenda-groups
                 '((:discard (:tag ("recur")))))
                (org-agenda-span 7))))
(add-to-list 'org-agenda-custom-commands
             '("3" "Clean agenda (3 days)" agenda ""
               ((org-super-agenda-groups
                 '((:discard (:tag ("recur")))))
                (org-agenda-span 3))))
(add-to-list 'org-agenda-custom-commands
             '("D" "Clean agenda (day)" agenda ""
               ((org-super-agenda-groups '((:discard (:tag ("recur")))))
                (org-agenda-span 'day))))
(add-to-list 'org-agenda-custom-commands
             '("R" "Recurring agenda view" agenda ""
               ((org-super-agenda-groups '((:tag ("recur"))))
                (org-agenda-span 'day))))

(setq org-refile-targets
      '(;; Productivitys
        ("~/org/Main/Productivity/Domain/Academics.org" :maxlevel . 9)
        ("~/org/Main/Productivity/Domain/Cyber.org" :maxlevel . 9)
        ("~/org/Main/Productivity/Domain/Debts & Financial Obligations.org" :maxlevel . 9)
        ("~/org/Main/Productivity/Domain/Events.org" :maxlevel 9)
        ("~/org/Main/Productivity/Domain/Personal.org" :maxlevel . 9)
        ;; Outerorgs
        ;; ("~/org/Main/Franchise Catalog.org" :maxlevel . 2)
        ;; ("~/org/Main/Music Matrix.org" :maxlevel . 2)
        ;; ("~/org/Main/Reading List.org" :maxlevel . 2)
        ;; ("~/org/Main/Recipe Record.org" :maxlevel . 2)
        ;; ;; MECs
        ;; ("~/org/Main/Agenda Specials/Birthdays.org" :maxlevel . 2)
        ;; ("~/org/Main/Agenda Specials/Events.org" :maxlevel . 2)
        ;; ("~/org/Main/Agenda Specials/D-W-M.org" :maxlevel . 2)
        ;; ;; Archive
        ;; ("~/org/Archive/Mega Archive.org" :maxlevel . 2)
        ;; ;; Habits.org
        ;; ("~/org/Main/Agenda Specials/Habits.org" :maxlevel . 2)
        ))

;; (use-package! org-roam-ui
;;     :after org-roam ;; or :after org
;; ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;; ;;         a hookable mode anymore, you're advised to pick something yourself
;; ;;         if you don't care about startup time, use
;; ;;  :hook (after-init . org-roam-ui-mode)
;;     :config
;;     (setq org-roam-ui-sync-theme t
;;           org-roam-ui-follow t
;;           org-roam-ui-update-on-save t
;;           org-roam-ui-open-on-start t))

;; (setq org-modern-star nil)
;; (setq org-modern-todo nil)
;; (setq org-modern-priority nil)
;;

;; (setq org-latex-create-formula-image-program 'dvipng)

(defun denz/comfort-mode-enable ()
  "Enable comfort mode settings."
  (blink-cursor-mode 1)  ; Enable blinking cursorp
  (setq-local cursor-type 'bar)  ; Set cursor type to bar; doesn't seem to work cz of my evil mode??
  (setq-local line-spacing 2))  ; Set line spacing
;; Enable org-modern-mode only for Org buffers
(when (eq major-mode 'org-mode)
  ;; (org-modern-mode 1)
  (let* ((variable-tuple
          (cond ((x-list-fonts "Lucida Sans Unicode") '(:font "Lucida Sans Unicode"))))
         (headline `(:weight bold)))
    (custom-theme-set-faces
     'user
     `(org-drawer ((t (:family "Adwaita Mono"))))
     ;; `(org-table ((t (:family "Adwaita Mono"))))
     `(org-tag ((t (:inherit default))))
     `(org-level-8 ((t (,@headline ,@variable-tuple))))
     `(org-level-7 ((t (,@headline ,@variable-tuple))))
     `(org-level-6 ((t (,@headline ,@variable-tuple))))
     `(org-level-5 ((t (,@headline ,@variable-tuple))))
     `(org-level-4 ((t (,@headline ,@variable-tuple))))
     `(org-level-3 ((t (,@headline ,@variable-tuple))))
     `(org-level-2 ((t (,@headline ,@variable-tuple))))
     `(org-level-1 ((t (,@headline ,@variable-tuple)))))))

(defun denz/comfort-mode-disable ()
  "Disable comfort mode settings."
  (blink-cursor-mode -1)  ; Disable blinking cursor
  (setq-local cursor-type 'box)  ; Reset cursor type to box
  (setq-local line-spacing nil)  ; Reset line spacing

  ;; Disable org-modern-mode only for Org buffers
  (when (eq major-mode 'org-mode)
    ;; (org-modern-mode -1)
    ;; Reset org-level styles to default, not sure here
    (custom-theme-set-faces
     'user
     `(org-drawer ((t (:family "Adwaita Mono"))))
     `(org-tag ((t (:inherit default))))
     `(org-level-8 ((t (:inherit outline-8))))
     `(org-level-7 ((t (:inherit outline-7))))
     `(org-level-6 ((t (:inherit outline-6))))
     `(org-level-5 ((t (:inherit outline-5))))
     `(org-level-4 ((t (:inherit outline-4))))
     `(org-level-3 ((t (:inherit outline-3))))
     `(org-level-2 ((t (:inherit outline-2))))
     `(org-level-1 ((t (:inherit outline-1)))))))

(use-package! activities
  :init
  (activities-mode)
  (add-hook! 'emacs-startup-hook #'activities-tabs-mode)
  ;; Prevent `edebug' default bindings from interfering.
  (setq edebug-inhibit-emacs-lisp-mode-bindings t)
  ;; (add-hook! 'emacs-startup-hook #'activities-tabs-mode)

  :bind
  (("C-x C-a C-n" . activities-new)
   ("C-x C-a C-d" . activities-define)
   ("C-x C-a C-a" . activities-resume)
   ("C-x C-a C-s" . activities-suspend)
   ("C-x C-a C-k" . activities-kill)
   ("C-x C-a RET" . activities-switch)
   ("C-x C-a b" . activities-switch-buffer)
   ("C-x C-a g" . activities-revert)
   ("C-x C-a l" . activities-list)))

(use-package! org-krita
  :config
  (add-hook 'org-mode-hook 'org-krita-mode))

;;;;;;;;;;;;;;;
;; ADD HOOKS ;;
;;;;;;;;;;;;;;;

;; (defun denz/auto-commit-and-push-on-exit ()
;;   "Automatically commit and push a Git repository when exiting Emacs.
;; Checks if the specified directory is a Git repository and has changes."
;;   (interactive)
;;   (let ((repo-dir "~/org/")  ; Replace with your repository path
;;         (commit-message (format-time-string "Automatic commit %Y-%m-%d %H:%M:%S")))
;;     (when (file-directory-p repo-dir)
;;       (let ((default-directory repo-dir))
;;         (when (and (executable-find "git")
;;                    (file-directory-p (expand-file-name ".git" repo-dir)))
;;           (call-process "git" nil nil nil "add" ".")
;;           (unless (zerop (call-process "git" nil nil nil "diff-index" "--quiet" "HEAD" "--"))
;;             (call-process "git" nil nil nil "commit" "-m" commit-message)
;;             (call-process "git" nil nil nil "push")))))))

;; (add-hook 'kill-emacs-hook #'denz/auto-commit-and-push-on-exit)

(add-hook! 'org-mode-hook #'doom-disable-line-numbers-h)
(add-hook! 'org-mode-hook #'doom-disable-line-numbers-h)
(add-hook! 'fountain-mode-hook #'doom-disable-line-numbers-h)
(add-hook! 'fountain-mode-hook #'olivetti-mode)
(add-hook! 'writeroom-mode-enable-hook #'denz/comfort-mode-enable)
(add-hook! 'writeroom-mode-disable-hook #'denz/comfort-mode-disable)
(add-hook! 'fountain-mode-hook (lambda ()
                            (setq buffer-face-mode-face '(:family "Lucida Sans Unicode"))
                            (buffer-face-mode)))
(add-hook! 'org-mode-hook 'org-fragtog-mode)
;;(add-hook! 'emacs-startup-hook #'denz/command-log-mode-on-startup)
;;(add-hook! 'emacs-startup-hook #'denz/double-dashboard)
;;

;; (add-to-list 'default-frame-alist '(alpha-background . 82))
