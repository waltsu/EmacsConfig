;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq display-line-numbers-type 'relative)
(setq-default show-trailing-whitespace t)

(setq mac-option-modifier nil
      mac-command-modifier 'meta
      select-enable-clipboard t)

;; Autocompletion
(set-company-backend! 'ruby-mode' (company-files company-dabbrev-code))
(set-company-backend! 'rjsx-mode '(company-lsp company-dabbrev-code))

;; Keybingins

(map! :leader
      (:desc "file" :prefix "f"
        :desc "Find in files" :n "s" #'helm-do-ag-project-root))

(setq ruby-insert-encoding-magic-comment nil)

(setq-default flycheck-disabled-checkers '(ruby-rubocop))

;; Javascript
(require 'flycheck)
(require 'lsp-mode)
(require 'lsp-ui)
(eval-after-load 'javascript-mode
  '(progn
     (add-hook 'js2-mode-hook #'add-node-modules-path)))
(add-hook 'js2-mode-hook 'prettier-js-mode)

(defun my/disable-checkers ()
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint) '(html-tidy))))

(add-hook 'flycheck-mode-hook 'my/disable-checkers)

(flycheck-add-next-checker 'lsp-ui 'javascript-eslint)

;; Typescript
(defun my/setup-tide-mode ()
    (interactive)
    (tide-setup)
    (flycheck-mode +1)
    (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (eldoc-mode +1)
    (tide-hl-identifier-mode +1)
    (company-mode +1)
    (prettier-js-mode +1))
(setq company-tooltip-align-annotations t)
(add-hook 'typescript-mode-hook #'my/setup-tide-mode)
(add-to-list 'auto-mode-alist '("\\.tsx$" . typescript-mode))


;; Flow
(add-hook 'js2-mode-hook 'flow-minor-enable-automatically)

;; Markdown
(defun my/setup-markdown-mode ()
  (set-fill-column 1000))
(add-hook 'markdown-mode-hook 'my/setup-markdown-mode)

;; Org mode
(setq org-agenda-files (list "~/Dropbox/org/todo.org"
                             "~/Dropbox/org/personal.org"))
