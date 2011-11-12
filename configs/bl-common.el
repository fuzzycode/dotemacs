;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COMMON SETTINGS
;;
;; Used for global configurations affecting all modes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Backups
(setq make-backup-files t 
      backup-by-copying t 
      backup-directory-alist '(("." . "~/.emacs.d/cache/backups")) 
      version-control t
      kept-new-versions 2
      kept-old-versions 5
      delete-old-versions t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Smooth scrolling
(require 'smooth-scrolling)

;; to answer y or n instead of yes or no
(defalias 'yes-or-no-p 'y-or-n-p)

;; Make <CR> yes
(define-key query-replace-map [return] 'act)
(define-key query-replace-map [?\C-m] 'act)


;; Only use space for indent
(setq-default indent-tabs-mode nil)

;; Set tab size
(setq tab-width 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global key bindings
(define-key global-map (kbd "RET") 'newline-and-indent)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CUA Mode
;; http://www.emacswiki.org/emacs/CuaMode
(setq cua-enable-cua-keys nil)           ;; don't add C-x,C-c,C-v etc...
(cua-mode t) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Make buffer names unique
(require 'uniquify) 
(setq 
 uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Autopair
;; http://www.emacswiki.org/emacs/AutoPairs
;; http://code.google.com/p/autopair/

(require 'autopair)
(autopair-global-mode t) ;; enable autopair in all buffers 
(setq autopair-autowrap t)

(add-hook 'c++-mode-hook
	  #'(lambda ()
	       (push ?{
                      (getf autopair-dont-pair :comment))))

;; Python doc string compleation
(add-hook 'python-mode-hook
          #'(lambda ()
              (setq autopair-handle-action-fns
                    (list #'autopair-default-handle-action
                          #'autopair-python-triple-quote-action))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Change cursor color according to mode; inspired by
;; http://www.emacswiki.org/emacs/ChangingCursorDynamically
;; http://www.djcbsoftware.nl/dot-emacs.html
;; valid values are t, nil, box, hollow, bar, (bar . WIDTH), hbar,
;; (hbar. HEIGHT); see the docs for set-cursor-type

(setq bl-read-only-color       "gray")
(setq bl-read-only-cursor-type 'hbar)

(setq bl-overwrite-color       "red")
(setq bl-overwrite-cursor-type 'bar)

(setq bl-normal-color          "yellow")
(setq bl-normal-cursor-type    'box)

(defun bl-set-cursor-according-to-mode ()
  "change cursor color and type according to the minor mode of the buffer."
  (cond
   (buffer-read-only
     (set-cursor-color bl-read-only-color)
      (setq cursor-type bl-read-only-cursor-type))
    (overwrite-mode
     (set-cursor-color bl-overwrite-color)
      (setq cursor-type bl-overwrite-cursor-type))
    (t 
     (set-cursor-color bl-normal-color)
      (setq cursor-type bl-normal-cursor-type))))

(add-hook 'post-command-hook 'bl-set-cursor-according-to-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Copy and kill a line without having to mark it first
;;http://emacs-fu.blogspot.com/search/label/new?updated-max=2009-11-29T14%3A52%3A00%2B02%3A00&max-results=20
(defadvice kill-ring-save (before slick-copy activate compile) "When called
  interactively with no active region, copy a single line instead."
  (interactive (if mark-active (list (region-beginning) (region-end)) (message 
                                                                       "Copied line") (list (line-beginning-position) (line-beginning-position
                                                                                                                       2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Smart Home key
;; http://stackoverflow.com/questions/145291/smart-home-in-emacs
(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive)
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))

(global-set-key [home] 'smart-beginning-of-line)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Diminish, for making the status-line more clean
;; http://www.eskimo.com/~seldon/diminish.el

;; Minor modes
(when (require 'diminish nil 'noerror)
  (eval-after-load "company"
      '(diminish 'company-mode "Cmp"))
  (eval-after-load "abbrev"
    '(diminish 'abbrev-mode "Ab"))
  (eval-after-load "yasnippet"
    '(diminish 'yas/minor-mode "Ys")))

;; Major modes
(add-hook 'emacs-lisp-mode-hook 
          (lambda()
    (setq mode-name "el"))) 

(add-hook 'python-mode-hook
          (lambda()
            (setq mode-name "py")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; iBuffer
;; http://www.emacswiki.org/emacs/IbufferMode
;; http://emacs-fu.blogspot.com/2010/02/dealing-with-many-buffers-ibuffer.html

(require 'ibuffer) 

(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("dired" (mode . dired-mode))
               ;("perl" (mode . cperl-mode))
               ("PHP" (or
                       (name . "\\.php$")
                       (name . "\\.inc$")))
               ("Flex" (or
                        (name . "\\.as[123]?$")
                        (name . "\\.mxml$")))
               ("python" (or
                          (mode . python-mode)
                          (name . "^\\*Pymacs\\*$")
                          (name . "^\\*Python*\\*$")))
               ("lisp" (or
                        (mode . lisp-mode)
                        (name . "\\.el$")))
               ;("erc" (mode . erc-mode))
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")
                         (name . "^\\*Completions\\*$")
                         (name . "^\\*Help\\*$")
                         (name . "^\\*shell\*$")))
               ))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

;; Replaces the default buffer menu command
(global-set-key (kbd "C-x C-b") 'ibuffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Bookmarks
;; http://emacs-fu.blogspot.com/2009/11/bookmarks.html

(setq 
 bookmark-default-file "~/.emacs.d/bookmarks"
 bookmark-save-flag 1)                        ;; autosave each change)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SavePlace
;; http://emacs-fu.blogspot.com/2009/05/remembering-your-position-in-file.html
;; http://www.emacswiki.org/emacs/SavePlace

(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)                   ;; activate it for all buffers
(require 'saveplace)                          ;; get the package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dot Mode, for repeating the last command
;; http://www.emacswiki.org/emacs/dot-mode.el
(when (require 'dot-mode nil 'noerror)
  (dot-mode t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HideShow
;; http://www.emacswiki.org/emacs/HideShow
;; http://emacs-fu.blogspot.com/2008/12/showing-and-hiding-blocks-of-code.html

(defun my-hide-show-hook ()
  (local-set-key (kbd "C-c <right>") 'hs-show-block)
  (local-set-key (kbd "C-c <left>")  'hs-hide-block)
  (local-set-key (kbd "C-c <up>")    'hs-hide-all)
  (local-set-key (kbd "C-c <down>")  'hs-show-all)
  (hs-minor-mode t))

(add-hook 'c-mode-common-hook 'my-hide-show-hook)
(add-hook 'lisp-mode-hook 'my-hide-show-hook)
(add-hook 'python-mode-hook 'my-hide-show-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mode Bindings
(add-to-list 'auto-mode-alist '("\\.[bB]uild$" . nxml-mode ) ) ;; Build files are XML files

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tramp
;;
;; Plink is puttylink for scp/ssh connections on windows
;(setq tramp-default-method "plink")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keyboard commands
(global-set-key (kbd "C-x r e") 'eval-region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Command Aliases

(defalias 'lml 'list-matching-lines)
(defalias 'dml 'delete-matching-lines)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'bl-common)

