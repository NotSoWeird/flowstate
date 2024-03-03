(package! embark)
(package! direnv)
(package! org-modern)
(package! org-super-agenda)
(package! org-roam-ui)
(package! org-transclusion)
(package! org-yt)
(package! toc-org)
(package! lister)
(package! all-the-icons-dired)
(package! all-the-icons-completion)
(package! all-the-icons-ivy)
(package! ox-reveal)
(package! magit-todos)
(package! hledger-mode)
(package! rainbow-mode)
(package! crdt)
(package! ess)
(package! focus)
(package! olivetti)
(package! async)
(package! centered-cursor-mode)
(package! org-ql)
(package! persist)
(package! sudo-edit)
(package! org-yaap
  :recipe (:host gitlab
           :repo "tygrdev/org-yaap"))
(package! org-timeblock
  :recipe (:host github
           :repo "ichernyshovvv/org-timeblock"))
(package! vulpea)
(package! flyspell-lazy)
(package! typst-ts-mode
  :recipe (:type git
           :host sourcehut
           :repo "meow_king/typst-ts-mode"))
(package! atomic-chrome)

;; These packages attempt to build native C code at runtime. Prefer copies
;; installed by Nix if they exist to avoid having to make GCC globally
;; available.
(package! emacsql :built-in 'prefer)
(package! emacsql-sqlite :built-in 'prefer)
(package! pdf-tools :built-in 'prefer)
