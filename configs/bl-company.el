;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Company Mode
;; http://www.emacswiki.org/emacs/CompanyMode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/vendor/company/")

(require 'company)

;; Only compleate when I wrote something
(setq company-begin-commands '(self-insert-command))


(setq company-minimum-prefix-length 1 )
(setq company-idle-delay 5)


(defun tab-indent-or-complete ()
  (interactive)
  (defun check-expansion ()
    (save-excursion
      (if (looking-at "\\_>") t
        (progn (backward-char 1)
               (if (looking-at "\\.") t
                 (progn (backward-char 1)
                        (if (looking-at "->") t nil)))))))
  (defun do-yas-expand ()  
    (let ((yas/fallback-behavior 'return-nil))
      (yas/expand)))
  (if (minibufferp)
      (minibuffer-complete)
    (if (or (not yas/minor-mode)
            (null (do-yas-expand)))
        (if (check-expansion)
            (company-complete-common)
          (indent-for-tab-command)))))
(global-set-key [tab] 'tab-indent-or-complete)


;; Use ispell as backend when working in text mode
(add-hook 'text-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends) '(company-dabbrev company-ispell)
                 )))


;; Enable always
;(global-company-mode 1)
(add-hook 'python-mode-hook 'company-mode)
(add-hook 'c-mode-common-hook 'company-mode)
(add-hook 'emacs-lisp-mode-hook 'company-mode)
(add-hook 'lisp-mode-hook 'company-mode)
(add-hook 'dired-mode-hook 'company-mode)


(provide 'bl-company)