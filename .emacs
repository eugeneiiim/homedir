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

;; Install copilot dependencies if missing
(dolist (pkg '(editorconfig jsonrpc f))
  (unless (package-installed-p pkg)
    (unless package-archive-contents
      (package-refresh-contents))
    (package-install pkg)))

;; Copilot.el setup - clone if not present, lazy load
(let ((copilot-dir (expand-file-name "~/.emacs.d/copilot.el")))
  (unless (file-exists-p copilot-dir)
    (shell-command (concat "git clone https://github.com/copilot-emacs/copilot.el.git " copilot-dir)))
  (add-to-list 'load-path copilot-dir))

(autoload 'copilot-mode "copilot" nil t)
(autoload 'copilot-complete "copilot" nil t)

;; Start copilot after idle to avoid blocking file open
(add-hook 'prog-mode-hook
          (lambda ()
            (run-with-idle-timer 0.5 nil
                                 (lambda (buf)
                                   (when (buffer-live-p buf)
                                     (with-current-buffer buf
                                       (copilot-mode 1))))
                                 (current-buffer))))

;; Copilot keybindings
(with-eval-after-load 'copilot
  (define-key copilot-completion-map (kbd "TAB") #'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "<tab>") #'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "M-TAB") #'copilot-accept-completion-by-word)
  (define-key copilot-completion-map (kbd "C-n") #'copilot-next-completion)
  (define-key copilot-completion-map (kbd "C-p") #'copilot-previous-completion)
  (define-key copilot-completion-map (kbd "C-g") #'copilot-clear-overlay))
(global-set-key (kbd "C-c c") #'copilot-complete)

;; Ensure nvm node is on exec-path for Tide/tsserver
(let ((nvm-node-dir (expand-file-name "~/.nvm/versions/node/v24.13.0/bin")))
  (when (file-directory-p nvm-node-dir)
    (add-to-list 'exec-path nvm-node-dir)
    (setenv "PATH" (concat nvm-node-dir ":" (getenv "PATH")))))

(setq load-path (cons (expand-file-name "~/emacs_stuff") load-path))

(load-theme 'lush t)
(global-font-lock-mode 1)

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq js-indent-level 2)
(setq c-basic-offset 2)
(setq typescript-indent-level 2)

;; Force typescript-mode instead of tree-sitter modes in Emacs 30
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.prisma\\'" . prisma-ts-mode))

;; Ensure font-lock is on for typescript
(add-hook 'typescript-mode-hook (lambda () (font-lock-mode 1)))

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

(setq make-backup-files nil)

(put 'downcase-region 'disabled nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(prettier prisma-ts-mode graphql-mode vue-mode groovy-mode gpt gradle-mode web-mode-edit-element terraform-mode prettier-js lsp-mode multiple-cursors yaml-mode helm js2-mode web-mode cider rjsx-mode racer dockerfile-mode company tide protobuf-mode typescript-mode markdown-mode helm-projectile helm-ag swift-mode projectile lush-theme js2-refactor)))
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

(global-set-key (kbd "C-x C-d") 'projectile-find-file)
(global-set-key (kbd "C-x C-g") 'helm-projectile-ag)
(add-to-list 'projectile-globally-ignored-directories "vendor")
(add-to-list 'projectile-globally-ignored-directories "dev")
(add-to-list 'projectile-globally-ignored-directories "fonts")
(add-to-list 'projectile-globally-ignored-directories "dist")

(global-set-key (kbd "C-x C-y") 'magit-stage-file)

(put 'set-goal-column 'disabled nil)

;; Configure flycheck to use eslint_d for speed with flat config support
(with-eval-after-load 'flycheck
  (setq flycheck-javascript-eslint-executable "eslint_d")

  ;; Only enable javascript-eslint when node_modules is installed.
  ;; This prevents the "config file missing" error when opening TS files
  ;; in repos where yarn/npm hasn't been run yet.
  (put 'javascript-eslint 'flycheck-enabled
       (lambda ()
         (and buffer-file-name
              (locate-dominating-file buffer-file-name "node_modules"))))

  ;; Override to support ESLint flat config (eslint.config.mjs/js/cjs)
  (defun flycheck-eslint--find-working-directory (_checker)
    "Find working directory for ESLint, supporting flat config format."
    (when buffer-file-name
      (or
       ;; First check for flat config files (ESLint 9+)
       (locate-dominating-file buffer-file-name "eslint.config.mjs")
       (locate-dominating-file buffer-file-name "eslint.config.js")
       (locate-dominating-file buffer-file-name "eslint.config.cjs")
       ;; Fall back to legacy config detection
       (locate-dominating-file buffer-file-name "node_modules")
       (locate-dominating-file buffer-file-name ".eslintignore")
       (locate-dominating-file buffer-file-name ".eslintrc")
       (locate-dominating-file buffer-file-name ".eslintrc.js")
       (locate-dominating-file buffer-file-name ".eslintrc.json")))))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  ;; Use eslint when available (enabled predicate checks for node_modules)
  (when (locate-dominating-file (or buffer-file-name default-directory) "node_modules")
    (flycheck-select-checker 'javascript-eslint))
  (setq flycheck-check-syntax-automatically '(save mode-enabled idle-change))
  (setq flycheck-idle-change-delay 1)
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (when (fboundp 'company-mode)
    (company-mode +1)))

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

;; Use prettier.el server for format-on-save (fast, updates buffer in-place)
(add-hook 'typescript-mode-hook 'prettier-mode)

(add-hook 'racer-mode-hook #'eldoc-mode)

(add-hook 'racer-mode-hook #'company-mode)

(setq company-tooltip-align-annotations t)

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

(add-hook 'typescript-mode-hook #'tsserver-node-modules)

;; (require 'flycheck)
;; (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
;; (add-hook 'web-mode-hook
;;           (lambda ()
;;             (when (string-equal "tsx" (file-name-extension buffer-file-name))
;;               (setup-tide-mode))))
;; ;; enable typescript-tslint checker
;; (flycheck-add-mode 'typescript-tslint 'web-mode)

;; (require 'lsp-mode)
;; (add-hook 'typescript-mode-hook #'lsp)

(require 'tide)

;; web-mode setup
(define-derived-mode vue-mode web-mode "Vue")
(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))

(defun vue-eglot-init-options ()
  (let ((tsdk-path (expand-file-name
                    "lib"
                    (shell-command-to-string "npm list --global --parseable typescript | head -n1 | tr -d \"\n\""))))
    `(:typescript (:tsdk ,tsdk-path
                         :languageFeatures (:completion
                                            (:defaultTagNameCase "both"
                                                                 :defaultAttrNameCase "kebabCase"
                                                                 :getDocumentNameCasesRequest nil
                                                                 :getDocumentSelectionRequest nil)
                                            :diagnostics
                                            (:getDocumentVersionRequest nil))
                         :documentFeatures (:documentFormatting
                                            (:defaultPrintWidth 100
                                                                :getDocumentPrintWidthRequest nil)
                                            :documentSymbol t
                                            :documentColor t)))))
;; Volar
;; (add-to-list 'eglot-server-programs
;;                `(vue-mode . ("vue-language-server" "--stdio" :initializationOptions ,(vue-eglot-init-options))))

;; Start eslint_d daemon for fast formatting (prettierd auto-starts on first use)
(start-process "eslint_d-start" nil "eslint_d" "start")

;; Auto-format TypeScript files on save using eslint_d (synchronous, daemon is fast)
(defun ts-format-on-save ()
  "Run eslint_d --fix on .ts/.tsx files after save, then revert buffer.
Prettier is handled by prettier-mode (before-save, via server)."
  (when (and buffer-file-name
             (string-match-p "\\.tsx?$" buffer-file-name))
    (let ((project-dir (locate-dominating-file buffer-file-name "package.json")))
      (when (and project-dir
                 (file-directory-p (expand-file-name "node_modules" project-dir)))
        (let ((default-directory project-dir))
          (call-process "eslint_d" nil nil nil "--fix" buffer-file-name)
          (revert-buffer t t t))))))

(add-hook 'after-save-hook 'ts-format-on-save)

(setq helm-grep-file-path-style 'relative)
(setq helm-projectile-set-input-automatically nil)
(advice-add 'helm-grep-ag-1 :around
  (lambda (orig-fn directory &rest args)
    (let ((helm-ff-default-directory directory))
      (apply orig-fn directory args))))

(require 'helm-ag)
(setq helm-ag-base-command "ag --nocolor --nogroup")
(setq helm-ag-insert-at-point nil)
(setq helm-grep-ag-command "rg --color=always --smart-case --search-zip --no-heading --line-number --hidden %s -- %s %s")
