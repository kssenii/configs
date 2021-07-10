;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.

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
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


(setq user-full-name "kssenii")


;                                              =======    Appearance   ╰( ͡° ͜ʖ ͡° )つ──☆*:

(setq doom-theme 'doom-gruvbox-light)
(display-time-mode 1)
(setq
    display-time-day-and-date t
    display-line-numbers-type t
)

(add-hook 'c-mode-hook (function (lambda () (font-lock-fontify-buffer))))
(global-font-lock-mode 1)

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; M-x package-install RET rainbow-identifiers RET
(require 'rainbow-identifiers)
(add-hook 'prog-mode-hook 'rainbow-identifiers-mode)

(font-lock-add-keywords
   'c-mode '(("\\<\\(\\sw+\\) ?(" 1 'font-lock-function-name-face)))


;;                                              =======     Settings    ╰( ͡° ͜ʖ ͡° )つ──☆*:

(setq-default
    show-trailing-whitespace t
    tab-width 4
    x-stretch-cursor t
    window-combination-resize t
    whitespace-line-column 140
)

;; automatically update a buffer if a file changes on disk
(global-auto-revert-mode 1)

(setq
    evil-want-fine-undo 'fine
    undo-limit 8000000
    auto-save-default nil
    make-backup-files nil
    inhibit-compacting-font-caches t
    confirm-kill-emacs nil
)

(add-hook 'before-save-hook 'delete-trailing-whitespace)


;;                                              =======     Navigation    ╰( ͡° ͜ʖ ͡° )つ──☆*:

;;(add-to-list 'load-path "./lisp")
(setq lsp-clients-clangd-args '("-j=6"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))
; huge yellow bulb https://emacs-lsp.github.io/lsp-mode/tutorials/how-to-turn-off/
(setq lsp-ui-sideline-enable nil)

(xterm-mouse-mode 1)

(setq-default
    pixel-scroll-mode t
    redisplay-dont-pause t
    ;;scroll-step 1
    scroll-margin 1
    scroll-conservatively 0
    scroll-preserve-screen-position 1
    scroll-up-aggressively 0.001
    scroll-down-aggressively 0.001
    auto-window-vscroll nil
    fast-but-imprecise-scrolling nil
    mouse-wheel-mode t
    mouse-wheel-progressive-speed nil
    mouse-wheel-follow-mouse t
    mouse-wheel-scroll-amount '(1 ((shift) . 1))
)

(global-set-key (kbd "<mouse-4>") 'scroll-down-command)
(global-set-key (kbd "<mouse-5>") 'scroll-up-command)

(define-key global-map (kbd "C-k") 'windmove-up)
(define-key global-map (kbd "C-j") 'windmove-down)
(define-key global-map (kbd "C-h") 'windmove-left)
(define-key global-map (kbd "C-l") 'windmove-right)


(global-set-key (kbd "M-x") 'helm-M-x)
(when (executable-find "ack-grep")
    (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
                  helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))


;;                                              =======   evil aka vim settings ╰( ͡° ͜ʖ ͡° )つ──☆*:

(setq-default
    evil-escape-key-sequence "jj"
    evil-escape-delay 0.4
    ;;evil-escape-excluded-states '(normal visual multiedit emacs motion)
    ;;evil-escape-excluded-major-modes '(neotree-mode treemacs-mode vterm-mode)
)


;;                                              =======   Neotree      ╰( ͡° ͜ʖ ͡° )つ──☆*:

(with-eval-after-load 'evil-maps
  (define-key evil-normal-state-map (kbd "C-n") nil)
)

(define-key global-map (kbd "C-n") 'neotree-toggle)

(map!
    (:after neotree
        :map neotree-mode-map
        :n "k"         #'neotree-previous-line
        :n "j"         #'neotree-next-line
        :n "o"         #'neotree-enter
        :n "v"         #'neotree-enter-vertical-split
        :n "i"         #'neotree-enter-horizontal-split
        :n "q"         #'neotree-hide
        :n "f"         #'neotree-create-node
        :n "h"         #'+neotree/collapse-or-up
        :n "g"         nil
        :n "l"         #'+neotree/expand-or-open
        :n "R"         #'neotree-refresh
        :n "G"         #'evil-goto-line
        :n "gg"        #'evil-goto-first-line
        :n [tab]       #'neotree-quick-look
        :n [backspace] #'evil-window-prev
        :n "J"         #'neotree-select-next-sibling-node
        :n "K"         #'neotree-select-previous-sibling-node
        :n "H"         #'neotree-select-up-node
        :n "L"         #'neotree-select-down-node
    )
)
