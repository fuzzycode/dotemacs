;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; VISUAL CHANGES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Make zenburn default color-theme
(require 'zenburn)
(color-theme-zenburn)

;; remove toolbar
(tool-bar-mode -1)

;;;Remove menu bar
(menu-bar-mode -1)

;;; Remove scroll bar
(toggle-scroll-bar -1)

;;; Display line numbers
(setq line-number-mode t)

;;; Display column number
(setq column-number-mode t)

;;; Display file size
(size-indication-mode t)

;; stop cursor from blinking
(blink-cursor-mode nil) 

;; mark current line:
(global-hl-line-mode t)

;;disable splash screen and startup message
(setq inhibit-startup-message t)
(setq initial-scratch-message ";;Yay!\n;;Happy hacking!")

;; Show matching delimiters
(show-paren-mode t)

(provide 'bl-visuals)