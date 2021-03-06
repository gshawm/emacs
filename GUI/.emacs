;;;;;;;;;;;;;;;;;;;;;; Package Handling ;;;;;;;;;;;;;;;;;;;;;;
(when (>= emacs-major-version 24)
  (require 'package)
  ;; ELPA is automatically added.
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("marmalade" . "http://stable.melpa.org/packages/") t)
  (package-initialize)
  (package-refresh-contents)
  )

;;;;;;;;;;;;;;;;;;;;;; Emacs Server ;;;;;;;;;;;;;;;;;;;;;;
;; The emacs server should be started on startup. (i.e. emacs --daemon)
(desktop-save-mode 1)
(defun save-desktop ()
  (desktop-save)
  )
(add-hook 'server-done-hook 'save-desktop)
(setq initial-scratch-message nil)
(setq frame-title-format (list "%b - " (getenv "USERNAME") "@" (getenv "USERDOMAIN")))

(defun new-empty-buffer ()
  "Create a new empty buffer.
   New buffer will be named “untitled” or “untitled<2>”, “untitled<3>”, etc."
  (interactive)
  (let ((buffer (generate-new-buffer "untitled")))
    (set-buffer-major-mode buffer)
    (switch-to-buffer buffer)
    (setq buffer-offer-save t)))
(global-set-key (kbd "<f7>") 'new-empty-buffer)

(if (string= "windows-nt" system-type)
    (add-to-list 'exec-path "C:/Program Files (x86)/Aspell/bin")
  )

;;;;;;;;;;;;;;;;;;;;;; Custom Variables ;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-alist nil)
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(confirm-kill-emacs (quote y-or-n-p))
 '(custom-safe-themes
   (quote
    ("a632c5ce9bd5bcdbb7e22bf278d802711074413fd5f681f39f21d340064ff292" "c4d3da0593914fff8fd2fbea89452f1a767893c578b219e352c763680d278762" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "90e4b4a339776e635a78d398118cb782c87810cb384f1d1223da82b612338046" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(display-time-mode t)
 '(global-hl-line-mode 1)
 '(inhibit-startup-screen t)
 '(ispell-dictionary "american")
 '(ispell-program-name "aspell")
 '(linum-format " %6d ")
 '(menu-bar-mode nil)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount (quote (1)))
 '(package-selected-packages
   (quote
    (company switch-window cycbuf seti-theme solarized-theme auto-complete-c-headers nlinum tabbar nav lua-mode magit yasnippet auto-complete smart-mode-line-powerline-theme smart-mode-line)))
 '(scroll-bar-mode nil)
 '(scroll-conservatively 101)
 '(show-trailing-whitespace t)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(undo-limit 20000000)
 '(undo-strong-limit 40000000)
 '(visible-cursor t))

;;;;;;;;;;;;;;;;;;;;;; Custom Faces  ;;;;;;;;;;;;;;;;;;;;;;
;; TODO(Grant): Have a different one to define term mode
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#151718" :foreground "#D4D7D6" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 96 :width normal :foundry "outline" :family "Liberation Mono"))))
 '(cursor ((t (:background "orange"))))
 '(highlight ((t (:background "firebrick4" :foreground nil :bold t)))))

(setq fixme-modes '(c++-mode c-mode emacs-lisp-mode python-mode lua-mode))
(make-face 'font-lock-fixme-face)
(make-face 'font-lock-study-face)
(make-face 'font-lock-important-face)
(make-face 'font-lock-note-face)
(mapc (lambda (mode)
	(font-lock-add-keywords
	 mode
	 '(("\\<\\(TODO\\)" 1 'font-lock-fixme-face t)
	   ("\\<\\(STUDY\\)" 1 'font-lock-study-face t)
	   ("\\<\\(IMPORTANT\\)" 1 'font-lock-important-face t)
	   ("\\<\\(NOTE\\)" 1 'font-lock-note-face t))))
      fixme-modes)
(modify-face 'font-lock-fixme-face "Red" nil nil t nil t nil nil)
(modify-face 'font-lock-study-face "Yellow" nil nil t nil t nil nil)
(modify-face 'font-lock-important-face "Yellow" nil nil t nil t nil nil)
(modify-face 'font-lock-note-face "Dark Green" nil nil t nil t nil nil)

;;;;;;;;;;;;;;;;;;;;;; Packages Setup ;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "<f5>") 'revert-buffer)
(defun reload-dotemacs ()
  (interactive)
  (load-file "~/.emacs"))
(global-set-key (kbd "M-<f5>") 'reload-dotemacs)
(global-set-key (kbd "C-x M-d") 'make-directory)
(global-set-key (kbd "C-x M-f") 'delete-directory)

(setq gdb-many-windows t)
(setq gdb-show-main t)

;;;; whitespace ;;;;
(require 'whitespace)

(setq-default indent-tabs-mode nil)

;;;; fill-column-indicator ;;;;
(if (not (package-installed-p 'fill-column-indicator))
    (package-install 'fill-column-indicator))
(require 'fill-column-indicator)
(setq fci-rule-column 80)
(setq fci-rule-color "green")
(setq fci-rule-use-dashes 1)
(setq fci-rule-width 50)

;;;; switch-window ;;;;
(if (not (package-installed-p 'switch-window))
    (package-install 'switch-window))
(global-set-key (kbd "C-x o") 'switch-window)

;;;; undo-tree ;;;;
(if (not (package-installed-p 'undo-tree))
    (package-install 'undo-tree))
(global-undo-tree-mode)

;;;; docview ;;;;
(setq doc-view-continuous 1)

;;;; cycbuf ;;;;
(if (not (package-installed-p 'cycbuf))
    (package-install 'cycbuf))

(global-set-key (kbd "C-'") 'cycbuf-switch-to-next-buffer)
(global-set-key (kbd "C-\"") 'cycbuf-switch-to-previous-buffer)

;;;; helm ;;;;
(if (not (package-installed-p 'helm))
    (package-install 'helm))
(require 'helm)
(require 'helm-config)

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c h o") 'helm-occur)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(if (not (package-installed-p 'helm-gtags))
    (package-install 'helm-gtags))

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line        t
      helm-buffers-fuzzy-matching           t
      helm-recentf-fuzzy-match              t
      helm-M-x-fuzzy-match                  t)

(defun spacemacs//helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))

(add-hook 'helm-minibuffer-set-up-hook
          'spacemacs//helm-hide-minibuffer-maybe)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)
(helm-mode 1)

;;;; multiple-cursors ;;;;
(if (not (package-installed-p 'multiple-cursors))
    (package-install 'multiple-cursors))
(global-set-key (kbd "C-}") 'mc/mark-next-like-this)

(global-set-key (kbd "C-{") 'mc/mark-previous-like-this)

;;;; sr-speedbar ;;;;
(if (not (package-installed-p 'sr-speedbar))
    (package-install 'sr-speedbar))
(require 'sr-speedbar)
(setq speedbar-show-unknown-files 1)
(global-set-key (kbd "C-c TAB") 'sr-speedbar-toggle)

;;;; flyspell ;;;;
(defun add-flyspell ()
  (flyspell-mode)
  )
(add-hook 'text-mode-hook 'add-flyspell)
(global-set-key (kbd "<f12>") 'flyspell-auto-correct-word)

;;;; lua ;;;;
(if (not (package-installed-p 'lua-mode))
    (package-install 'lua-mode))

;;;; ido ;;;;
(require 'ido)
(ido-mode t)

;;;; sml ;;;;
(if (not (package-installed-p 'smart-mode-line))
    (package-install 'smart-mode-line))
(if (not (package-installed-p 'smart-mode-line-powerline-theme))
    (package-install 'smart-mode-line-powerline-theme))
(require 'smart-mode-line-powerline-theme)
(sml/setup)
(setq powerline-default-separator 'wave)

;;;; company ;;;;
(if (not (package-installed-p 'company))
    (package-install 'company))

;;;; linum ;;;;
(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (goto-line (read-number "Goto line: ")))
    (linum-mode -1)))
(global-set-key [remap goto-line] 'goto-line-with-feedback)

;;;; auto-complete ;;;;
(if (not (package-installed-p 'auto-complete))
    (package-install 'auto-complete))
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)

;;;; auto-complete-c-headers ;;;;
(if (not (package-installed-p 'auto-complete-c-headers))
    (package-install 'auto-complete-c-headers))
(defun start-ac-c-headers ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  )
(add-hook 'c++-mode-hook 'start-ac-c-headers)
(add-hook 'c-mode-hook 'start-ac-c-headers)

;;;; c ;;;;
(setq c-default-style "linux" c-basic-offset 4)

;;;;;;;;;;;;;;;;;;;;;; Full-Screen Mode ;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(define-key global-map (kbd "M-RET") 'toggle-frame-fullscreen)

;;;;;;;;;;;;;;;;;;;;;; TEMP File Handling ;;;;;;;;;;;;;;;;;;;;;;
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(let ((week (* 60 60 24 7))
      (current (float-time (current-time))))
  (message "Deleting old backup files...")
  (dolist (file (directory-files temporary-file-directory t))
    (when (and (backup-file-name-p file)
               (> (- current (float-time (nth 5 (file-attributes file))))
                  week))
      (message "%s" file)
      (delete-file file))))

;;;;;;;;;;;;;;;;;;;;;; Session Saving ;;;;;;;;;;;;;;;;;;;;;;
(setq desktop-load-locked-desktop t)
(setq desktop-restore-frames nil)

(defvar emacs-configuration-directory
    "~/.emacs.d/"
    "The directory where the emacs configuration files are stored.")

;;(require 'compile)
;;(require 'cc-mode)
;;(require 'flymake-jslint)

;;(add-hook 'js-mode-hook 'js2-minor-mode)
;;(add-hook 'js2-mode-hook 'ac-js2-mode)
;;(autoload 'js3-mode "js3" nil t)
;;(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))
;;'(js3-auto-indent-p t)         ; it's nice for commas to right themselves.
;;'(js3-enter-indents-newline t) ; don't need to push tab before typing
;;'(js3-indent-on-enter-key t)   ; fix indenting before moving on
;;(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;;(add-hook 'js2-mode-hook 'flymake-jslint-load)
;;(add-hook 'js2-mode-hook 'ac-js2-mode)
;;(add-hook 'css-mode-hook 'skewer-css-mode)
;;(add-hook 'html-mode-hook 'skewer-html-mode)

;;;; after-init-hook ;;;;
;;(add-hook 'after-init-hook #'global-flycheck-mode)

;;(defun swap-delete-keys ()
;;(global-unset-key (kbd "C-DEL"))
;;(global-unset-key (kbd "M-^")))
;;(global-set-key (kbd "C-DEL") 'delete-indentation))
;;(global-set-key (kbd "M-^") 'backward-kill-word))
;;(add-hook 'window-setup-hook 'swap-delete-keys)

;;(eval-after-load 'js2-mode
;;  '(add-hook 'js2-mode-hook
;;	     (lambda ()
;;	       (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

;;(eval-after-load 'json-mode
;;  '(add-hook 'json-mode-hook
;;	     (lambda ()
;;	       (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

;;(eval-after-load 'sgml-mode
;;  '(add-hook 'html-mode-hook
;;	     (lambda ()
;;	       (add-hook 'before-save-hook 'web-beautify-html-buffer t t))))

;;(eval-after-load 'css-mode
;;  '(add-hook 'css-mode-hook
;;	     (lambda ()
;;	       (add-hook 'before-save-hook 'web-beautify-css-buffer t t))))

;; TODO(GRANT): Figure out how to manage these guys
;; (setq todo-file "./todo.txt")
;; (setq log-file "./log.txt")

;;(defun load-todo ()
;;  (interactive)
;;  (find-file todo-file))
;;(define-key global-map "\et" 'load-todo)

;;(defun load-log ()
;;  (interactive)
;;  (find-file log-file)
;;  (if (boundp 'longlines-mode) ()
;;    (longlines-mode 1)
;;    (longlines-show-hard-newlines))
;;  (if (equal longlines-mode t) ()
;;    (longlines-mode 1)
;;    (longlines-show-hard-newlines))
;;  (end-of-buffer)
;;  (newline-and-indent)
;;  (insert-timeofday)
;;  (newline-and-indent)
;;  (newline-and-indent)
;;  (end-of-buffer))
;;(define-key global-map (kbd "M-T") 'load-log)

;;(define-key global-map (kbd "M-p") 'quick-calc)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; COMPILING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq compilation-directory-locked nil)

;;(defun find-project-directory-recursive ()
;;  "Recursively search for a makefile."
;;  (interactive)
;;  (if (file-exists-p "build.bat") t
;;      (cd "../")
;;      (find-project-directory-recursive)))

;;(defun lock-compilation-directory ()
;;  "The compilation process should NOT hunt for a makefile"
;;  (interactive)
;;  (setq compilation-directory-locked t)
;;  (message "Compilation directory is locked."))

;;(defun unlock-compilation-directory ()
;;  "The compilation process SHOULD hunt for a makefile"
;;  (interactive)
;;  (setq compilation-directory-locked nil)
;;  (message "Compilation directory is roaming."))

;;(defun find-project-directory ()
;;  "Find the project directory."
;;  (interactive)
;;  (setq find-project-from-directory default-directory)
;;  (switch-to-buffer-other-window "*compilation*")
;;  (if compilation-directory-locked (cd last-compilation-directory)
;;  (cd find-project-from-directory)
;;  (find-project-directory-recursive)
;;  (setq last-compilation-directory default-directory)))

;; Make the current build
;;(defun make-without-asking ()
;;  "Make the current build."
;;  (interactive)
;;  (if (find-project-directory) (compile "build.bat"))
;;  (other-window 1))
;;(define-key global-map (kbd "M-m") 'make-without-asking)

;; Window Commands
;;(defun w32-restore-frame ()
;;  "Restore a minimized frame"
;;  (interactive)
;;  (w32-send-sys-command 61728))

;;(defun maximize-frame ()
;;  "Maximize the current frame"
;;  (interactive)
;;  (w32-send-sys-command 61488))


