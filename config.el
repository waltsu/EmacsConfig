;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(load-file "~/.doom.d/org-exports/flowdock.el")

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
        :desc "Find in files" :n "s" #'+helm/project-search))

;; Flycheck
(setq flycheck-check-syntax-automatically '(mode-enabled save))

(eval-after-load 'org-mode
  (map! :leader
        (:desc "export" :prefix "e"
          :desc "org-export" "o" #'org-export-dispatch)))

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

;; Typescript
(defun my/setup-tide-mode ()
    (interactive)
    (tide-setup)
    (flycheck-mode +1)
    (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (eldoc-mode +1)
    (tide-hl-identifier-mode +1)
    (company-mode +1)
    (prettier-js-mode +1)
    (unless (member 'javascript-eslint (flycheck-get-next-checkers 'typescript-tide))
      (flycheck-add-next-checker 'typescript-tide 'javascript-eslint))
    )
    (setq tide-tsserver-executable "node_modules/.bin/tsserver")
    (setq typescript-indent-level 2)
(setq company-tooltip-align-annotations t)
(add-hook 'typescript-mode-hook #'my/setup-tide-mode)
(add-to-list 'auto-mode-alist '("\\.tsx$" . typescript-mode))


;; Markdown
;(defun my/setup-markdown-mode ()
;  (set-fill-column 1000))
;(add-hook 'markdown-mode-hook 'my/setup-markdown-mode)

;; Org mode
(setq org-agenda-files (list "~/Dropbox/org/todo.org"
                             "~/Dropbox/org/notes.org"
                             "~/Dropbox/org/personal.org"))

;; Calendar
(setq calendar-week-start-day 1)

;; Golang
(eval-after-load 'go-mode
  (add-hook 'before-save-hook #'gofmt-before-save))

;; Python
(defun my/setup-company-jedi ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/setup-company-jedi)

(setq-default flycheck-disabled-checkers '(python-pylint))
(flycheck-add-next-checker 'python-flake8 'python-pycompile)

;; Ruby
; EnhRuby is slow with large files, use ruby-mode instead
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
