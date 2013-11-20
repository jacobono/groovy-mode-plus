;;; groovy-mode-plus.el --- Groovy and groovy-mode Emacs enhancements

;; This is free and unencumbered software released into the public domain.

;;; Install:

;; Put this file somewhere on your load path (like in .emacs.d), and
;; require it. That's it!

;;    (require 'groovy-mode-plus)

;; Enhancements to java-mode:

;; * `insert-groovy-import' - If you have java-docs set up, you can
;;     access the quick import insertion function.
;;
;;     * C-c C-g i - quickly select an import to insert

;;; Code:

(require 'java-mode-plus)

(defvar groovy-mode-plus-map (make-sparse-keymap)
  "Keymap for the java-mode-plus minor mode.")

;;;###autoload
(define-minor-mode groovy-mode-plus
  "Extensions to groovy-mode for further support with standard Groovy tools."
  :lighter " gm+"
  :keymap 'groovy-mode-plus-map)

(defvar groovy-root-convention '("src/main/groovy" "src/test/groovy")
  "List of directories that tend to be at the root of packages.") 

;;;###autoload
(defun groovy-package ()
  "Returns a guess of the package of the current Groovy source
file, based on the absolute filename. Package roots are matched
against `java-root-convention'."
  (java-mode-plus-search-for-root-convention groovy-root-convention 
			      (file-name-directory buffer-file-name)))

;;;###autoload
(defun groovy-class-name ()
  "Determine the class name from the filename."
  (file-name-sans-extension (file-name-nondirectory buffer-file-name)))

;;;###autoload
(defun groovy-spock-test-name()
  "Determine the spock test name from the filename."
  (concat groovy-class-name "Spec"))

;; Add the very handy binding from java-docs
(define-key java-mode-plus-map (kbd "C-c C-g i") 'add-groovy-import)

;; Enable the minor mode wherever groovy-mode is used.
;;;###autoload
(add-hook 'groovy-mode-hook 'groovy-mode-plus)

(provide 'groovy-mode-plus)

;; groovy-mode-plus.el ends here
