;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Performance - GC buffer Before Everything
(setq gc-cons-threshold #x40000000)
(setq read-process-output-max (* 1024 1024 4)) ;; 4mb

;;  Quickier filename handling, resetted after load
(defvar default-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

;;  The basic fundamental mode for begin with
(setq initial-major-mode 'fundamental-mode)

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
(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 12))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'mocha)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

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

(setq truncate-string-ellipsis "…"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
      undo-limit 80000000)                         ; Raise undo-limit to 80Mb

;; which key
(setq which-key-idle-delay 0.3)

;; we recommend using use-package to organize your init.el
(use-package codeium
  ;; if you use straight
  ;; :straight '(:type git :host github :repo "Exafunction/codeium.el")
  ;; otherwise, make sure that the codeium.el file is on load-path

  :init
  ;; use globally
  (add-to-list 'completion-at-point-functions #'codeium-completion-at-point)
  ;; or on a hook
  ;; (add-hook 'python-mode-hook
  ;;     (lambda ()
  ;;         (setq-local completion-at-point-functions '(codeium-completion-at-point))))

  ;; if you want multiple completion backends, use cape (https://github.com/minad/cape):
  ;; (add-hook 'python-mode-hook
  ;;     (lambda ()
  ;;         (setq-local completion-at-point-functions
  ;;             (list (cape-super-capf #'codeium-completion-at-point #'lsp-completion-at-point)))))
  ;; an async company-backend is coming soon!

  ;; codeium-completion-at-point is autoloaded, but you can
  ;; optionally set a timer, which might speed up things as the
  ;; codeium local language server takes ~0.2s to start up
  ;; (add-hook 'emacs-startup-hook
  ;;  (lambda () (run-with-timer 0.1 nil #'codeium-init)))

  ;; :defer t ;; lazy loading, if you want
  :config
  (setq use-dialog-box nil) ;; do not use popup boxes

  ;; if you don't want to use customize to save the api-key
  ;; (setq codeium/metadata/api_key "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx")

  ;; get codeium status in the modeline
  (setq codeium-mode-line-enable
        (lambda (api) (not (memq api '(CancelRequest Heartbeat AcceptCompletion)))))
  (add-to-list 'mode-line-format '(:eval (car-safe codeium-mode-line)) t)
  ;; alternatively for a more extensive mode-line
  ;; (add-to-list 'mode-line-format '(-50 "" codeium-mode-line) t)

  ;; use M-x codeium-diagnose to see apis/fields that would be sent to the local language server
  (setq codeium-api-enabled
        (lambda (api)
          (memq api '(GetCompletions Heartbeat CancelRequest GetAuthToken RegisterUser auth-redirect AcceptCompletion))))
  ;; you can also set a config for a single buffer like this:
  ;; (add-hook 'python-mode-hook
  ;;     (lambda ()
  ;;         (setq-local codeium/editor_options/tab_size 4)))

  ;; You can overwrite all the codeium configs!
  ;; for example, we recommend limiting the string sent to codeium for better performance
  (defun my-codeium/document/text ()
    (buffer-substring-no-properties (max (- (point) 3000) (point-min)) (min (+ (point) 1000) (point-max))))
  ;; if you change the text, you should also change the cursor_offset
  ;; warning: this is measured by UTF-8 encoded bytes
  (defun my-codeium/document/cursor_offset ()
    (codeium-utf8-byte-length
     (buffer-substring-no-properties (max (- (point) 3000) (point-min)) (point))))
  (setq codeium/document/text 'my-codeium/document/text)
  (setq codeium/document/cursor_offset 'my-codeium/document/cursor_offset))

;; company completion
(after! company
  :defer 0.1
  :config
  (global-company-mode t)
  (setq company-idle-delay 0.05
        company-require-match nil
        company-minimum-prefix-length 0

        company-frontends '(company-preview-frontend)
        company-frontends '(company-pseudo-tooltip-frontend company-preview-frontend)
        ;; +lsp-company-backends '(company-tabnine :separate company-yasnippet)
        ;; +lsp-company-backends '(company-tabnine :separate company-capf company-yasnippet)
        ;; company-show-quick-access t
        )

  (map! "C-y" #'+company/complete))

(add-to-list 'company-backends 'company-c-headers)
;; (add-to-list 'company-c-headers-path-system "/usr/include/c++/13.2.1/")
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(setq-default history-length 1000)
(setq-default prescient-history-length 1000)
(setq lsp-log-io nil) ; if set to true can cause a performance hit

;;treesitter
(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; GDScript
(setq treesit-extra-load-path '("~/tree-sitter-gdscript/src/"))
(setq gdscript-use-tab-indents t) ;; If true, use tabs for indents. Default: t
(setq gdscript-indent-offset 4) ;; Controls the width of tab-based indents
(setq gdscript-godot-executable "/usr/bin/godot") ;; Use this executable instead of 'godot' to open the Godot editor.
(setq gdscript-gdformat-save-and-format t) ;; Save all buffers and format them with gdformat anytime Godot executable is run.

;; ;; C#
;; (use-package csharp-mode
;;   :ensure t
;;   :config
;;   (add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-ts-mode)))

;; lsp performance
(setq lsp-use-plists "true")
(setq lsp-idle-delay 0.500)

(after! lsp-mode
  :defer t
  :config
  (setq lsp-clangd-binary-path "/usr/bin/clangd")
  (setq lsp-modeline-code-actions-enable t
        lsp-headerline-breadcrumb-enable t
        +format-with-lsp t
        lsp-lens-enable t))

;; C++
(after! lsp-clangd
  (setq lsp-clients-clangd-args
        '("-j=4"
          "--background-index"
          "--clang-tidy"
          "--completion-style=detailed"
          "--header-insertion=iwyU"
          "--enable-config"
          "--all-scopes-completion=true"
          "--pch-storage=memory"
          "--log=verbose"
          "--header-insertion-decorators"))
  (set-lsp-priority! 'clangd 2))

;; dap
(use-package! dap-mode)

(map! :map dap-mode-map
      :leader
      :prefix ("d" . "dap")
      ;; basics
      :desc "dap next"          "n" #'dap-next
      :desc "dap step in"       "i" #'dap-step-in
      :desc "dap step out"      "o" #'dap-step-out
      :desc "dap continue"      "c" #'dap-continue
      :desc "dap hydra"         "h" #'dap-hydra
      :desc "dap debug restart" "r" #'dap-debug-restart
      :desc "dap debug"         "s" #'dap-debug

      ;; debug
      :prefix ("dd" . "Debug")
      :desc "dap debug recent"  "r" #'dap-debug-recent
      :desc "dap debug last"    "l" #'dap-debug-last

      ;; eval
      :prefix ("de" . "Eval")
      :desc "eval"                "e" #'dap-eval
      :desc "eval region"         "r" #'dap-eval-region
      :desc "eval thing at point" "s" #'dap-eval-thing-at-point
      :desc "add expression"      "a" #'dap-ui-expressions-add
      :desc "remove expression"   "d" #'dap-ui-expressions-remove

      :prefix ("db" . "Breakpoint")
      :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
      :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
      :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
      :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message)

(use-package! cmake-ide
  :config
  (setq! cmake-ide-project-dir default-directory)
  (setq! cmake-ide-build-dir (concat default-directory "_build"))
  ;;(setq! cmake-ide-build-pool-dir (concat default-directory "_build"))
  ;;(setq! cmake-ide-cmake-args "-DCMAKE_BUILD_TYPE=Debug")
  (cmake-ide-setup))

'(+markdown-compile-pandoc)

(beacon-mode 1)

(use-package all-the-icons
  :if (display-graphic-p))

(use-package all-the-icons-completion
  :ensure t
  :defer
  :hook (marginalia-mode-hook . #'all-the-icons-completion-marginalia-setup)
  :init
  (all-the-icons-completion-mode))

;;undotree
(after! undo-tree
  (setq undo-tree-auto-save-history t)
  (map! :leader "su" #'undo-tree-visualize))

;; treemacs
(after! treemacs
  (setq treemacs-position 'left
        treemacs-git-mode 'deferred))

;; yasnippets
(setq yas-snippet-dirs '("~/dotfiles/.doom.d/snippets"))

(setq ispell-program-name "aspell"
      ispell-dictionary "english")


(global-unset-key (kbd "C-n"))
(global-unset-key (kbd "C-N"))

(global-set-key (kbd "C-n") 'mc/mark-next-word-like-this)
(global-set-key (kbd "C-N") 'mc/mark-previous-word-like-this)
(global-set-key (kbd "C-u") 'mc/unmark-next-like-this)
(global-set-key (kbd "C-U") 'mc/unmark-previous-like-this)
(global-set-key (kbd "C->") 'mc/skip-to-next-like-this)
(global-set-key (kbd "C-<") 'mc/skip-to-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(global-unset-key (kbd "M-k"))
(global-unset-key (kbd "M-j"))
(global-unset-key (kbd "M-h"))
(global-unset-key (kbd "M-l"))
(global-unset-key (kbd "M-<up>"))
(global-unset-key (kbd "M-<down>"))
(global-unset-key (kbd "M-<left>"))
(global-unset-key (kbd "M-<right>"))

(global-set-key (kbd "M-k") 'drag-stuff-up)
(global-set-key (kbd "M-j") 'drag-stuff-down)
(global-set-key (kbd "M-h") 'drag-stuff-left)
(global-set-key (kbd "M-l") 'drag-stuff-right)

(global-set-key (kbd "S-k") 'drag-stuff-up)
(global-set-key (kbd "S-j") 'drag-stuff-down)
(global-set-key (kbd "S-h") 'drag-stuff-left)
(global-set-key (kbd "S-l") 'drag-stuff-right)
