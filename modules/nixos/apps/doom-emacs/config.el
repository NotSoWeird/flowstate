;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;;------ User configuration ------;;;

;; Import relevant system variables from flake (see doom.nix)
;; includes variables like user-full-name, user-username, user-home-directory, user-email-address, doom-font,
;; and a few other custom variables I use later
(load! "~/.emacs.d/system-vars.el")
;; custom variables include:
;; dotfiles-dir, absolute path to home directory
;; user-default-roam-dir, name of default org-roam directory for the machine (relative to ~/Org)
;; system-nix-profile, profile selected from my dotfiles ("personal" "work" "wsl" etc...)
;; system-wm-type, wayland or x11? only should be considered if system-nix-profile is "personal" or "work"

;; I prefer visual lines
(setq display-line-numbers-type 'visual
      line-move-visual t)
(use-package-hook! evil
  :pre-init
  (setq evil-respect-visual-line-mode t) ;; sane j and k behavior
  t)

;; I also like evil mode visual movement
(map! :map evil-normal-state-map
      :desc "Move to next visual line"
      "j" 'evil-next-visual-line
      :desc "Move to previous visual line"
      "k" 'evil-previous-visual-line)

;; Theme
(setq custom-theme-directory "~/.emacs.d/themes")
(setq doom-theme 'doom-stylix)
;; +unicode-init-fonts-h often errors out
(remove-hook 'doom-init-ui-hook '+unicode-init-fonts-h)

;; Transparent background
(if (string= system-nix-profile "wsl")
  ;; Can't be that tranparent under wsl because no blur
  (funcall (lambda ()
    (set-frame-parameter nil 'alpha-background 98)
    (add-to-list 'default-frame-alist '(alpha-background . 98))
  ))
  ;; On Linux I can enable blur, however
  (funcall (lambda ()
    (set-frame-parameter nil 'alpha-background 65)
    (add-to-list 'default-frame-alist '(alpha-background . 65))
  ))
)

;; Icons in completion buffers
(add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup)
(all-the-icons-completion-mode)

;; This makes non-main buffers dimmer, so you can focus on main buffers
(solaire-global-mode +1)

;; Grammar tasing should be voluntary
(setq writegood-mode nil)

;; Beacon shows where the cursor is, even when fast scrolling
(setq beacon-mode t)

;; Quicker window management keybindings
(bind-key* "C-j" #'evil-window-down)
(bind-key* "C-k" #'evil-window-up)
(bind-key* "C-h" #'evil-window-left)
(bind-key* "C-l" #'evil-window-right)
(bind-key* "C-q" #'evil-window-delete)
(bind-key* "M-q" #'kill-current-buffer)
(bind-key* "M-w" #'+workspace/close-window-or-workspace)
(bind-key* "M-n" #'next-buffer)
(bind-key* "M-p" #'previous-buffer)
(bind-key* "M-z" #'+vterm/toggle)
(bind-key* "M-e" #'+eshell/toggle)
(bind-key* (kbd "M-<return>") #'+vterm/here)
(bind-key* (kbd "M-E") #'+eshell/here)

;; Buffer management
(bind-key* "<mouse-9>" #'next-buffer)
(bind-key* "<mouse-8>" #'previous-buffer)

;; Disables custom.el
(setq custom-file null-device)

;; emacs-dashboard setup
(require 'all-the-icons)
(require 'dashboard)
(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))
      doom-fallback-buffer-name "*dashboard*")

;; emacs-dashboard variables
(setq dashboard-banner-logo-title "Welcome to Nix Doom Emacs")
(setq dashboard-startup-banner 2)
(setq dashboard-icon-type 'all-the-icons) ;; use `all-the-icons' package
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-set-navigator t)
(setq dashboard-items '())
(setq dashboard-center-content t)
(setq dashboard-footer-messages '("Here to do customizing, or actual work?"
                                  "M-x insert-inspiring-message"
                                  "My software never has bugs. It just develops random features."
                                  "Dad, what are clouds made of? Linux servers, mostly."
                                  "There is no place like ~"
                                  "~ sweet ~"
                                  "sudo chown -R us ./allyourbase"
                                  "I’ll tell you a DNS joke but it could take 24 hours for everyone to get it."
                                  "I'd tell you a UDP joke, but you might not get it."
                                  "I'll tell you a TCP joke. Do you want to hear it?"))
(setq dashboard-navigator-buttons
  `(;; line1
    ( (,"Roam" "" "" (lambda (&rest _)) 'org-formula)
     (,(all-the-icons-octicon "globe" :height 1.0 :v-adjust 0.0)
      "Notes overview" "" (lambda (&rest _) (org-roam-default-overview)) 'org-formula)
     (,(all-the-icons-fileicon "org" :height 1.0 :v-adjust 0.0)
      "Switch roam db" "" (lambda (&rest _) (org-roam-switch-db)) 'org-formula)
    )
    ;; line 2
    ( (,"Git" "" "" (lambda (&rest _)) 'diredfl-exec-priv)
     (,(all-the-icons-octicon "mark-github" :height 1.0 :v-adjust 0.0)
       "GitHub" "" (lambda (&rest _) (browse-url "ext+container:name=Tech&url=https://github.com/librephoenix")) 'diredfl-exec-priv)
     (,(all-the-icons-faicon "gitlab" :height 1.0 :v-adjust 0.0)
       "GitLab" "" (lambda (&rest _) (browse-url "ext+container:name=Tech&url=https://gitlab.com/librephoenix")) 'diredfl-exec-priv)
     (,(all-the-icons-faicon "coffee" :height 1.0 :v-adjust 0.0)
       "Gitea" "" (lambda (&rest _) (browse-url my-gitea-domain)) 'diredfl-exec-priv)
    )
    ;; line 3
    ( (,"Agenda" "" "" (lambda (&rest _)) 'dired-warning)
     (,(all-the-icons-octicon "checklist" :height 1.0 :v-adjust 0.0)
      "Agenda todos" "" (lambda (&rest _) (org-agenda-list)) 'dired-warning)
     (,(all-the-icons-octicon "calendar" :height 1.0 :v-adjust 0.0)
      "Agenda calendar" "" (lambda (&rest _) (cfw:open-org-calendar)) 'dired-warning)
    )
    ;; line 4
    ( (,"Config" "" "" (lambda (&rest _)) 'dired-mark)
     (,(all-the-icons-faicon "cogs" :height 1.0 :v-adjust 0.0)
      "System config" "" (lambda (&rest _) (projectile-switch-project-by-name "~/.dotfiles" t)) 'dired-mark)
     (,(all-the-icons-material "help" :height 1.0 :v-adjust -0.2)
      "Doom documentation" "" (lambda (&rest _) (doom/help)) 'dired-mark)
    )))

(setq dashboard-footer-icon
  (all-the-icons-faicon "list-alt"
    :height 1.0
    :v-adjust -0.15
    :face 'font-lock-keyword-face))
(dashboard-setup-startup-hook)

;; Smooth scrolling
;; requires good-scroll.el
;;(good-scroll-mode 1)
;;(setq good-scroll-duration 0.4
;;      good-scroll-step 270
;;      good-scroll-render-rate 0.03)
;;
;;(global-set-key (kbd "<next>") #'good-scroll-up-full-screen)
;;(global-set-key (kbd "<prior>") #'good-scroll-down-full-screen)

(setq scroll-margin 30)
(setq hscroll-margin 10)

;; Requires for faster loading
(require 'org-agenda)
(require 'dired)

;; Garbage collection to speed things up
(add-hook 'after-init-hook
          #'(lambda ()
              (setq gc-cons-threshold (* 100 1024 1024))))
(add-hook 'focus-out-hook 'garbage-collect)
(run-with-idle-timer 5 t 'garbage-collect)

;; Enable autorevert globally so that buffers update when files change on disk.
;; Very useful when used with file syncing (i.e. syncthing)
(setq global-auto-revert-mode nil)
(setq auto-revert-use-notify t)

;; Neotree fun
(defun neotree-snipe-dir ()
  (interactive)
  (if (projectile-project-root)
    (neotree-dir (projectile-project-root))
    (neotree-dir (file-name-directory (file-truename (buffer-name))))
  )
)

(map! :leader :desc "Open neotree here" "o n" #'neotree-snipe-dir
              :desc "Hide neotree" "o N" #'neotree-hide)

;; For camelCase
(global-subword-mode 1)

;;;------ Registers ------;;;

(map! :leader
      :desc "Jump to register"
      "r" 'jump-to-register)

(if (string= system-nix-profile "personal") (set-register ?f (cons 'file (concat user-home-directory "/Org/Family.s/Notes/hledger.org"))))
(set-register ?h (cons 'file user-home-directory))
(set-register ?r (cons 'file (concat dotfiles-dir "/README.org")))

;;;------ Org mode configuration ------;;;

;; Set default org directory
(setq org-directory "~/.Org")

(remove-hook 'after-save-hook #'+literate|recompile-maybe)
(set-company-backend! 'org-mode nil)

;; Automatically show images but manually control their size
(setq org-startup-with-inline-images t
      org-image-actual-width nil)

(require 'evil-org)
(require 'evil-org-agenda)
(add-hook 'org-mode-hook 'evil-org-mode -100)

;; Top-level headings should be bigger!
(custom-set-faces!
  '(org-level-1 :inherit outline-1 :height 1.3)
  '(org-level-2 :inherit outline-2 :height 1.25)
  '(org-level-3 :inherit outline-3 :height 1.2)
  '(org-level-4 :inherit outline-4 :height 1.1)
  '(org-level-5 :inherit outline-5 :height 1.1)
  '(org-level-6 :inherit outline-6 :height 1.05)
  '(org-level-7 :inherit outline-7 :height 1.05)
  )

(after! org (org-eldoc-load))

(with-eval-after-load 'org (global-org-modern-mode))

;; Add frame borders and window dividers
(modify-all-frames-parameters
 '((right-divider-width . 5)
   (internal-border-width . 5)))
(dolist (face '(window-divider
                window-divider-first-pixel
                window-divider-last-pixel))
  (face-spec-reset-face face)
  (set-face-foreground face (face-attribute 'default :background)))
(set-face-background 'fringe (face-attribute 'default :background))

(setq
  ;; Edit settings
  org-auto-align-tags nil
  org-tags-column 0
  org-catch-invisible-edits 'show-and-error
  org-special-ctrl-a/e t
  org-insert-heading-respect-content t

  ;; Org styling, hide markup etc.
  org-hide-emphasis-markers t
  org-pretty-entities t
  org-ellipsis "…")

(setq-default line-spacing 0.15)

; Automatic table of contents is nice
(if (require 'toc-org nil t)
    (progn
      (add-hook 'org-mode-hook 'toc-org-mode)
      (add-hook 'markdown-mode-hook 'toc-org-mode))
  (warn "toc-org not found"))

;;---- this block from http://fgiasson.com/blog/index.php/2016/06/21/optimal-emacs-settings-for-org-mode-for-literate-programming/ ----;;
;; Tangle Org files when we save them
(defun tangle-on-save-org-mode-file()
  (when (string= (message "%s" major-mode) "org-mode")
    (org-babel-tangle)))

(add-hook 'after-save-hook 'tangle-on-save-org-mode-file)
;; ---- end block ---- ;;

;; Better org table editing
;; This breaks multiline visual block edits
;;(setq-default evil-insert-state-exit-hook '(org-update-parent-todo-statistics
;; t))
;;(setq org-table-automatic-realign nil)

;; Better for org source blocks
(setq electric-indent-mode nil)
(setq org-src-window-setup 'current-window)
(set-popup-rule! "^\\*Org Src"
  :side 'top'
  :size 0.9)

;; Horizontal scrolling tables
(add-load-path! "~/.emacs.d/phscroll")
(setq org-startup-truncated nil)
(with-eval-after-load "org"
  (require 'org-phscroll))
(setq phscroll-calculate-in-pixels t)

;; Org side tree outline
(add-load-path! "~/.emacs.d/org-side-tree")
(require 'org-side-tree)
(setq org-side-tree-persistent nil)
(setq org-side-tree-fontify t)
(setq org-side-tree-enable-folding t)
(defun org-side-tree-create-or-toggle ()
  (interactive)
  (if (or (org-side-tree-has-tree-p) (eq major-mode 'org-side-tree-mode))
      (org-side-tree-toggle)
      (org-side-tree)))
(map! :leader
      "O t" #'org-side-tree-create-or-toggle)
(map! :map org-side-tree-mode-map
      "SPC" nil)

(require 'org-download)

;; Drag-and-drop to `dired`
(add-hook 'dired-mode-hook 'org-download-enable)

;; system-wm-type, wayland or x11? only should be considered if system-nix-profile is "personal" or "work"
(if (string= system-wm-type "wayland")
  (setq org-download-screenshot-method "grim -g \"$(slurp)\" %s")
  (setq org-download-screenshot-method "flameshot gui -p %s")
)

(after! org-download
   (setq org-download-method 'directory))

(after! org
  (setq-default org-download-image-dir "img/"
        org-download-heading-lvl nil))

(add-to-list 'display-buffer-alist '("^*Async Shell Command*" . (display-buffer-no-window)))

(defun org-download-clipboard-basename ()
  (interactive)
  (setq org-download-path-last-dir org-download-image-dir)
  (setq org-download-image-dir (completing-read "directory: " (-filter #'f-directory-p (directory-files-recursively "." "" t)) nil t))
  (org-download-clipboard (completing-read "basename: " '() nil nil))
  (setq org-download-image-dir org-download-path-last-dir)
)

(map! :leader
      :desc "Insert a screenshot"
      "i s" 'org-download-screenshot
      :desc "Insert image from clipboard"
      "i p" 'org-download-clipboard
      "i P" 'org-download-clipboard-basename)

(defun org-new-file-from-template()
  "Copy a template from ~/Templates into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (setq template-file (completing-read "Template file:" (directory-files "~/Templates")))
  (setq filename
        (concat
         (make-temp-name
          (concat (file-name-directory (buffer-file-name))
                  "files/"
                  (file-name-nondirectory (buffer-file-name))
                  "_"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) (file-name-extension template-file t)))
  (copy-file (concat user-home-directory "/Templates/" template-file) filename)
  (setq prettyname (read-from-minibuffer "Pretty name:"))
  (insert (concat "[[./files/" (file-name-nondirectory filename) "][" prettyname "]]"))
  (org-display-inline-images))

(map! :leader
      :desc "Create a new file from a template and insert a link at point"
      "i t" 'my-org-new-file-from-template)

(if (not (string= system-nix-profile "wsl"))
  (when (require 'openwith nil 'noerror)
     (setq openwith-associations
           (list
           (list (openwith-make-extension-regexp
                  '("mpg" "mpeg" "mp3" "mp4"
                    "avi" "wmv" "wav" "mov" "flv"
                    "ogm" "ogg" "mkv"))
                    "mpv"
                    '(file))
           (list (openwith-make-extension-regexp
                  '("doc" "xls" "ppt" "odt" "ods" "odg" "odp"))
                    "libreoffice"
                    '(file))
               '("\\.lyx" "lyx" (file))
               '("\\.chm" "kchmviewer" (file))
           (list (openwith-make-extension-regexp
                  '("pdf" "ps" "ps.gz" "dvi"))
                    "atril"
                    '(file))
           (list (openwith-make-extension-regexp
                  '("kdenlive"))
                    "kdenlive-accel"
                    '(file))
           (list (openwith-make-extension-regexp
                  '("kra"))
                    "krita"
                    '(file))
           (list (openwith-make-extension-regexp
                  '("blend" "blend1"))
                    "blender"
                    '(file))
           (list (openwith-make-extension-regexp
                  '("helio"))
                    "helio"
                    '(file))
           (list (openwith-make-extension-regexp
                  '("svg"))
                    "inkscape"
                    '(file))
           (list (openwith-make-extension-regexp
                  '("flp"))
                    "~/.local/bin/flstudio"
                    '(file))
               ))
     (openwith-mode 1)))

(defun org-copy-link-to-clipboard-at-point ()
  "Copy current link at point into clipboard (useful for images and links)"
  ;; Remember to press C-g to kill this foreground process if it hangs!
  (interactive)
  (if (eq major-mode #'org-mode)
      (link-hint-copy-link-at-point)
  )
  (if (eq major-mode #'ranger-mode)
      (ranger-copy-absolute-file-paths)
  )
  (if (eq major-mode #'image-mode)
      (image-mode-copy-file-name-as-kill)
  )
  (shell-command "~/.emacs.d/scripts/copy-link-or-file/copy-link-or-file-to-clipboard.sh " nil nil)
)

(if (string= system-nix-profile "wsl")
    (map! :leader
          :desc "Copy link at point"
          "y y" 'link-hint-copy-link-at-point)
    (map! :leader
          :desc "Copy link/file at point into system clipbord (C-g to escape if copying a file)"
          "y y" 'org-copy-link-to-clipboard-at-point))

;; Online images inside of org mode is pretty cool
;; This snippit is from Tobias on Stack Exchange
;; https://emacs.stackexchange.com/questions/42281/org-mode-is-it-possible-to-display-online-images
(require 'org-yt)

(defun org-image-link (protocol link _description)
  "Interpret LINK as base64-encoded image data."
  (cl-assert (string-match "\\`img" protocol) nil
             "Expected protocol type starting with img")
  (let ((buf (url-retrieve-synchronously (concat (substring protocol 3) ":" link))))
    (cl-assert buf nil
               "Download of image \"%s\" failed." link)
    (with-current-buffer buf
      (goto-char (point-min))
      (re-search-forward "\r?\n\r?\n")
      (buffer-substring-no-properties (point) (point-max)))))

(org-link-set-parameters
 "imghttp"
 :image-data-fun #'org-image-link)

(org-link-set-parameters
 "imghttps"
 :image-data-fun #'org-image-link)

;; Mermaid diagrams
(setq ob-mermaid-cli-path "~/.nix-profile/bin/mmdc")

;; Print org mode
(defun org-simple-print-buffer ()
  "Open an htmlized form of current buffer and open in a web browser to print"
  (interactive)
  (htmlize-buffer)
  (browse-url-of-buffer (concat (buffer-name) ".html"))
  (sleep-for 1)
  (kill-buffer (concat (buffer-name) ".html")))

;; Doesn't work yet, bc htmlize-region takes arguments BEG and END
;(defun org-simple-print-region()
;  "Open an htmlized form of current region and open in a web browser to print"
;  (interactive)
;  (htmlize-region )
;  (browse-url-of-buffer (concat (buffer-name) ".html"))
;  (sleep-for 1)
;  (kill-buffer (concat (buffer-name) ".html")))

(map! :leader
      :prefix ("P" . "Print")
      :desc "Simple print buffer in web browser"
      "p" 'org-simple-print-buffer)

(map! :leader
      :prefix ("P" . "Print")
      :desc "Simple print buffer in web browser"
      "b" 'org-simple-print-buffer)

;(map! :leader
;      :prefix ("P" . "Print")
;      :desc "Simple print region in web browser"
;      "r" 'org-simple-print-region)

;; Display macros inline in buffers
(add-to-list 'font-lock-extra-managed-props 'display)

(font-lock-add-keywords
 'org-mode
 '(("\\({{{[a-zA-Z#%)(_-+0-9]+}}}\\)" 0
    `(face nil display
           ,(format "%s"
                    (let* ((input-str (match-string 0))
                          (el (with-temp-buffer
                                (insert input-str)
                                (goto-char (point-min))
                                (org-element-context)))
                          (text (org-macro-expand el org-macro-templates)))
                      (if text
                          text
                        input-str)))))))

;; Org transclusion
(use-package! org-transclusion
  :after org
  :init
  (map!
   :map global-map "<f12>" #'org-transclusion-add
   :leader
   :prefix "n"
   :desc "Org Transclusion Mode" "t" #'org-transclusion-mode))
(map! :leader :prefix "n" "l" #'org-transclusion-live-sync-start)

(add-hook 'org-mode-hook #'org-transclusion-mode)

;;;------ Org roam configuration ------;;;
(require 'org-roam)
(require 'org-roam-dailies)

(setq org-roam-directory (concat "~/Org/" user-default-roam-dir "/Notes")
      org-roam-db-location (concat "~/Org/" user-default-roam-dir "/Notes/org-roam.db"))

(setq org-roam-node-display-template
      "${title:65}📝${tags:*}")

(org-roam-db-autosync-mode)

(setq mode-line-misc-info '((which-function-mode
  (which-func-mode
   ("" which-func-format " ")))
 ("" so-long-mode-line-info)
 (global-mode-string
  ("" global-mode-string))
 " "
 org-roam-db-choice)
)

(setq full-org-roam-db-list nil)

(setq full-org-roam-db-list (directory-files "~/Org" t "\\.[p,s]$"))
(dolist (item full-org-roam-db-list)
  (setq full-org-roam-db-list
        (append (directory-files item t "\\.[p,s]$") full-org-roam-db-list)))

(setq org-roam-db-choice user-default-roam-dir)
(setq full-org-roam-db-list-pretty (list))
(dolist (item full-org-roam-db-list)
  (setq full-org-roam-db-list-pretty
       (append (list
             (replace-regexp-in-string (concat "\\/home\\/" user-username "\\/Org\\/") "" item)) full-org-roam-db-list-pretty)))

(defun org-roam-open-dashboard ()
  "Open ${org-roam-directory}/dashboard.org (I use this naming convention to create dashboards for each of my org roam maps)"
  (interactive)
  (if (file-exists-p (concat org-roam-directory "/dashboard.org"))
      (org-open-file (concat org-roam-directory "/dashboard.org"))
      (dired org-roam-directory))
)

(defun org-roam-open-inbox ()
  "Capture info in ${org-roam-directory}/inbox.org (I use this naming convention to create dashboards for each of my org roam maps)"
  (interactive)
  (if (file-exists-p (concat org-roam-directory "/inbox.org"))
      (org-open-file (concat org-roam-directory "/inbox.org"))
      (message "No inbox found, capture something with M-x org-roam-capture-inbox"))
)

(defun org-roam-capture-inbox ()
  (interactive)
  (org-roam-capture- :node (org-roam-node-create)
                     :templates '(("i" "inbox" plain "* %?"
                                  :if-new (file+head "inbox.org" "#+title: Inbox\n")))))

(defun org-roam-switch-db (&optional arg silent)
  "Switch to a different org-roam database, arg"
  (interactive)
  (when (not arg)
  (setq full-org-roam-db-list nil)

  (setq full-org-roam-db-list (directory-files "~/Org" t "\\.[p,s]$"))
  (dolist (item full-org-roam-db-list)
    (setq full-org-roam-db-list
        (append (directory-files item t "\\.[p,s]$") full-org-roam-db-list)))

  (setq full-org-roam-db-list-pretty (list))
  (dolist (item full-org-roam-db-list)
    (setq full-org-roam-db-list-pretty
        (append (list
                 (replace-regexp-in-string (concat "\\/home\\/" user-username "\\/Org\\/") "" item)) full-org-roam-db-list-pretty)))

  (setq org-roam-db-choice (completing-read "Select org roam database: "
                          full-org-roam-db-list-pretty nil t)))
  (when arg
    (setq org-roam-db-choice arg))

      (setq org-roam-directory (file-truename (concat "~/Org/" org-roam-db-choice "/Notes"))
            org-roam-db-location (file-truename (concat "~/Org/" org-roam-db-choice "/Notes/org-roam.db"))
            org-directory (file-truename (concat "~/Org/" org-roam-db-choice "/Notes")))
  (when (not silent)
  (org-roam-open-dashboard))

  (org-roam-db-sync)

  (message (concat "Switched to " org-roam-db-choice " org-roam database!")))

(defun org-roam-default-overview ()
  (interactive)
  (org-roam-switch-db user-default-roam-dir))

(defun org-roam-switch-db-id-open (arg ID &optional switchpersist)
  "Switch to another org-roam db and visit file with id arg"
  "If switchpersist is non-nil, stay in the new org-roam db after visiting file"
  (interactive)
  (setq prev-org-roam-db-choice org-roam-db-choice)
  (org-roam-switch-db arg 1)
  (org-roam-id-open ID)
  (when (not switchpersist)
    (org-roam-switch-db prev-org-roam-db-choice 1)))

;;;------ Org-roam-agenda configuration ------;;;
(defun text-in-buffer-p (TEXT)
(save-excursion (goto-char (point-min)) (search-forward TEXT nil t)))

(defun apply-old-todos-tag-maybe (&optional FILE)
   (interactive)
   (if (stringp FILE)
   (setq the-daily-node-filename FILE)
   (setq the-daily-node-filename buffer-file-name))
   (if (org-roam-dailies--daily-note-p the-daily-node-filename)
    (if (<= (nth 2 (org-roam-dailies-calendar--file-to-date the-daily-node-filename)) (nth 2 org-agenda-current-date))
      (if (<= (nth 1 (org-roam-dailies-calendar--file-to-date the-daily-node-filename)) (nth 1 org-agenda-current-date))
        (if (<= (nth 0 (org-roam-dailies-calendar--file-to-date the-daily-node-filename)) (nth 0 org-agenda-current-date))
          (funcall (lambda ()
            (with-current-buffer (get-file-buffer the-daily-node-filename) (org-roam-tag-add '("old-todos")))
            (with-current-buffer (get-file-buffer the-daily-node-filename) (org-roam-tag-remove '("todos")))
            )
          )
        )
      )
    )
  )
)

(defun apply-old-todos-tag-maybe-and-save (FILE)
  (interactive)
  (find-file-noselect FILE)
  (apply-old-todos-tag-maybe FILE)
  (with-current-buffer (get-file-buffer the-daily-node-filename) (save-buffer))
  (with-current-buffer (get-file-buffer the-daily-node-filename) (kill-buffer))
)

(defun org-current-buffer-has-todos ()
  "Return non-nil if current buffer has any todo entry.

TODO entries marked as done are ignored, meaning the this
function returns nil if current buffer contains only completed
tasks."
  (org-element-map                          ; (2)
       (org-element-parse-buffer 'headline) ; (1)
       'headline
     (lambda (h)
       (eq (org-element-property :todo-type h)
           'todo))
     nil 'first-match))                     ; (3)

(defun org-has-recent-timestamps (OLD-DAYS)
  "Return non-nil only if current buffer has entries with timestamps
   more recent than OLD-DAYS days"
  (interactive)
  (if (org-element-map (org-element-parse-buffer) 'timestamp
    (lambda (h)
      (org-element-property :raw-value h)))
      (org-element-map                          ; (2)
         (org-element-parse-buffer) ; (1)
          'timestamp
         (lambda (h)
           (time-less-p (time-subtract (current-time) (* 60 60 24 OLD-DAYS)) (date-to-time (org-element-property :raw-value h))))
         nil 'first-match) nil))

(setq org-timestamps-days-for-old 21)

; This has a bug where it won't sync a new agenda file
; if I'm editing an org roam node file while set to another
; org roam db
(defun add-todos-tag-on-save-org-mode-file()
  (interactive)
  (when (string= (message "%s" major-mode) "org-mode")
    (if (org-roam-node-p (org-roam-node-at-point))
    (funcall (lambda()
      (if (or (org-current-buffer-has-todos) (org-has-recent-timestamps org-timestamps-days-for-old))
        (org-roam-tag-add '("todos"))
        (org-roam-tag-remove '("todos"))
      )
      (apply-old-todos-tag-maybe)
     )
    )
  )
 )
)

(add-hook 'before-save-hook 'add-todos-tag-on-save-org-mode-file)

(defun org-roam-filter-by-tag (tag-name)
  (lambda (node)
    (member tag-name (org-roam-node-tags node))))

(defun org-roam-list-notes-by-tag (tag-name)
  (mapcar #'org-roam-node-file
          (seq-filter
           (org-roam-filter-by-tag tag-name)
           (org-roam-node-list))))

(defun org-roam-dailies-apply-old-todos-tags-to-all ()
;  (dolist (daily-node org-roam-dailies-files)
;           (apply-old-todos-tag-maybe-and-save daily-node)
;  )
  (setq num 0)
  (while (< num (list-length (org-roam-list-notes-by-tag "todos")))
    (apply-old-todos-tag-maybe-and-save (nth num (org-roam-list-notes-by-tag "todos")))
  (setq num (1+ num))
  )
)

(defun org-roam-append-notes-to-agenda (tag-name db)
  (org-roam-switch-db db t)
;  (org-roam-dailies-apply-old-todos-tags-to-all)
  (setq org-agenda-files (append org-agenda-files (org-roam-list-notes-by-tag "todos")))
)

(defun org-roam-refresh-agenda-list ()
  (interactive)
  (setq prev-org-roam-db-choice org-roam-db-choice)
  (setq org-agenda-files '())
  (dolist (DB full-org-roam-db-list-pretty)
    (org-roam-append-notes-to-agenda "todos" DB)
  )
  (setq org-agenda-files (-uniq org-agenda-files))
  (org-roam-switch-db prev-org-roam-db-choice 1)
)

;; Build agenda for first time during this session
(org-roam-refresh-agenda-list)

(map! :leader
      :prefix ("o a")

      :desc "Refresh org agenda from roam dbs"
      "r" 'org-roam-refresh-agenda-list)

(map! :leader
      :prefix ("N" . "org-roam notes")

      :desc "Capture new roam node"
      "c" 'org-roam-capture

      :desc "Open org roam inbox"
      "I o" 'org-roam-open-inbox

      :desc "Capture stuff in inbox"
      "I c" 'org-roam-capture-inbox

      :desc "Insert roam node link at point"
      "i" 'org-roam-node-insert

      :desc "Find roam node"
      "." 'org-roam-node-find

      :desc "Switch org-roam database"
      "s" 'org-roam-switch-db

      :desc "Update current org-roam database"
      "u" 'org-roam-db-sync

      :desc "Re-zoom on current node in org-roam-ui"
      "z" 'org-roam-ui-node-zoom

      :desc "Visualize org-roam database with org-roam-ui"
      "O" 'org-roam-default-overview

      :desc "Visualize org-roam database with org-roam-ui"
      "o" 'org-roam-open-dashboard)

(after! org-roam
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?" :target
  (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
  :unnarrowed t))))

(setq olivetti-style 'fancy
      olivetti-margin-width 100)
(setq-default olivetti-body-width 100)
(defun org-roam-olivetti-mode ()
  (interactive)
  (if (org-roam-file-p)
      (olivetti-mode))
  (if (org-roam-file-p)
      (doom-disable-line-numbers-h)))

(add-hook 'org-mode-hook 'org-roam-olivetti-mode)

(add-load-path! "~/.emacs.d/org-nursery/lisp")
(require 'org-roam-dblocks)
(use-package org-roam-dblocks
  :hook (org-mode . org-roam-dblocks-autoupdate-mode))

(setq org-id-extra-files 'org-agenda-text-search-extra-files)

;(add-to-list 'display-buffer-alist '("^\\ORUI" display-buffer-in-side-window
;                                    '(side . right)
;                                    (window-width . 50)
;))
;(add-to-list 'display-buffer-alist '("^\\localhost:35901" display-buffer-in-side-window
;                                    '(side . right)
;                                    (window-width . 50)
;))

;;(setq org-roam-ui-browser-function 'eaf-open-browser) ; xorg
(setq org-roam-ui-browser-function 'browse-url) ; wayland

(defun open-org-roam-ui ()
  (interactive)
  (+evil/window-vsplit-and-follow)
  (org-roam-ui-open)
  (evil-window-left 1))

(defun kill-org-roam-ui ()
  (interactive)
;;  (delete-window (get-buffer-window "ORUI" t)) ; xorg
;;  (kill-buffer "ORUI") ; xorg
  (kill-buffer "*httpd*")
)

; xorg
;;(map! :leader
;;      :prefix ("N" . "org-roam notes")
;;      :desc "Visualize org-roam database with org-roam-ui"
;;      "v" 'open-org-roam-ui)

; wayland
(map! :leader
      :prefix ("N" . "org-roam notes")
      :desc "Visualize org-roam database with org-roam-ui"
      "v" 'org-roam-ui-open)

(map! :leader
      :prefix ("N" . "org-roam notes")
      :desc "Kill all org roam ui buffers"
      "V" 'kill-org-roam-ui)

;;;------ Org agenda configuration ------;;;

;; Set span for agenda to be just daily
(setq org-agenda-span 1
      org-agenda-start-day "+0d"
      org-agenda-skip-timestamp-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-scheduled-if-deadline-is-shown t
      org-agenda-skip-timestamp-if-deadline-is-shown t)

;; Custom styles for dates in agenda
(custom-set-faces!
  '(org-agenda-date :inherit outline-1 :height 1.15)
  '(org-agenda-date-today :inherit diary :height 1.15)
  '(org-agenda-date-weekend :ineherit outline-2 :height  1.15)
  '(org-agenda-date-weekend-today :inherit outline-4 :height 1.15)
  '(org-super-agenda-header :inherit custom-button :weight bold :height 1.05)
  )


;; Toggle completed entries function
(defun org-agenda-toggle-completed ()
  (interactive)
  (setq org-agenda-skip-timestamp-if-done (not org-agenda-skip-timestamp-if-done)
        org-agenda-skip-deadline-if-done (not org-agenda-skip-timestamp-if-done)
        org-agenda-skip-scheduled-if-done (not org-agenda-skip-timestamp-if-done))
  (org-agenda-redo))

(map!
  :map evil-org-agenda-mode-map
  :after org-agenda
  :nvmeg "s d" #'org-agenda-toggle-completed)

;; Ricing org agenda
(setq org-agenda-current-time-string "")
(setq org-agenda-time-grid '((daily) () "" ""))

(setq org-agenda-prefix-format '(
(agenda . "  %?-2i %t ")
 (todo . " %i %-12:c")
 (tags . " %i %-12:c")
 (search . " %i %-12:c")))

(setq org-agenda-hide-tags-regexp ".*")

(setq org-agenda-category-icon-alist
      `(("Teaching.p" ,(list (all-the-icons-faicon "graduation-cap" :height 0.8)) nil nil :ascent center)
        ("Family.s" ,(list (all-the-icons-faicon "home" :v-adjust 0.005)) nil nil :ascent center)
        ("Producer.p" ,(list (all-the-icons-faicon "youtube-play" :height 0.9)) nil nil :ascent center)
        ("Bard.p" ,(list (all-the-icons-faicon "music" :height 0.9)) nil nil :ascent center)
        ("Stories.s" ,(list (all-the-icons-faicon "book" :height 0.9)) nil nil :ascent center)
        ("Author.p" ,(list (all-the-icons-faicon "pencil" :height 0.9)) nil nil :ascent center)
        ("Gamedev.s" ,(list (all-the-icons-faicon "gamepad" :height 0.9)) nil nil :ascent center)
        ("Knowledge.p" ,(list (all-the-icons-faicon "database" :height 0.8)) nil nil :ascent center)
        ("Personal.p" ,(list (all-the-icons-material "person" :height 0.9)) nil nil :ascent center)
))

(defun org-categorize-by-roam-db-on-save ()
  (interactive)
  (when (string= (message "%s" major-mode) "org-mode")
    (when
      (string-prefix-p (concat "/home/" user-username "/Org") (expand-file-name (buffer-file-name)))
      (setq categorizer-old-line (line-number-at-pos))
      (evil-goto-first-line)
      (org-set-property "CATEGORY" (substring (string-trim-left (expand-file-name (buffer-file-name)) (concat "/home/" user-username "/Org/")) 0 (string-match "/" (string-trim-left (expand-file-name (buffer-file-name)) (concat "/home/" user-username "/Org/")))))
      (evil-goto-line categorizer-old-line)
    )
  )
)

(add-hook 'after-save-hook 'org-categorize-by-roam-db-on-save)

;; Function to be run when org-agenda is opened
(defun org-agenda-open-hook ()
  "Hook to be run when org-agenda is opened"
  (olivetti-mode))

;; Adds hook to org agenda mode, making follow mode active in org agenda
(add-hook 'org-agenda-mode-hook 'org-agenda-open-hook)

;; Easy refreshes on org agenda for syncthing file changes
;; adapted from https://www.reddit.com/r/orgmode/comments/mu6n5b/org_agenda_auto_updating/
;; and https://lists.gnu.org/archive/html/help-gnu-emacs/2008-12/msg00435.html
(defadvice org-agenda-list (before refresh-org-agenda-on-revert activate)
  (mapc (lambda (file)
          (unless (verify-visited-file-modtime (get-file-buffer file))
          (with-current-buffer (get-file-buffer file)
            (when (eq major-mode 'org-mode)
              (revert-buffer nil 'noconfirm)))))
        (org-agenda-files)))
(defadvice org-agenda-redo (before refresh-org-agenda-on-revert activate)
  (mapc (lambda (file)
          (unless (verify-visited-file-modtime (get-file-buffer file))
          (with-current-buffer (get-file-buffer file)
            (when (eq major-mode 'org-mode)
              (revert-buffer nil 'noconfirm)))))
        (org-agenda-files)))
(defadvice org-agenda-redo-all (before refresh-org-agenda-on-revert activate)
  (mapc (lambda (file)
          (unless (verify-visited-file-modtime (get-file-buffer file))
          (with-current-buffer (get-file-buffer file)
            (when (eq major-mode 'org-mode)
              (revert-buffer nil 'noconfirm)))))
        (org-agenda-files)))

;; Function to list all my available org agenda files and switch to them
(defun list-and-switch-to-agenda-file ()
  "Lists all available agenda files and switches to desired one"
  (interactive)
  (setq full-agenda-file-list nil)
  (setq choice (completing-read "Select agenda file:" org-agenda-files nil t))
  (find-file choice))

(map! :leader
      :desc "Switch to specific org agenda file"
      "o a s" 'list-and-switch-to-agenda-file)

(defun org-agenda-switch-with-roam ()
  "Switches to org roam node file and database from org agenda view"
  (interactive)
  (org-agenda-switch-to)
  (if (f-exists-p (concat (dir!) "/org-roam.db"))
    (org-roam-switch-db (replace-regexp-in-string (concat "\\/home\\/" user-username "\\/Org\\/") "" (f-parent (dir!))) t))
  (if (f-exists-p (concat (f-parent (dir!)) "/org-roam.db"))
    (org-roam-switch-db (replace-regexp-in-string (concat "\\/home\\/" user-username "\\/Org\\/") "" (f-parent (f-parent (dir!)))) t))
  (org-roam-olivetti-mode)
)

(map!
  :map evil-org-agenda-mode-map
  :after org-agenda
  :nvmeg "<RET>" #'org-agenda-switch-with-roam
  :nvmeg "<return>" #'org-agenda-switch-with-roam)
(map!
  :map org-agenda-mode-map
  :after org-agenda
  :nvmeg "<RET>" #'org-agenda-switch-with-roam
  :nvmeg "<return>" #'org-agenda-switch-with-roam)

(require 'org-super-agenda)

(setq org-super-agenda-groups
       '(;; Each group has an implicit boolean OR operator between its selectors.
         (:name " Overdue "  ; Optionally specify section name
                :scheduled past
                :order 2
                :face 'error)

         (:name "Personal "
                :and(:file-path "Personal.p" :not (:tag "event"))
                :order 3)

         (:name "Family "
                :and(:file-path "Family.s" :not (:tag "event"))
                :order 3)

         (:name "Teaching "
                :and(:file-path "Teaching.p" :not (:tag "event"))
                :order 3)

         (:name "Gamedev "
                :and(:file-path "Gamedev.s" :not (:tag "event"))
                :order 3)

         (:name "Youtube "
                :and(:file-path "Producer.p" :not (:tag "event"))
                :order 3)

         (:name "Music "
                :and(:file-path "Bard.p" :not (:tag "event"))
                :order 3)

         (:name "Storywriting "
                :and(:file-path "Stories.s" :not (:tag "event"))
                :order 3)

         (:name "Writing "
                :and(:file-path "Author.p" :not (:tag "event"))
                :order 3)

         (:name "Learning "
                :and(:file-path "Knowledge.p" :not (:tag "event"))
                :order 3)

          (:name " Today "  ; Optionally specify section name
                :time-grid t
                :date today
                :scheduled today
                :order 1
                :face 'warning)

))

(org-super-agenda-mode t)

(map! :desc "Next line"
      :map org-super-agenda-header-map
      "j" 'org-agenda-next-line)

(map! :desc "Next line"
      :map org-super-agenda-header-map
      "k" 'org-agenda-previous-line)

(add-load-path! "~/.emacs.d/org-yaap")
(require 'org-yaap)
(setq org-yaap-alert-title "Org Agenda")
(setq org-yaap-overdue-alerts 20)
(setq org-yaap-alert-before 20)
(setq org-yaap-daily-alert '(7 30))
(setq org-yaap-daemon-idle-time 30)
(org-yaap-mode 1)

(add-load-path! "~/.emacs.d/org-timeblock")
(require 'org-timeblock)

(map! :leader :desc "Open org timeblock"
      "O c" 'org-timeblock)

(map! :desc "Next day"
      :map org-timeblock-mode-map
      :nvmeg "l" 'org-timeblock-day-later)
(map! :desc "Previous day"
      :map org-timeblock-mode-map
      :nvmeg "h" 'org-timeblock-day-earlier)
(map! :desc "Schedule event"
      :map org-timeblock-mode-map
      :nvmeg "m" 'org-timeblock-schedule)
(map! :desc "Event duration"
      :map org-timeblock-mode-map
      :nvmeg "d" 'org-timeblock-set-duration)

;;;------ magit configuration ------;;;
;; Need the following two blocks to make magit work with git bare repos
(defun ~/magit-process-environment (env)
  "Add GIT_DIR and GIT_WORK_TREE to ENV when in a special directory.
https://github.com/magit/magit/issues/460 (@cpitclaudel)."
  (let ((default (file-name-as-directory (expand-file-name default-directory)))
        (home (expand-file-name "~/")))
    (when (string= default home)
      (let ((gitdir (expand-file-name "~/.dotfiles.git/")))
        (push (format "GIT_WORK_TREE=%s" home) env)
        (push (format "GIT_DIR=%s" gitdir) env))))
  env)

(advice-add 'magit-process-environment
            :filter-return #'~/magit-process-environment)

(require 'magit-todos)
(magit-todos-mode 1)

(evil-set-initial-state 'ibuffer-mode 'motion)
(evil-define-key 'motion 'ibuffer-mode
  "j" 'evil-next-visual-line
  "k" 'evil-previous-visual-line
  "d" 'ibuffer-mark-for-delete
  "q" 'kill-buffer
  (kbd "<return>") 'ibuffer-visit-buffer)

;;;------ dired configuration ------;;;

(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(map! :desc "Increase font size"
      "C-=" 'text-scale-increase

      :desc "Decrease font size"
      "C--" 'text-scale-decrease)

;;;------ ranger configuration ------;;;

(map! :map ranger-mode-map
      :desc "Mark current file"
      "m" 'ranger-mark

      :desc "Toggle mark on current file"
      "x" 'ranger-toggle-mark

      :desc "Open ranger"
      "o d" 'ranger)

;;;-- hledger-mode configuration ;;;--

;;; Basic configuration
(require 'hledger-mode)

;; To open files with .journal extension in hledger-mode
(add-to-list 'auto-mode-alist '("\\.journal\\'" . hledger-mode))

;; The default journal location is too opinionated.
(setq hledger-jfile (concat user-home-directory "/Org/Family.s/Notes/hledger.journal"))

;;; Auto-completion for account names
;; For company-mode users:
(add-to-list 'company-backends 'hledger-company)

(evil-define-key* 'normal hledger-view-mode-map "q" 'kill-current-buffer)
(evil-define-key* 'normal hledger-view-mode-map "[" 'hledger-prev-report)
(evil-define-key* 'normal hledger-view-mode-map "]" 'hledger-next-report)

(map! :leader
      :prefix ("l" . "hledger")
      :desc "Exec hledger command"
      "c" 'hledger-run-command

      :desc "Generate hledger balancesheet"
      "b" 'hledger-balancesheet*

      :desc "Exec hledger command"
      "d" 'hledger-daily-report*)

(map! :localleader
      :map hledger-mode-map

      :desc "Reschedule transaction at point"
      "d s" 'hledger-reschedule

      :desc "Edit amount at point"
      "t a" 'hledger-edit-amount)

(require 'focus)

(map! :leader
      :prefix ("F" . "Focus mode")
      :desc "Toggle focus mode"
      "t" 'focus-mode

      :desc "Pin focused section"
      "p" 'focus-pin

      :desc "Unpin focused section"
      "u" 'focus-unpin)

(add-to-list 'focus-mode-to-thing '(org-mode . org-element))
(add-to-list 'focus-mode-to-thing '(python-mode . paragraph))
(add-to-list 'focus-mode-to-thing '(lisp-mode . paragraph))

;(add-hook 'org-mode-hook #'focus-mode)

;;;------ helpful configuration ------;;;

(evil-set-initial-state 'helpful-mode 'normal)
(evil-define-key 'normal helpful-mode-map
  "j" 'evil-next-visual-line
  "k" 'evil-previous-visual-line
  "q" 'helpful-kill-buffers)

;;;-- Load emacs direnv;;;--
(require 'direnv)
(direnv-mode)

;;;-- projectile wrapper commands ;;;--
(defun projectile-goto-project ()
  (interactive)
  (projectile-switch-project t)
  ;;(neotree-dir (projectile-project-root))
)

(map! :leader
      :desc "Open project"
      "p p" #'projectile-goto-project)
(map! :leader
      :desc "Projectile commander"
      "p @" #'projectile-commander)
(map! :leader
      :desc "Projectile grep"
      "/" #'projectile-grep)

;;;-- LSP stuff ;;;--
(use-package lsp-mode
  :ensure t)

(use-package nix-mode
  :hook (nix-mode . lsp-deferred)
  :ensure t)

(setq lsp-java-workspace-dir (concat user-home-directory "/.local/share/doom/java-workspace"))

(require 'gdscript-mode)
(use-package gdscript-mode
  :hook (gdscript-mode . lsp-deferred)
  :ensure t)

(setq lsp-treemacs-deps-position-params
  '((side . right)
   (slot . 1)
   (window-width . 35)))

(setq lsp-treemacs-symbols-position-params
'((side . right)
 (slot . 2)
 (window-width . 35)))

(map! :leader :desc "Open treemacs symbol outliner" "o s" #'lsp-treemacs-symbols
              :desc "Hide neotree" "o S" #'treemacs-quit)

(setq +format-on-save-enabled-modes '(not emacs-lisp-mode sql-mode tex-mode latex-mode org-msg-edit-mode nix-mode))



;; I source my rss from my freshrss instance
;; I login with a private elisp file: ~/.emacs.d/freshrss-elfeed.el
;; freshrss-elfeed.el looks like this:
;;(elfeed-protocol-enable)
;;(setq elfeed-use-curl t)
;;(setq elfeed-set-timeout 36000)
;;(setq elfeed-log-level 'debug)
;;(setq freshrss-hostname "https://freshrss.example.com")
;;(setq elfeed-feeds (list
;;                    (list "fever+https://user@freshrss.example.com"
;;                      :api-url "https://user@freshrss.example.com/api/fever.php"
;;                      :password "mYsUpErCoMpLiCaTeDp@s$w0rD"))))
;;(setq main-elfeed-feed "https://user@freshrss.example.com/api/fever.php")

(if (file-exists-p "~/.emacs.d/freshrss-elfeed.el") (load! "~/.emacs.d/freshrss-elfeed.el"))
(setq elfeed-search-filter "@6-months-ago +unread")
(setq browse-url-chromium-program "mpv")
(setq browse-url-chrome-program "mpv")
(setq browse-url-handlers '(("youtube.com" . browse-url-chrome)
                            ("odcyn.com" . browse-url-chrome)
                            ("odysee.com" . browse-url-chrome)
                            ("tilvids.com" . browse-url-chrome)))
(map! :leader :desc "Open elfeed" "O n" #'elfeed)
(map! :map 'elfeed-search-mode-map :desc "Open url" :n "g o" #'elfeed-search-browse-url)

(defun freshrss-network-connection-p ()
  (not (condition-case nil
        (delete-process
         (make-network-process
          :name freshrss-hostname
          :host "elpa.gnu.org"
          :service 443))
      (error t))))

(defun elfeed-full-update ()
  (interactive)
  (if (freshrss-network-connection-p) (delete-directory "~/.cache/doom/elfeed" t))
  (setq elfeed-db nil)
  (elfeed-protocol-fever-update main-elfeed-feed)
  (elfeed-update))
(map! :map 'elfeed-search-mode-map :desc "Update elfeed" :n "g R" #'elfeed-full-update)
