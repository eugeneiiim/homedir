(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(menu-bar-mode 0)
(column-number-mode t)
;(global-linum-mode t)

(require 'ido)
(ido-mode t)
(setq
 ido-case-fold  t
 ido-ignore-buffers '()
 ido-use-filename-at-point nil
 ido-use-url-at-point nil
 ido-enable-flex-matching nil
)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages/") t)
(package-initialize)

(setq load-path (cons (expand-file-name "~/emacs_stuff") load-path))

(load-theme 'lush t)

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq js-indent-level 2)
(setq c-basic-offset 2)
(setq typescript-indent-level 2)

; Ignore trailing commas
;; (setq js2-strict-trailing-comma-warning nil)

(require 'js2-refactor)
(js2r-add-keybindings-with-prefix "C-c C-m")
(add-hook 'js2-mode-hook #'js2-refactor-mode)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(require 'show-wspace)
(add-hook 'font-lock-mode-hook 'show-ws-highlight-tabs)
(add-hook 'font-lock-mode-hook 'show-ws-highlight-trailing-whitespace)
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)

;; (require 'dropdown-list)
;; (setq yas-prompt-functions '(yas-dropdown-prompt
;;                              yas-ido-prompt
;;                              yas-completing-prompt))
(setq yas-snippet-dirs '("~/snippets"))
(require 'yasnippet)
(yas-global-mode 1)
(yas-compile-directory "~/snippets")

(global-set-key (kbd "C-c C-c") 'mc/edit-lines)
(global-set-key (kbd "C-c C-n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-u") 'mc/mark-all-like-this)

(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg)
          (when (and (eval-when-compile
                       '(and (>= emacs-major-version 24)
                             (>= emacs-minor-version 3)))
                     (< arg 0))
            (forward-line -1)))
        (forward-line -1))
      (move-to-column column t)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

(global-set-key "\M-p" 'move-text-up)
(global-set-key "\M-n" 'move-text-down)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

(defun my-go-mode-hook ()
  (add-hook 'before-save-hook 'gofmt-before-save)
  (setq tab-width 2 indent-tabs-mode 1))
(add-hook 'go-mode-hook 'my-go-mode-hook)

(setq make-backup-files nil)

;; (global-set-key (kbd "M-[") 'insert-pair)
;; (global-set-key (kbd "M-{") 'insert-pair)
;; (global-set-key (kbd "M-\"") 'insert-pair)
(put 'downcase-region 'disabled nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(php-mode gradle-mode web-mode-edit-element terraform-mode prettier-js lsp-mode multiple-cursors yaml-mode helm js2-mode web-mode cider clojure-mode rjsx-mode racer solidity-mode dockerfile-mode company tide protobuf-mode typescript-mode markdown-mode helm-projectile helm-ag swift-mode projectile lush-theme js2-refactor)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; (add-to-list 'load-path "~/repo/ternjs/tern/emacs/")
;; (autoload 'tern-mode "tern.el" nil t)

;; (add-hook 'js-mode-hook (lambda () (tern-mode t)))

(projectile-global-mode)
(setq projectile-completion-system 'helm)
;; (helm-projectile-on)

(global-set-key (kbd "C-x C-d") 'projectile-find-file)
(global-set-key (kbd "C-x C-g") 'helm-projectile-ag)
(add-to-list 'projectile-globally-ignored-directories "vendor")
(add-to-list 'projectile-globally-ignored-directories "dev")
(add-to-list 'projectile-globally-ignored-directories "fonts")
(add-to-list 'projectile-globally-ignored-directories "dist")

(global-set-key (kbd "C-x C-y") 'magit-stage-file)

(setq kotlin-tab-width 2)
(put 'set-goal-column 'disabled nil)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1)
  )

(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)

(defun tide-popup-select-item (prompt list)
    (helm
     :sources
     (helm-build-sync-source prompt
       :candidates list)
       :buffer "*Tide Completion Candidates*"))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
;; (add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(add-hook 'racer-mode-hook #'eldoc-mode)

(add-hook 'racer-mode-hook #'company-mode)

(setq company-tooltip-align-annotations t)

(setq clojure-indent-style 'always-indent)
(add-hook 'clojure-mode-hook #'cider-mode)

;; TSX - from https://github.com/adimit/config/blob/master/newmacs/main.org#typescript and https://www.reddit.com/r/emacs/comments/cztjdl/tsx_setup/
(defun my-web-mode-hook ())

(setq web-mode-enable-auto-quoting nil)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-attr-indent-offset 2)
(setq web-mode-attr-value-indent-offset 2)

;; Set higher priority for backend importance when suggesting auto complete. This will bring the TSServer suggestions first instead of those recommended by dabbrev-code
(setq company-transformers '(company-sort-by-backend-importance))

;; Define company backends to use. First element contains priority TSServer -> Files -> yasnippet (if installed) -> dabbrev-code

(set (make-local-variable 'company-backends)
     '((company-tide company-files :with company-yasnippet :with company-dabbrev-code)
       (company-dabbrev-code company-dabbrev)))

;; Function to use your node_modules's TSServer to avoid possible collisions with project's Typescript version and Global Typescript version
(defun tsserver-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (tsserver
          (and root
               (expand-file-name "node_modules/.bin/tsserver"
                                 root))))
    (when (and tsserver (file-executable-p tsserver))
      (setq-default tide-tsserver-executable tsserver))))

(require 'flycheck)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)

(require 'lsp-mode)
(add-hook 'typescript-mode-hook #'lsp)
