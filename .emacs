(modify-frame-parameters nil '((wait-for-wm . nil)))
;(speedbar-frame-mode)

;(add-hook 'write-file-functions 'delete-trailing-whitespace)

(mouse-wheel-mode t)
(setq scroll-step 1)
(setq scroll-conservatively 50)
(setq scroll-preserve-screen-position nil)

(setq-default tab-width 4)
(setq tab-width 4)
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)

(set-default-font "6x13")

(setq default-frame-alist
	'(
	(width . 80) (height . 61)
     ))

(setq exec-path (append exec-path (list "~/bin" )))

;;disable splash screen and startup message
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

(autoload 'actionscript-mode "actionscript-mode" "Enter actionscript mode." t)
(setq auto-mode-alist (cons '("\\.as\\'" . actionscript-mode) auto-mode-alist))

(autoload 'matlab-mode "matlab" "Enter MATLAB mode." t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell "matlab" "Interactive MATLAB mode." t)

(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby." t)
(setq auto-mode-alist (cons '("\\.rb\\'" . ruby-mode) auto-mode-alist))

(setq load-path (cons (expand-file-name "~/emacs_stuff") load-path))

(autoload 'css-mode "css-mode" "Mode for editing CSS files" t)

(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
(autoload 'javascript-mode "javascript" nil t)

(setq auto-mode-alist
      (append '(("\\.css$" . css-mode))
              auto-mode-alist))



(let ((path "~/emacs_stuff/scala_mode"))
  (setq load-path (cons path load-path))
  (load "scala-mode-auto.el"))


(autoload 'scala-mode "scala-mode" "Major mode for editing scala." t)
(setq auto-mode-alist (cons '("\\.scala\\'" . scala-mode) auto-mode-alist))

(setq auto-mode-alist (cons '("\\.erb\\'" . html-mode) auto-mode-alist))

(autoload 'doc-view "doc-view" "Major mode for viewing pdf." t)
(autoload 'doc-view-mode "doc-view-mode" "Major mode for viewing pdf." t)
(setq auto-mode-alist (cons '("\\.pdf\\'" . doc-view) auto-mode-alist))

(require 'show-wspace) ; Load this library.

(require 'haml-mode)

(setq auto-mode-alist
      (cons '("\\.ml[iylp]?$" . tuareg-mode) auto-mode-alist))
(autoload 'caml-mode "caml" "Major mode for editing Caml code." t)
(autoload 'run-caml "inf-caml" "Run an inferior Caml process." t)

;(defun font-courier-14 ()
;	(interactive)
;	(set-default-font "-adobe-courier-medium-r-normal--14-100-100-100-m-90-iso10646-1"))
;(defun font-default () (interactive) (font-courier-14))
;(font-default)

(add-hook 'font-lock-mode-hook 'show-ws-highlight-tabs)
(add-hook 'font-lock-mode-hook 'show-ws-highlight-trailing-whitespace)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(c-basic-offset 2)
 '(c-default-style (quote ((c-mode . "bsd") (java-mode . "java") (other . "gnu"))))
 '(case-fold-search t)
 '(current-language-environment "UTF-8")
 '(default-input-method "rfc1345")
 '(global-font-lock-mode t nil (font-lock))
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(transient-mark-mode t))
 '(mouse-wheel-mode 1)
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


;; Load the ensime lisp code...
(add-to-list 'load-path "~/emacs_stuff/ensime/elisp/")
(require 'ensime)

;; This step causes the ensime-mode to be started whenever
;; scala-mode is started for a buffer. You may have to customize this step
;; if you're not using the standard scala mode.
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; MINI HOWTO:
;; Open .scala file. M-x ensime (once per project)


(put 'upcase-region 'disabled nil)

(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

(defun coffee-custom ()
  "coffee-mode-hook"
 (set (make-local-variable 'tab-width) 2))

(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))

(require 'ido)
(ido-mode t)

(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.ejs$" . html-mode))