;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)

(package! add-node-modules-path :recipe (:fetcher github :repo "codesuki/add-node-modules-path"))
(package! prettier-js)
(package! flow-minor-mode :recipe (:fetcher github :repo "an-sh/flow-minor-mode"))
(package! company-jedi)
