;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; INIT.EL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://www.djcbsoftware.nl/dot-emacs.html
;;
;; Configure load-path

;; add everything under ~/.emacs.d to it
(let* ((my-lisp-dir "~/.emacs.d/")
       (default-directory my-lisp-dir))
  (setq load-path (cons my-lisp-dir load-path))
  (normal-top-level-add-subdirs-to-load-path))

;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load all separately stored config files

(require 'bl-visuals nil 'noerror) ;;Visual enhancements
(require 'bl-common nil 'noerror) ;; Common changes for all modes
(require 'bl-ido nil 'noerror) ;; Interactive do mode
(require 'bl-yas nil 'noerror) ;; Yasnippet mode
(require 'bl-cedet nil 'noerror) ;; CEDET mode, semantic etc.
(require 'bl-ecb nil 'noerror) ;; ECB mode, should load after cedet mode
;(require 'bl-doc nil 'noerror) ;;Documentation mode
(require 'bl-company nil 'noerror) ;; Company mode 
(require 'bl-python nil 'noerror) ;; Python mode
;(require 'bl-as3 nil 'noerror) ;; Actionscrip mode
;(require 'bl-p4 nil 'noerror) ;; Perforce integration
;(require 'bl-doremi nil 'noerror) ;; Doremi mode, for changing frame sizes among other things
(require 'bl-php nil 'noerror) ;;PHP mode

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-layout-name "right1")
 '(ecb-options-version "2.40")
 '(ecb-windows-width 0.2))

;(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 ;'(fringe ((t (:background "black")))))
