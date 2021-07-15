;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Theresa Diefenbach"
      usee-mail-address "theresa.diefenbach@mailbox.org")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord-light)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Nextcloud/2ndBrain/org")
(setq org-roam-directory "~/Nextcloud/2ndBrain/roam")
(setq org-journal-dir "~/Nextcloud/2ndBrain/journal"
      org-journal-date-prefix "#+TITLE: "
      org-journal-time-prefix "* "
      org-journal-date-format "%a, %Y-%m-%d"
      org-journal-file-format "%Y-%m-%d.org")





(use-package org-ref
  :config
  (setq reftex-default-bibliography '("~/Nextcloud/2ndBrain/bibliography/references.bib"))

  ;; see org-ref for use of these variables
  (setq org-ref-bibliography-notes "~/Nextcloud/2ndBrain/bibliography/notes.org"
        org-ref-default-bibliography '("~/Nextcloud/2ndBrain/bibliography/references.bib")
        org-ref-pdf-directory "~/Nextcloud/2ndBrain/bibliography/papers/")
)

(use-package org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode))






;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Tramp maybe hangs because of zsh?
(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

;; Window navigation
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)

;; ~/.doom.d/config.el
(setq +python-ipython-repl-args '("-i" "--simple-prompt" "--no-color-info"))
(setq +python-jupyter-repl-args '("--simple-prompt"))


(setq evil-escape-key-sequence "fd")

;; Set tabs
;;(setq c-basic-indent 2)
;;(setq-default tab-width 4)
;;setq-default indent-tabs-mode nil)

;; Limit Line Length
(add-hook 'text-mode-hook 'auto-fill-mode)
(setq-default fill-column 72)


(customize-set-variable
 'tramp-password-prompt-regexp
  (concat
   "^.*"
   (regexp-opt
    '("passphrase" "Passphrase"
      ;; English
      "password" "Password"
      "Your OTP" "Your OTP"
      ;; Deutsch
      "passwort" "Passwort"
      ;; Français
      "mot de passe" "Mot de passe")
    t)
   ".*:\0? *"))

;; use xetex as latex engine for better fonts
(setq-default TeX-engine 'xetex)
(setq org-latex-pdf-process
      '("xelatex -interaction nonstopmode %f"
        "bibtex %b"
        "xelatex -interaction nonstopmode %f"
        "xelatex -interaction nonstopmode %f")) ;; for multiple passes

;; Org Beamer
(require 'ox-beamer)
(add-to-list 'org-beamer-environments-extra
             '("onlyenv" "O" "\\begin{onlyenv}%a" "\\end{onlyenv}"))

(setq bibtex-completion-bibliography
      '("~/Nextcloud/2ndBrain/bibliography/references.bib"))


(setq orb-preformat-keywords
      '("citekey" "title" "url" "author-or-editor" "keywords" "file")
      orb-process-file-keyword t
      orb-file-field-extensions '("pdf"))

(setq orb-templates
      '(("r" "ref" plain (function org-roam-capture--get-point)
         ""
         :file-name "${citekey}"
         :head "#+TITLE: ${citekey}: ${title}\n#+ROAM_KEY: ${ref}

- tags ::
- keywords :: ${keywords}

* ${title}
:PROPERTIES:
:Custom_ID: ${citekey}
:URL: ${url}
:AUTHOR: ${author-or-editor}
:NOTER_DOCUMENT: ${file}  ; <== special file keyword: if more than one filename
:NOTER_PAGE:              ;     is available, the user will be prompted to choose
:END:")))
