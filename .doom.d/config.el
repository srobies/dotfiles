;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Lrobie"
      user-mail-address "sprobie1@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Fantasque Sans Mono" :size 18 :weight 'medium)
      doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(setq ein:output-area-inlined-images t) ;; show images inline. Emacs support for jupyter is kinda half-baked. Best to stay with the browser for now

;; dap debugger settings
(setq dap-auto-configure-features '(sessions locals controls tooltip))
(require 'dap-python)
(require 'dap-cpptools)
;; (require 'dap-cpptools) can't figure out how to make this work

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages

;; enable Babel languages in org-mode
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (C . t)
   (C++ . t)
   (calc . t)
   (latex . t)
   (ledger . t)
   (org . t)
   (python .t)
   (sh .t)))
;; install tree-sitter for better highlighting
(use-package! tree-sitter
  :config(require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
(map! :leader
      :desc "Search using FZF"
      "ff" #'counsel-fzf) ;; Use fzf to search for files. Better than built in
(map! :leader
      :desc "Vertical split" "|" #'split-window-horizontally
      :desc "Horizontal split" "-" #'split-window-vertically) ;; split commands
(map! :leader
      :desc "Undotree toggle" "u" #'undo-tree-visualize)
(map! :leader
      :desc "Neotree" "e" #'treemacs)
;; DAP bindings
(map! :leader
      (:prefix-map ("d" . "DAP debugger")
        :desc "Step over" "j" #'dap-next
        :desc "Start debuggger" "d" #'dap-debug
        :desc "Edit template" "e" #'dap-debug-edit-template
        :desc "Step in" "l" #'dap-step-in
        :desc "Step out" "h" #'dap-step-out
        :desc "Continue" "c" #'dap-continue
        :desc "Restart" "r" #'dap-restart-frame
       (:prefix ("b" . "breakpoint")
        :desc "Add" "a" #'dap-breakpoint-add
        :desc "Remove" "d" #'dap-breakpoint-delete
        :desc "Toggle" "t" #'dap-breakpoint-toggle
        :desc "Conditional" "c" #'dap-breakpoint-condition)))
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(setq password-cache-expiry nil) ;; cache passwords as long as emacs is open
