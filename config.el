;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq display-line-numbers-type 'relative)
(setq-default show-trailing-whitespace t)

(setq mac-option-modifier nil
      mac-command-modifier 'meta
      select-enable-clipboard t)

;; Autocompletion
(set-company-backend! 'ruby-mode' (company-files company-dabbrev-code))

;; Keybingins

(map! :leader
      (:desc "file" :prefix "f"
        :desc "Find in files" :n "s" #'helm-do-ag-project-root))

(setq ruby-insert-encoding-magic-comment nil)
