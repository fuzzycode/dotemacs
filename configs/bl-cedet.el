;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CEDET MODE
;; As of Emacs 23.2 it is a part of emacs. But it needs a lot of tweeking
;; so I give it a seperate config file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set the default submodes for semantic
(setq semantic-default-submodes
      '(global-semanticdb-minor-mode
        global-semantic-idle-scheduler-mode
        global-semantic-idle-summary-mode
        global-semantic-idle-completions-mode
        global-semantic-decoration-mode
        global-semantic-highlight-func-mode
        ;global-semantic-stickyfunc-mode
        ))

(require 'eassist)

;; Turn on semantic and add keyboard commands
(defun my-cedet-hook ()
  (semantic-mode 1)
  (local-set-key "\C-c\C-j" 'semantic-ia-fast-jump)
  (local-set-key "\C-c\C-q" 'semantic-ia-show-doc)
  (local-set-key "\C-c\C-s" 'semantic-ia-show-summary)
  (local-set-key "\C-c\C-e" 'eassist-list-methods)
  (local-set-key "\C-c\C-v" 'semantic-decoration-include-visit)
  (local-set-key "\C-c\C-r" 'semantic-symref)
  (local-set-key "\C-cr" 'semantic-symref-symbol)
  ;;(local-set-key "\C-c\C-b" 'semantic-mrub-switch-tags)
)

;; C/C++ special hook
(defun my-c-mode-cedet-hook ()
    (local-set-key "\C-c\C-p" 'semantic-analyze-proto-impl-toggle)
    (local-set-key (kbd "<C-tab>") 'eassist-switch-h-cpp) 
 )

;; Add the hook to the needed modes
(add-hook 'c-mode-common-hook 'my-cedet-hook)
(add-hook 'lisp-mode-hook 'my-cedet-hook)
(add-hook 'scheme-mode-hook 'my-cedet-hook)
(add-hook 'emacs-lisp-mode-hook 'my-cedet-hook)
(add-hook 'erlang-mode-hook 'my-cedet-hook)
(add-hook 'python-mode-hook 'my-cedet-hook)
(add-hook 'ecmascript-mode-hook 'my-cedet-hook)

(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

(provide 'bl-cedet)