;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DOC MODE
;; http://www.emacswiki.org/emacs/DocMode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'doc-mode)

;; Add the hook to the needed modes
(add-hook 'c-mode-common-hook 'doc-mode)




(provide 'bl-doc)