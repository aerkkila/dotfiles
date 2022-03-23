(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes '(tango-dark))
 '(inhibit-startup-screen t)
 '(package-selected-packages '(ggtags yasnippet auto-complete xclip)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(global-visual-line-mode 1)
(global-linum-mode 1)
(electric-indent-mode 1)
;(xclip-mode 1) ;asenna xclip
(tool-bar-mode 0)
(menu-bar-mode 0)
(show-paren-mode 1)

(global-company-mode 1) ;asenna company
(setq company-idle-delay 0.1)
(defun company-c-headers-setup ()
  (add-to-list 'company-backends 'company-c-headers))
(delete 'company-clang company-backends)
;(semantic-mode 1)

(ggtags-mode 1) ; asenna ggtags
(global-set-key (kbd "C-M-o") 'ggtags-find-tag-dwim)

;(require 'auto-complete) ;asenna auto-complete, onnistuu package-archives-jutusta
;(require 'auto-complete-config)
;(ac-config-default)
;(global-auto-complete-mode 1)
;(require 'yasnippet) ;asenna yasnippet
;(yas-global-mode 1)
;(semantic-mode 1)
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
(add-to-list 'default-frame-alist '(foreground-color . "#FFFFFF"))
(add-to-list 'default-frame-alist '(height . 73))
(add-to-list 'default-frame-alist '(width . 100))

(add-hook 'after-save-hook
  'executable-make-buffer-file-executable-if-script-p)

 ;; Forces the messages to 0, and kills the *Messages* buffer - thus disabling it on startup.
(setq-default message-log-max nil)
(kill-buffer "*Messages*")

(setq initial-scratch-message nil)

(setq
   backup-by-copying t      ; don't clobber symlinks, ei riko kovia linkkejä
   backup-directory-alist
    '(("." . "~/emacstallenteet/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 5
   kept-old-versions 2
   version-control t)       ; use versioned backups
