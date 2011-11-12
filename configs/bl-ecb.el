;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs Code Browser (ECB)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Needs to be added explicitly
(add-to-list 'load-path
             "~/.emacs.d/vendor/ecb-snap/")

(require 'ecb-autoloads)
;; startup message is annoying
(setq ecb-tip-of-the-day nil)


;; My hook to set up ecb modes
(defun my-ecb-hook ()
  ;(ecb-activate)
)

;; Add the hook to the needed modes
(add-hook 'c-mode-common-hook 'my-ecb-hook)
(add-hook 'lisp-mode-hook 'my-ecb-hook)
(add-hook 'scheme-mode-hook 'my-ecb-hook)
(add-hook 'emacs-lisp-mode-hook 'my-ecb-hook)
(add-hook 'erlang-mode-hook 'my-ecb-hook)
(add-hook 'python-mode-hook 'my-ecb-hook)


;(ecb-layout-define "my-prog-layout" right nil
     ;; The frame is already splitted side-by-side and point stays in the
     ;; left window (= the ECB-tree-window-column)
   
     ;; Here is the creation code for the new layout
   
     ;; 1. Defining the current window/buffer as ECB-methods buffer
 ;    (ecb-set-methods-buffer)
     ;; 2. Splitting the ECB-tree-windows-column in two windows
     ;;(ecb-split-ver 0.75 t)
     ;; 3. Go to the second window
     ;;(other-window 1)
     ;; 4. Defining the current window/buffer as ECB-history buffer
     ;;(ecb-set-history-buffer)
     ;; 5. Make the ECB-edit-window current (see Postcondition above)
;     (select-window (next-window)))





(provide 'bl-ecb)