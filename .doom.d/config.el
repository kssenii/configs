;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys

;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.

;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how they are implemented.


(setq user-full-name "kssenii")


;;                                              =======    Appearance   ╰( ͡° ͜ʖ ͡° )つ──☆*:

(setq doom-theme 'doom-one)
(display-time-mode 1)

(setq
    display-time-day-and-date t
    display-line-numbers-type t
)


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

(xterm-mouse-mode 1)

(setq-default
    redisplay-dont-pause t
    scroll-step 1
    scroll-margin 1
    scroll-conservatively 10000
    scroll-preserve-screen-position 1
    mouse-wheel-mode t
    mouse-wheel-progressive-speed nil
    mouse-wheel-follow-mouse t
    mouse-wheel-scroll-amount '(1 ((shift) . 1))
)

(global-set-key (kbd "<mouse-4>") 'scroll-down-command)
(global-set-key (kbd "<mouse-5>") 'scroll-up-command)

;;(require 'smooth-scrolling)
;;(smooth-scrolling-mode 1)

(define-key global-map (kbd "C-k") 'windmove-up)
(define-key global-map (kbd "C-j") 'windmove-down)
(define-key global-map (kbd "C-h") 'windmove-left)
(define-key global-map (kbd "C-l") 'windmove-right)


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

