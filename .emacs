;; General
(setq load-path (cons (expand-file-name "~/emacs_stuff") load-path))
;; (global-auto-revert-mode t)
;;(add-hook 'find-file-hook 'subword-mode)

(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(menu-bar-mode 0)

(transient-mark-mode t)

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

(global-set-key (kbd "C-M-[")  'windmove-left)
(global-set-key (kbd "C-M-]")  'windmove-right)
(setq windmove-wrap-around t)

;; Whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(require 'show-wspace)
(add-hook 'font-lock-mode-hook 'show-ws-highlight-tabs)
(add-hook 'font-lock-mode-hook 'show-ws-highlight-trailing-whitespace)

;; Indentation
(setq-default tab-width 2)
(setq tab-width 2)
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)

(add-to-list 'load-path "~/emacs_stuff/go-mode")
(require 'go-mode)

;; Scala
(add-to-list 'load-path "~/emacs_stuff/scala-mode")
(require 'scala-mode-auto)

(add-to-list 'auto-mode-alist '("\\.sbt$" . scala-mode))

;; ido
(require 'ido)
(ido-mode t)
(setq
 ido-case-fold  t
 ido-ignore-buffers '()
 ido-use-filename-at-point nil
 ido-use-url-at-point nil
 ido-enable-flex-matching nil
)

(setq confirm-nonexistent-file-or-buffer nil)

;; FFIP
(require 'find-file-in-project)
(global-set-key (kbd "C-x p") 'find-file-in-project)

;; Coffeescript
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))

;; Less
(require 'less-mode)
(add-to-list 'auto-mode-alist '("\\.less$" . less-mode))
(setq css-indent-offset 2)
(setq less-compile-at-save nil)

;; Yasnippet
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet/yasnippet")
(require 'yasnippet)

(setq yas/snippet-dirs '("~/snippets"))
(yas/global-mode 1)
;;(yas/initialize)
;;(yas/load-directory "~/.emacs.d/snippets")

;; JST
(add-to-list 'auto-mode-alist '("\\.jst$" . nxml-mode))

;; pants BUILD
(add-to-list 'auto-mode-alist '("BUILD$" . python-mode))

;; Colors
(custom-set-faces
 '(minibuffer-prompt ((t (:foreground "#ffffff"))))
)


(global-set-key (kbd "C-x TAB") 'indent-rigidly)


;; Javascript
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq js-indent-level 2)
(setq c-basic-offset 2)

;; Dart
(require 'dart-mode)
(add-to-list 'auto-mode-alist '("\\.dart$" . dart-mode))

;; Clojure
(require 'clojure-mode)
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

;; Avro
(add-to-list 'auto-mode-alist '("\\.avdl$" . c-mode))

;; http://amitp.blogspot.com/2007/03/emacs-move-autosave-and-backup-files.html
(defvar user-temporary-file-directory
  (concat temporary-file-directory user-login-name "/"))
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist
      `(("." . ,user-temporary-file-directory)
        (,tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
      (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
      `((".*" ,user-temporary-file-directory t)))


(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby." t)
(setq auto-mode-alist (cons '("\\.rb\\'" . ruby-mode) auto-mode-alist))


(global-set-key (kbd "C-x e") 'delete-region)


;;(setq yas/root-directory "~/emacs.d/snippets")
;;(yas/load-directory "~/.emacs.d/snippets")

;;(setq yas/snippet-dirs "~/.emacs.d/snippets" )

;;(yas/global-mode 1)



;;(setq yas/snippet-dirs "~/.emacs.d/snippets" )
;; (yas/reload-all)



;;(modify-frame-parameters nil '((wait-for-wm . nil)))

;; (mouse-wheel-mode t)
;; (setq scroll-step 1)
;; (setq scroll-conservatively 50)
;; (setq scroll-preserve-screen-position nil)

;; (set-default-font "6x13")

;; (setq default-frame-alist
;;   '(
;;   (width . 80) (height . 61)
;;   ))


;; (setq column-number-mode t)

;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(c-basic-offset 2)
;;  '(c-default-style (quote ((c-mode . "bsd") (java-mode . "java") (other . "gnu"))))
;;  '(case-fold-search t)
;;  '(current-language-environment "UTF-8")
;;  '(default-input-method "rfc1345")
;;  '(global-font-lock-mode t nil (font-lock))
;;  '(scroll-bar-mode (quote right))
;;  '(show-paren-mode t)
;;  '(tool-bar-mode nil)
;;  '(transient-mark-mode t))
;;  '(mouse-wheel-mode 1)
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  )


;; (setq exec-path (append exec-path (list "~/bin")))

;; ;;disable splash screen and startup message
;; (setq inhibit-startup-message t)
;; (setq initial-scratch-message nil)

;; (autoload 'css-mode "css-mode" "Mode for editing CSS files" t)


;; (setq auto-mode-alist
;;       (append '(("\\.css$" . css-mode))
;;               auto-mode-alist))

;; ;;(add-hook 'find-file-hook 'c-subword-mode)
;; (add-hook 'find-file-hook 'subword-mode)


;; ;; (let ((path "~/emacs_stuff/nxml-mode-20041004"))
;; ;;   (setq load-path (cons path load-path))
;; ;;   (load "rng-auto.el"))

;; (add-to-list 'auto-mode-alist '("\\.html$" . nxml-mode))
;; (add-to-list 'auto-mode-alist '("\\.jst$" . nxml-mode))

;; (setq auto-mode-alist (cons '("\\.erb\\'" . nxml-mode) auto-mode-alist))







;; ;; ;; Load the ensime lisp code...
;; ;; ;; (add-to-list 'load-path "~/emacs_stuff/ensime/elisp/")
;; ;; ;; (require 'ensime)

;; ;; ;; This step causes the ensime-mode to be started whenever
;; ;; ;; scala-mode is started for a buffer. You may have to customize this step
;; ;; ;; if you're not using the standard scala mode.
;; ;; ;;(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; ;; ;; MINI HOWTO:
;; ;; ;; Open .scala file. M-x ensime (once per project)


;; ;; ;; (add-hook 'scala-mode-hook
;; ;; ;;          (lambda () (local-set-key (kbd "RET") 'reindent-then-newline-and-indent)))



;; (put 'upcase-region 'disabled nil)



;; (defun coffee-custom ()
;;   "coffee-mode-hook"
;;  (set (make-local-variable 'tab-width) 2))

;; (add-hook 'coffee-mode-hook
;;   '(lambda() (coffee-custom)))


;; (add-to-list 'auto-mode-alist '("\\.ejs$" . nxml-mode))


;; (require 'desktop)
;; (desktop-save-mode 1)
;; (defun my-desktop-save ()
;;   (interactive)
;;   ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
;; ;;  (if (eq (desktop-owner) (emacs-pid))
;; ;;      (desktop-save desktop-dirname)))
;;   (desktop-save desktop-dirname)
;; )

;; (add-hook 'auto-save-hook 'my-desktop-save)

;; ;; Enable mouse support
;; ;; (unless window-system
;; ;;   (require 'mouse)
;; ;;   (xterm-mouse-mode t)
;; ;;   (global-set-key [mouse-4] '(lambda ()
;; ;;                                (interactive)
;; ;;                                (scroll-down 1)))
;; ;;   (global-set-key [mouse-5] '(lambda ()
;; ;;                                (interactive)
;; ;;                                (scroll-up 1)))
;; ;;   (defun track-mouse (e))
;; ;;   (setq mouse-sel-mode t)
;; ;; )

;; ;; (defun copy-from-osx ()
;; ;;   (shell-command-to-string "pbpaste"))

;; ;; (defun paste-to-osx (text &optional push)
;; ;;   (let ((process-connection-type nil))
;; ;;       (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
;; ;;         (process-send-string proc text)
;; ;;         (process-send-eof proc))))

;; ;; (setq interprogram-cut-function 'paste-to-osx)
;; ;; (setq interprogram-paste-function 'copy-from-osx)


;; (require 'midnight)


;; ;; (add-to-list 'load-path "~/emacs_stuff/color-theme")
;; ;; (add-to-list 'load-path "~/emacs_stuff/color-theme/color-theme.el")

;; ;; (add-to-list 'load-path "~/zenburn-emacs")
;; ;; (require 'color-theme)
;; ;; (require 'color-theme-hober2)
;; ;; (color-theme-hober2)
