;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ActionScript 3 Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; A helper function from: http://mihai.bazon.net/projects/emacs-javascript-mode/javascript.el
;; Originally named js-lineup-arglist, renamed to as-lineup-arglist
(defun as-lineup-arglist (langelem)
  ;; the "DWIM" in c-mode doesn't Do What I Mean in JS.
  ;; see doc of c-lineup-arglist for why I redefined this
  (save-excursion
    (let ((indent-pos (point)))
      ;; Normal case.  Indent to the token after the arglist open paren.
      (goto-char (c-langelem-2nd-pos c-syntactic-element))
      (if (and c-special-brace-lists
               (c-looking-at-special-brace-list))
          ;; Skip a special brace list opener like "({".
          (progn (c-forward-token-2)
                 (forward-char))
        (forward-char))
      (let ((arglist-content-start (point)))
        (c-forward-syntactic-ws)
        (when (< (point) indent-pos)
          (goto-char arglist-content-start)
          (skip-chars-forward " \t"))
        (vector (current-column))))))


;; Load & associate the the mode with .as files
;;(require 'ecmascript-mode)
;;(add-to-list 'auto-mode-alist '("\\.as$" . ecmascript-mode))

(require 'actionscript-mode)
(add-to-list 'auto-mode-alist '("\\.as[123]{0,1}$" . actionscript-mode))

;; My customizations to the mode.
(defun my-as3-mode-hook ()
  (setq c-basic-offset 2) ; I like 2 spaces instead of 4 or 8
  ;;
  ;; This is the indentation magic from:
  ;; http://mihai.bazon.net/projects/emacs-javascript-mode/javascript.el
  ;;
  (c-set-offset 'arglist-close '(c-lineup-close-paren))
  (c-set-offset 'arglist-cont 0)
  (c-set-offset 'arglist-cont-nonempty '(as-lineup-arglist))
  (c-set-offset 'arglist-intro '+))

;; Associate my customization function with the mode's hook
;;(add-hook 'ecmascript-mode-hook 'my-as3-mode-hook)
(add-hook 'actionscript-mode-hook 'my-as3-mode-hook)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://blog.pettomato.com/?p=22

(defun as-insert-trace ()
  "Insert an empty trace call at point. If we are over a word, then trace that word on the next line"
  (interactive)
  (let ((trace-cmd "trace")
        (cw (current-word)))
    (cond
     ((string= cw nil)
      ;; point is not over a word.
      (indent-according-to-mode)
      (insert (format "%s(\"\");" trace-cmd))
      (backward-char 3))
     (t
      ;; point is over a word.
      (end-of-line)
      (insert (format "\n%s(\"%s: \" + %s);" trace-cmd cw cw))
      (indent-according-to-mode)))))


(define-key actionscript-mode-map "\C-c\C-t" 'as-insert-trace)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'bl-as3)