;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PYTHON MODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Load pymacs
;; http://www.emacswiki.org/emacs/PyMacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

;; Load Ropemacs
;; http://pypi.python.org/pypi/ropemacs
;; http://rope.sourceforge.net/ropemacs.html
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")

;; Bicycle Repair Man
;; For refactoring code
;(pymacs-load "bikeemacs" "brm-")
;(brm-init)

;(require 'pysmell)

(setq ropemacs-enable-autoimport t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pylookup
;; http://taesoo.org/Opensource/Pylookup
(setq pylookup-dir "~/.emacs.d/vendor/pylookup/")
(add-to-list 'load-path pylookup-dir)
;; load pylookup when compile time
(eval-when-compile (require 'pylookup))

;; set executable file and db file
(setq pylookup-program (concat pylookup-dir "pylookup.py"))
(setq pylookup-db-file (concat pylookup-dir "pylookup.db"))

;; to speedup, just load it on demand
(autoload 'pylookup-lookup "pylookup"
  "Lookup SEARCH-TERM in the Python HTML indexes." t)
(autoload 'pylookup-update "pylookup" 
  "Run pylookup-update and create the database at `pylookup-db-file'." t)

;; TODO: Make platform independent
(setq browse-url-default-browser "firefox.exe")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-unset-key "\C-c\C-d")
(global-unset-key "\C-cd")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;:
;; PDB
;; http://gunnarwrobel.de/wiki/Python.html
(setq pdb-path 'C:/Python26/pdb.bat
      gud-pdb-command-name (symbol-name pdb-path))

;; http://lists.gnu.org/archive/html/help-gnu-emacs/2003-10/msg00577.html
(defadvice pdb (before gud-query-cmdline activate)
  "Provide a better default command line when called interactively."
  (interactive
   (list (gud-query-cmdline pdb-path
			    (file-name-nondirectory buffer-file-name)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; My setup hook for python
(defun my-python-mode-hook ()
  (set-variable 'py-indent-offset 4)
  (set-variable 'indent-tabs-mode nil)
  (define-key python-mode-map (kbd "RET") 'newline-and-indent)
  (local-set-key "\C-c\C-h" 'pylookup-lookup)
  (local-set-key "\C-c\C-d" 'rope-show-doc)
  )

(add-hook 'python-mode-hook 'my-python-mode-hook)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Flymake, pyflakes
;; (when (load "flymake"  t)
;;   (load-library "flymake-cursor")
;;   (defun flymake-pyflakes-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;            (local-file (file-relative-name
;;                         temp-file
;;                         (file-name-directory buffer-file-name))))
;;       (list "pyflakes" (list local-file))))
;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" flymake-pyflakes-init)))
;; (add-hook 'find-file-hook 'flymake-find-file-hook)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'bl-python)