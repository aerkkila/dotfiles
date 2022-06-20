(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes '(tango-dark))
 '(inhibit-startup-screen t)
 '(package-selected-packages '(ggtags auto-complete xclip)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'load-path "~/.emacs.d/lisp/")
(package-initialize)

(global-visual-line-mode 1)
(global-linum-mode 1)
(electric-indent-mode 1)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(show-paren-mode 1)
(setq show-paren-delay 0.1)

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(global-company-mode 1) ;asenna company
(setq company-idle-delay 0.1)
(defun company-c-headers-setup ()
  (add-to-list 'company-backends 'company-c-headers))
(delete 'company-clang company-backends)

(require 'iedit) ;asenna iedit
(ggtags-mode 1) ; asenna ggtags
(global-set-key (kbd "C-M-o") 'ggtags-find-tag-dwim)

;(require 'auto-complete) ;asenna auto-complete, onnistuu package-archives-jutusta
;(require 'auto-complete-config)
;(ac-config-default)
;(global-auto-complete-mode 1)
;(semantic-mode 1) ; tällä saisi täydennyksen toimimaan myös #include-tiedostoista, mutta aiheuttaa viivettä
;(defun my:add-semantic-to-autocomplete()
;  (add-to-list 'ac-sources 'ac-source-semantic)
;  )
;(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

;;vim-tyyliset liikunnat alt-näppäimellä das-fi-näppäimistönasettelulle
(global-set-key (kbd "M-g") 'backward-char)
(global-set-key (kbd "M-o") 'forward-char)
(global-set-key (kbd "M-a") 'next-line)
(global-set-key (kbd "M-i") 'previous-line)
(global-set-key (kbd "C-x a") 'scroll-up-line)
(global-set-key (kbd "C-x i") 'scroll-down-line)

;;vim-tyyliset liikunnat venäläiselle oletusnäppäimistönasettelulle
;;Alt-näppäin luetaan venäläisestä, mutta kontrol järjestelmän oletusasettelusta
(global-set-key (kbd "M-р") 'backward-char)
(global-set-key (kbd "M-д") 'forward-char)
(global-set-key (kbd "M-о") 'next-line)
(global-set-key (kbd "M-л") 'previous-line)
(global-set-key (kbd "C-x о") 'scroll-up-line)
(global-set-key (kbd "C-x л") 'scroll-down-line)
(global-set-key (kbd "C-x ъ") 'repeat)

(global-set-key (kbd "M-e") 'dabbrev-completion)

(set-frame-font "Liberation Mono 12" nil t)
(set-fontset-font t 'symbol "Noto Color Emoji")
(set-default 'cursor-type 'bar)

(if (display-graphic-p)
    (progn
      (setq default-frame-alist
	    '(
	      (tool-bar-lines . 0)
	      (left . 1000)
	      (top . 0 )))
      (set-background-color "#000000"))
  (set-face-background 'default "undefined")
  (setq linum-format "%d\u2502 "))
;(add-to-list 'default-frame-alist '(foreground-color . "#FFFFFF"))
;(add-to-list 'default-frame-alist '(height . 73))
;(add-to-list 'default-frame-alist '(width . 100))

(add-hook 'after-save-hook
  'executable-make-buffer-file-executable-if-script-p)

(setq initial-scratch-message nil)
(setq-default message-log-max nil)
(kill-buffer "*Messages*")

(setq
   backup-by-copying t      ; ei riko kovia linkkejä eikä symbolisia
   backup-directory-alist
    '(("." . "~/emacstallenteet/"))
   delete-old-versions t
   kept-new-versions 5
   kept-old-versions 2
   version-control t)

(defun revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive)
    (revert-buffer :ignore-auto :noconfirm))

(global-set-key (kbd "C-M-r") 'revert-buffer-no-confirm)
(add-hook 'csv-mode-hook 'csv-align-mode)

(setq c-default-style "stroustrup")
