;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; YAS MODE
;; http://www.emacswiki.org/emacs/Yasnippet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; http://www.emacswiki.org/emacs/yasnippet-config.el

(require 'yasnippet) ;; not yasnippet-bundle

;; (defun yas/setup (package-directory)
;;   ;; Ensure to end with /
;;   (setq package-directory (file-name-as-directory package-directory))
;;   (add-to-list 'load-path package-directory)
;;   (yas/initialize)
;;   (yas/load-directory (concat package-directory "snippets")))


;; (setq yas/prompt-functions
;;       '(yas/x-prompt yas/ido-prompt))

(add-to-list 'load-path
             "~/.emacs.d/vendor/yasnippet-0.6.1c/")

(yas/initialize)
(yas/load-directory "~/.emacs.d/vendor/yasnippet-0.6.1c/snippets/")

;;  make it global
(yas/global-mode 1) 



(provide 'bl-yas)