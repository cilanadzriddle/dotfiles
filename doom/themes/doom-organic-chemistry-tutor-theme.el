;;; doom-organic-chemistry-tutor-theme.el --- Inspired by the STEM digital chalkboard -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Author: Gemini AI
;; Keywords: themes, dark, neon, chalkboard
;;
;;; Commentary:
;; A high-contrast, neon-on-black theme replicating the visual style of
;; The Organic Chemistry Tutor on YouTube. Ideal for late-night coding/studying.
;;
;;; Code:

(require 'doom-themes)

;;
;;; Variables

(defgroup doom-organic-chemistry-tutor-theme nil
  "Options for the `doom-organic-chemistry-tutor' theme."
  :group 'doom-themes)

(defcustom doom-oct-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-organic-chemistry-tutor-theme
  :type 'boolean)

(defcustom doom-oct-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line."
  :group 'doom-organic-chemistry-tutor-theme
  :type '(choice integer boolean))

;;
;;; Theme definition

(def-doom-theme doom-organic-chemistry-tutor
  "A pitch-black theme with high-contrast neon inks."

  ;; name        default    256        16
  ((bg         '("#000000" "#000000" "black"        )) ; Pure chalkboard background
   (bg-alt     '("#121212" "#1c1c1c" "black"        )) ; Subtle differentiation
   (base0      '("#121212" "#1c1c1c" "black"        ))
   (base1      '("#1a1a1a" "#1e1e1e" "brightblack"  ))
   (base2      '("#262626" "#2e2e2e" "brightblack"  ))
   (base3      '("#333333" "#262626" "brightblack"  ))
   (base4      '("#4d4d4d" "#3f3f3f" "brightblack"  )) ; Muted grey for borders
   (base5      '("#666666" "#525252" "brightblack"  )) ; Comments
   (base6      '("#a6a6a6" "#bbbbbb" "brightblack"  ))
   (base7      '("#d9d9d9" "#cccccc" "brightblack"  ))
   (base8      '("#ffffff" "#dfdfdf" "white"        ))
   (fg         '("#ffffff" "#ffffff" "white"        )) ; Pure Chalk White body text
   (fg-alt     '("#e6e6e6" "#bfbfbf" "brightwhite"  ))

   (grey       base5)
   (red        '("#ff0000" "#ff3333" "red"          )) ; Formal charges & Errors
   (orange     '("#ff6600" "#ff6622" "brightred"    ))
   (green      '("#00ff00" "#33ff33" "green"        )) ; Functional groups & Functions
   (teal       '("#00ffcc" "#00ffaa" "brightgreen"  ))
   (yellow     '("#ffff00" "#ffff33" "yellow"       )) ; Highlight variables / Strings
   (blue       '("#3399ff" "#3399ff" "brightblue"   ))
   (dark-blue  '("#0044cc" "#0044cc" "blue"         )) ; Region selections
   (magenta    '("#ff00ff" "#ff33ff" "magenta"      )) ; Keywords & Mechanisms
   (violet     '("#cc66ff" "#cc66ff" "brightmagenta"))
   (cyan       '("#00ffff" "#33ffff" "brightcyan"   )) ; Arrows / Constants
   (dark-cyan  '("#00a3a3" "#00aaaa" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight       cyan)
   (vertical-bar    base3)
   (selection       dark-blue)
   (builtin         cyan)         ; Built-ins rendered in mechanism neon cyan
   (comments        base5)        ; Clean, readable grey so it doesn't clash with neon code
   (doc-comments    base6)
   (constants       cyan)         ; Molecular constants / Static values
   (functions       green)        ; Functions pop like green functional groups
   (keywords        magenta)      ; Core logic statements in bright pink
   (methods         teal)
   (operators       yellow)       ; Mathematical symbols stand out in yellow
   (type            violet)
   (strings         yellow)       ; Text literals
   (variables       fg)           ; Keep basic variables standard chalk white
   (numbers         cyan)         ; Math variables/coefficients
   (region          `(,(car base3) ,@(cdr base1)))
   (error           red)          ; Clear red marks
   (warning         yellow)
   (success         green)
   (vc-modified     orange)
   (vc-added        green)
   (vc-deleted      red)

   ;; Custom Org/Outline tiers mimicking tutorial presentation structures
   ;;;;;;;;;;;;;;;;;;;;;;
   ;; ;; Gemini        ;;
   ;; (level1 cyan)    ;;
   ;; (level2 green)   ;;
   ;; (level3 yellow)  ;;
   ;; (level4 magenta) ;;
   ;; (level5 violet)  ;;
   ;; (level6 teal)    ;;
   ;; (level7 blue)    ;;
   ;; (level8 fg)      ;;
   ;;;;;;;;;;;;;;;;;;;;;;
   (level1 "#0000ff")
   (level2 red)
   (level3 yellow)
   (level4 green)
   (level8 cyan)
   (level6 magenta)
   (level5 "#ff4f00")
   (level7 "#9d00ff")

   (-modeline-bright doom-oct-brighter-modeline)
   (-modeline-pad
    (when doom-oct-padded-modeline
      (if (integerp doom-oct-padded-modeline) doom-oct-padded-modeline 4)))

   (region-alt `(,(car base3) ,@(cdr base4)))

   (modeline-fg     'unspecified)
   (modeline-fg-alt base5)

   (modeline-bg
    (if -modeline-bright
        (doom-darken cyan 0.6)
      `(,(doom-darken (car bg) 0.15) ,@(cdr base0))))
   (modeline-bg-l
    (if -modeline-bright
        (doom-darken cyan 0.675)
      `(,(car bg) ,@(cdr base0))))
   (modeline-bg-inactive   `(,(doom-darken (car bg) 0.075) ,@(cdr base1)))
   (modeline-bg-inactive-l (doom-darken bg 0.1)))


  ;;;; Base theme face overrides
  (((line-number &override) :foreground base4 :background bg)
   ((line-number-current-line &override) :foreground yellow :background base1 :weight 'bold)
   ((font-lock-comment-face &override) :slant 'italic)
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if -modeline-bright base8 highlight))

   ;;;; company (Autocompletion dropdown)
   (company-tooltip           :background base1 :foreground fg)
   (company-tooltip-selection :background base3 :foreground cyan :weight 'bold)
   (company-tooltip-common    :foreground yellow)

   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground cyan)
   ((markdown-code-face &override) :background base1)

   ;;;; outline / headings
   ((outline-1 &override) :foreground level1 :weight 'bold)
   (outline-2 :inherit 'outline-1 :foreground level2)
   (outline-3 :inherit 'outline-2 :foreground level3)
   (outline-4 :inherit 'outline-3 :foreground level4)
   (outline-5 :inherit 'outline-4 :foreground level5)
   (outline-6 :inherit 'outline-5 :foreground level6)
   (outline-7 :inherit 'outline-6 :foreground level7)
   (outline-8 :inherit 'outline-7 :foreground level8)

   ;;;; org-mode
   ((org-level-1 &override) :inherit 'outline-1)
   ((org-level-2 &override) :inherit 'outline-2)
   ((org-level-3 &override) :inherit 'outline-3)
   ((org-level-4 &override) :inherit 'outline-4)
   ((org-level-5 &override) :inherit 'outline-5)
   ((org-level-6 &override) :inherit 'outline-6)
   ((org-level-7 &override) :inherit 'outline-7)
   ((org-level-8 &override) :inherit 'outline-8)
   (org-document-title :foreground yellow :weight 'bold)
   (org-list-dt :foreground "#ffffff" :weight 'bold)
   (org-agenda-date :foreground cyan)
   (org-agenda-dimmed-todo-face :foreground comments)
   (org-agenda-done :foreground base4)
   (org-agenda-structure :foreground violet)
   ((org-block &override) :background base0 :foreground fg)
   ((org-block-begin-line &override) :background base1 :foreground base5)
   ((org-code &override) :foreground yellow)
   (org-column :background base1)
   (org-date :foreground cyan)
   (org-done :foreground green :background base2 :weight 'bold)
   ((org-link &override) :foreground cyan :underline t)
   (org-priority :foreground red)
   ((org-table &override) :foreground teal :background base0)
   ((org-todo &override) :foreground red :weight 'bold)
   (org-warning :foreground magenta))

  ;;;; Base theme variable overrides
  ()
  )

;;; doom-organic-chemistry-tutor-theme.el ends here
