;;;  auto-complete 设置
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(ac-config-default)

;;; 
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
(put 'upcase-region 'disabled nil)
;;cedet
;;(add-to-list 'load-path "/usr/share/emacs/site-lisp/cedet/common")
;;(load-file "/usr/share/emacs/site-lisp/cedet/common/cedet.elc")
;;(global-ede-mode 1)
;;(semantic-load-enable-code-helpers)

(defun quick-compile ()
  "A quick compile function for C++"
  (interactive)
  (compile (concat "g++ " (buffer-name (current-buffer))" -g -pg"))
)
;;快捷键F9
(global-set-key [(f9)] 'compile)

;;;; CC-mode配置
(require 'cc-mode)
(c-set-offset 'inline-open 0)
(c-set-offset 'friend '-)
(c-set-offset 'substatement-open 0)

;; -*- Emacs-Lisp -*-
 
;; Time-stamp: <2010-04-09 10:22:51 Friday by ahei>
 

(c-add-style "qt-gnu" '("gnu"
			(c-access-key .
"\\<\\(signals\\|public\\|protected\\|private\\|public slots\\|protected slots\\|private slots\\):")
			(c-basic-offset . 4)))
;;syntax-highlighting for Qt
;;(based on work by Arndt Gulbrandse,Troll Tech)
(defun jk/c-mode-common-hook()
"Set up c-mode and related modes.
Include support for Qt code (signal,slot and alikes)."
;;base-style
(c-set-style "stroustrup")
;;set auto cr mode
(c-toggle-auto-hungry-state 1)

;; qt keywords and stuff ...
   ;; set up indenting correctly for new qt kewords
   (setq c-protection-key (concat "\\<\\(public\\|public slot\\|protected"
                                  "\\|protected slot\\|private\\|private slot"
                                  "\\)\\>")
         c-C++-access-key (concat "\\<\\(signals\\|public\\|protected\\|private"
                                  "\\|public slots\\|protected slots\\|private slots"
                                  "\\)\\>[ \t]*:"))
   (progn
     ;; modify the colour of slots to match public, private, etc ...
     (font-lock-add-keywords 'c++-mode
                             '(("\\<\\(slots\\|signals\\)\\>" . font-lock-type-face)))
     ;; make new font for rest of qt keywords
     (make-face 'qt-keywords-face)
     (set-face-foreground 'qt-keywords-face "BlueViolet")
     ;; qt keywords
     (font-lock-add-keywords 'c++-mode
                             '(("\\<Q_OBJECT\\>" . 'qt-keywords-face)))
     (font-lock-add-keywords 'c++-mode
                             '(("\\<SIGNAL\\|SLOT\\>" . 'qt-keywords-face)))
     (font-lock-add-keywords 'c++-mode
                             '(("\\<Q[A-Z][A-Za-z]*" . 'qt-keywords-face)))
     ))
 (add-hook 'c-mode-common-hook 'jk/c-mode-common-hook)

;; Other things I like are, for example,

 
 ;; automatic indent on return in cc-mode
 (define-key c-mode-base-map [\n] 'newline-and-indent)
 
 ;; Do not check for old-style (K&R) function declarations;
 ;; this speeds up indenting a lot.
 (setq c-recognize-knr-p nil)
 
 ;; Switch fromm *.<impl> to *.<head> and vice versa
 (defun switch-cc-to-h ()
   (interactive)
   (when (string-match "^\\(.*\\)\\.\\([^.]*\\)$" buffer-file-name)
     (let ((name (match-string 1 buffer-file-name))
	     (suffix (match-string 2 buffer-file-name)))
       (cond ((string-match suffix "c\\|cc\\|C\\|cpp")
	           (cond ((file-exists-p (concat name ".h"))
			      (find-file (concat name ".h"))
			         )
			    ((file-exists-p (concat name ".hh"))
			         (find-file (concat name ".hh"))
				    )
			        ))
	         ((string-match suffix "h\\|hh")
		       (cond ((file-exists-p (concat name ".cc"))
			          (find-file (concat name ".cc"))
				     )
			        ((file-exists-p (concat name ".C"))
				     (find-file (concat name ".C"))
				        )
				   ((file-exists-p (concat name ".cpp"))
				        (find-file (concat name ".cpp"))
					   )
				      ((file-exists-p (concat name ".c"))
				           (find-file (concat name ".c"))
					      )))))))


;; FIXME: This function still requires the setting of indent level.
;; It is currently hardcoded to four.

(defun insert-gettersetter (type field)
  "Inserts a Java field, and getter/setter methods."
  (interactive "MType: \nMField: ")

  ;; If you don't like the automatic m_ -prefix, then just set this
  ;; to whatever you want.  Empty is okay.
  (setq getsetprefix "")
  (setq capfield (concat (capitalize (substring field 0 1)) (substring field 1)))
  (setq field (concat getsetprefix field))
  (insert (concat "private " type " " field ";\n\n" 
                  "public " type " get" capfield "()\n"
                  "{\n"
                  "    return " field ";\n"
                  "}\n\n"
                  "public void set" capfield "( " type " arg )\n"
                  "{\n"
                  "    " field " = arg;\n"
                  "}\n"
                  ))
)


;; BEGIN: Sec201207092215
;; purpose: To have Emacs hide the passwords as you type them
;; author: taocp
;; date: 2012-07-09 22:15
;; result: emacs asks for nonechoed text in the minibuffer whenever a password prompt appears on th screen.
(add-hook 'comint-output-filter-functions
	  'comint-watch-for-password-prompt)
;; END: Sec201207092215
(require 'ecb)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-matching-delay 1)
 '(canlock-password "3ff6fcf033991d6047db2981db087a0eab1bdee6")
 '(ecb-options-version "2.40")
 '(ede-project-directories (quote ("/tmp/test/inc" "/tmp/test/src" "/tmp/test" "/tmp/iigsm/inc" "/tmp/iigsm/src" "/tmp/iigsm" "/home/taocp/learning/cpp/myprog/inc" "/home/taocp/learning/cpp/myprog/src" "/home/taocp/learning/cpp/myprog" "/home/taocp/learning/cpp/hello/include" "/home/taocp/learning/cpp/hello/src" "/home/taocp/learning/cpp/hello")))
 '(jde-jdk-registry (quote (("1.6.0" . "/etc/java-config-2/current-system-vm/"))))
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 25))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(load "/usr/share/emacs/24.3/lisp/term/rxvt.elc")


(semantic-load-enable-minimum-features)
(setq-mode-local c-mode semanticdb-find-default-throttle '(project unloaded system recursive))
;; for ecb method-buffer display

(add-hook 'semantic-init-hooks 

          (lambda ()

            (senator-minor-mode t)))
(global-set-key [(f5)] 'speedbar-get-focus) 
(add-hook 'speedbar-timer-hook
	(lambda ()
		(speedbar-refresh)))
(setq speedbar-verbosity-level 0)
;; (define-key c-mode-base-map [(meta ?/)] 'semantic-ia-complete-symbol-menu)
;;; semantic setup
;; (semantic-load-enable-minimum-features)
;; (semantic-load-enable-code-helpers)
;; (semantic-load-enable-gaudy-code-helpers)
(semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)
(semantic-load-enable-code-helpers)

;;; gcc setup
;;(require 'semantic-gcc)
;;(require 'semantic/bovine/gcc)

;;; smart complitions setup
(require 'semantic-ia)

;;(setq semantic-c-dependency-system-include-path "/usr/include/")
(setq semantic-c-dependency-system-include-path
      (list
       "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4"
       "/usr/include")) 
;;; 快捷键
(defun my-cedet-hook()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)

  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)

  ;; (local-set-key (kbd "M-n") 'semantic-ia-complete-symbol-menu) ;; 有错误,原因不明

  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
;;  (local-set-key (kbd "M-/") 'semantic-complete-analyze-inline)

  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
;;  (local-set-key "\C-cd" 'semantic-ia-fast-jump)
  (local-set-key "\C-cr" 'semantic-symref-symbol)
  (local-set-key "\C-cR" 'semantic-symref)

  ;;; c/c++ setting
  (local-set-key "." 'semantic-complete-self-insert)
  (local-set-key ">" 'semantic-complete-self-insert)
  (local-set-key ":" 'semantic-complete-self-insert)
;; (local-set-key "\C-ct" 'eassist-switch-h-cpp)
;; (local-set-key "\C-xt" 'eassist-switch-h-cpp)
;; (local-set-key "\C-ce" 'eassist-list-methods)
)

(add-hook 'c-mode-common-hook 'my-cedet-hook)

(add-to-list 'load-path "/usr/share/emacs/site-lisp/color-theme/themes/")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/auctex/")
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (setq TeX-auto-untabify t
                  TeX-engine 'xetex
                  TeX-show-compilation t)
            (TeX-global-PDF-mode t)
            (setq TeX-save-query nil)
            (imenu-add-menubar-index)
            (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)))

(mapc (lambda (mode)
        (add-hook 'LaTeX-mode-hook mode))
      (list 'auto-fill-mode
            'LaTeX-math-mode
            'turn-on-reftex
            'linum-mode))
(setq TeX-view-program-list
      '(("Evince" "evince %o")
        ("Okular" "okular --unique %o")))

(require 'color-theme-solarized)

;;(set-background-color "black") ;; 使用黑色背景
;;(set-foreground-color "white") ;; 使用白色前景

;; (setq qt4-base-dir "/usr/include/qt4")
;; (semantic-add-system-include qt4-base-dir 'c++-mode)
;; (add-to-list 'auto-mode-alist (cons qt4-base-dir 'c++-mode))
;; (add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qconfig.h"))
;; (add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qconfig-dist.h"))
;; (add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qglobal.h"))

;;;;for QT  
;; (semantic-add-system-include "/usr/include/qt4/" 'c++-mode)  
;; (semantic-add-system-include "/usr/include/qt4/QtGui/" 'c++-mode)  
;; (semantic-add-system-include "/usr/include/qt4/QtXml/" 'c++-mode)  
;; (semantic-add-system-include "/usr/include/qt4/QtTest/" 'c++-mode)  
;; (semantic-add-system-include "/usr/include/qt4/QtCore/" 'c++-mode)  
;; (semantic-add-system-include "/usr/include/qt4/QtDesigner/" 'c++-mode)  
;; (semantic-add-system-include "/usr/include/qt4/QtOpenGL/" 'c++-mode)  
;; (semantic-add-system-include "/usr/include/qt4/QtScript/" 'c++-mode)  
;; (semantic-add-system-include "/usr/include/qt4/QtNetwork/" 'c++-mode)  
;; (semantic-add-system-include "/usr/include/qt4/QtUiTools/" 'c++-mode)  
;; (semantic-add-system-include "/usr/include/qt4/QtXmlPatterns/" 'c++-mode)  
(semantic-add-system-include "/usr/include/guile/2.0/" 'c-mode)
(semantic-add-system-include "/usr/include/guile/2.0/libguile" 'c-mode)
(semantic-add-system-include "/usr/include" 'c-mode)
(semantic-add-system-include "/usr/include/qt4/" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtDeclarative" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtDeclarative/private" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/Qt" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtGui" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtGui/private" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtSql" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtScriptTools" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtHelp" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtCore" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtCore/private" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtScript" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtScript/private" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtTest" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/Gentoo" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtUiTools" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtSvg" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtNetwork" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtWebKit" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/Qt3Support" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtDBus" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtDesigner" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtDesigner/private" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtOpenGL" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtXmlPatterns" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtXml" 'c++-mode)


;;; add by lifeng 2013年03月08日 星期五 18时53分35秒
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/parallel" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/debug" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/list_update_map_" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/gp_hash_table_map_" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/trie_policy" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/left_child_next_sibling_heap_" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/pairing_heap_" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/binomial_heap_base_" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/eq_fn" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/resize_policy" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/hash_fn" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/unordered_iterator" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/binomial_heap_" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/pat_trie_" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/ov_tree_map_" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/basic_tree_policy" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/thin_heap_" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/tree_policy" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/bin_search_tree_" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/splay_tree_" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/list_update_policy" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/cc_hash_table_map_" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/rb_tree_map_" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/rc_binomial_heap_" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/ext/pb_ds/detail/binary_heap_" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/x86_64-pc-linux-gnu" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/x86_64-pc-linux-gnu/32" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/x86_64-pc-linux-gnu/32/bits" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/x86_64-pc-linux-gnu/bits" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/decimal" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/profile" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/profile/impl" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/bits" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/tr1" 'c++-mode)
(semantic-add-system-include "/usr/lib64/gcc/x86_64-pc-linux-gnu/4.6.3/include/g++-v4/backward" 'c++-mode)



(add-to-list 'semantic-lex-c-preprocessor-symbol-map '("Q_GUI_EXPORT" . ""))  
(add-to-list 'semantic-lex-c-preprocessor-symbol-map '("Q_CORE_EXPORT" . ""))  
(setq qt4-base-dir "/usr/include/qt4")  
(setq qt4-gui-dir (concat qt4-base-dir "/QtGui"))  
(semantic-add-system-include qt4-base-dir 'c++-mode)  
(semantic-add-system-include qt4-gui-dir 'c++-mode)  
(add-to-list 'auto-mode-alist (cons qt4-base-dir 'c++-mode))  
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qconfig.h"))  
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qconfig-large.h"))  
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qglobal.h")) 
;;设置语言风格和缩进
(setq c-basic-offset 4)  
(add-hook 'c-mode-common-hook ( lambda()  
                ( c-set-style "k&r" )   
                (setq c-basic-offset 4) ) ) ;;设置C语言默认格式   
(add-hook 'c++-mode-common-hook ( lambda()   
                  ( c-set-style "k&r" )   
                  (setq c-basic-offset 4) ) ) ;;设置C++语言默认格式 


(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)

(require 'semanticdb)
(global-semanticdb-minor-mode 1)

(require 'semanticdb-global)
(when (cedet-gnu-global-version-check t)
  (require 'semanticdb-global)
  (semanticdb-enable-gnu-global-databases 'c-mode)
  (semanticdb-enable-gnu-global-databases 'c++-mode))
;; (when (cedet-ectag-version-check)
;;  (semantic-load-enable-primary-exuberent-ctags-support))
(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
  (add-hook 'semantic-init-hooks 'my-semantic-hook)


;;(semantic-add-system-include "/usr/include/boost/" 'c++-mode)
(require 'eieio-opt)
(setq stack-trace-on-error t)
;;(require 'sdcv-mode)

(load "~/.emacs.d/els/sdcv-mode/sdcv-mode.el")
(global-set-key (kbd "C-c d") 'sdcv-search)

(display-time-mode 1)                   ;;启用时间显示设置
(setq display-time-24hr-format t)       ;;时间使用24小时制
(setq display-time-day-and-date t)      ;;时间显示包括日期和具体时间
(setq display-time-use-mail-icon t)     ;;时间栏旁边启用邮件设置
(setq display-time-interval 10)         ;;时间的变化频率
(setq display-time-format " %Y-%m-%d %A %H:%M ") ;;设定日期时间的格式
(display-time) ;;这句可能用不着

(setq user-mail-address "damaobangfa@gmail.com")
(setq user-full-name "taocp")

(setq load-path (cons "/usr/share/emacs/site-lisp/html-helper-mode " load-path)\
)
(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)

(setq auto-mode-alist (cons '("\\.php$" . html-helper-mode)                    auto-mode-alist))

(setq auto-mode-alist (cons '("\\.jsp$" . html-helper-mode)                    auto-mode-alist))

(setq auto-mode-alist (cons '("\\.html?$" . html-helper-mode)                   
                                                                                
auto-mode-alist))

(setq html-helper-address-string                                                 "<a href=\"mailto:damaobangfa@gmail.com \"\>taocp</a>")

;; (setq tempo-interactive t)   ;; html-helper-mode prompt 

(column-number-mode t) ; 显示列号                                                                                                          
;;(global-linum-mode t)  ;显示行号                                                                                                         

;; 設置默認字體，我現在喜歡大一點的字體，養眼。                                                                                            
(set-default-font "Bitstream Vera Sans Mono-11")
;; 设置中文字体                                                                                                                            
(set-fontset-font "fontset-default" 'unicode '("WenQuanYi Bitmap Song" . "unicode-bmp"))

(mouse-avoidance-mode 'animate) ; 光标移动到鼠标下时，鼠标自动弹开                                                                         
(setq frame-title-format "taocp@%b") ; 显示当前编辑的文档                                                                                  
;; insert-date                                                                                                                             
(defun insert-date ()   "Insert date at point."   (interactive)   (insert (format-time-string "%c")))                                      

(defun journal ()                                                                                                                          
  (interactive)                                                                                                                            
  (find-file "~/.journal/journal.txt")                                                                                                     
  (end-of-buffer)                                                                                                                          
  (insert "\n\n")                                                                                                                          
  (insert "*")                                                                                                                             
  (insert-date)                                                                                                                            
  (insert "\n\n")                                                                                                                          
)

(add-to-list 'load-path                                                         
              "/usr/share/emacs/site-lisp/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "/usr/share/emacs/etc/yasnippet/snippets")
(yas/global-mode 1)
(yas/minor-mode-on)

;; org-mode 设置
(setq auto-mode-alist (cons '("\\.org$" . org-mode) auto-mode-alist))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-agenda-files (list "~/org/work.org"
			     "~/org/school.org"
				 "~/org/LearnOrg.org"
			     "~/org/home.org"))
;; w3m设置
(setq browse-url-browser-function 'browse-url-firefox) 
;;(global-set-key "\C-xm" 'browse-url-at-point)
;; opera设置
;;(setq browse-url-browser-function 'browse-url-mozilla)
;;(setq browse-url-mozilla-program "firefox")
;;(global-set-key "\C-xm" 'browse-url-at-point)


	  
(setq global-linum-mode t)
;;(setq gnus-select-method '(nntp "nntp.aioe.org"))
(setq gnus-select-method '(nntp "freenews.netfront.net"))

(defun count-words-buffer ()
  "Count the number of words in the current buffer;
print a message in the minibuffer with the result."
  (interactive)
  (save-excursion
    (let ((count 0))
      (goto-char (point-min))
      (while (< (point) (point-max))
	(forward-word 1)
	(setq count (1+ count)))
      (message "buffer contains %d words." count))))

(define-key c-mode-base-map [(meta /?)] 'hippie-expand)

(autoload 'senator-try-expand-semantic "senator")

(setq hippie-expand-try-functions-list
      '(
        senator-try-expand-semantic
        try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-expand-list
        try-expand-list-all-buffers
        try-expand-line
        try-expand-line-all-buffers
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-whole-kill))

;; (defun goto-percent (pct)
;;   (interactive "nGoto percent: ")
;;   (let* ((size (point-max))
;; 	 (charpos (/ (* size pct) 100)))
;;     (goto-char charpos))
;; )

(defun goto-percent (pct)
(interactive "nPercent: ")
(goto-char (/ (* pct (point-max)) 100)))
;;(ac-config-default)
(global-srecode-minor-mode 1)
;; (setq srecode-map-load-path
;; (list (srecode-map-base-template-dir)
;; (expand-file-name "/usr/share/emacs/site-lisp/cedet/srecode")
;; ))
;;(load-file "~/.emacs.d/My_flyMake.el")

;;; 设置tab的宽度4
(setq-default tab-width 4)
;;; 以空格代替tab
(setq-default indent-tabs-mode nil)

;; 配置semantic的检索范围
(setq semanticdb-project-roots
      (list
       (expand-file-name "/"))
)
;;(ede-cpp-root-project "NAME" :file "FILENAME" :locate-fcn 'MYFCN)
(global-ede-mode t)

(ede-cpp-root-project "nginx"
                      :name "nginx"
                      :file "/home/taocp/learning/c/nginx-1.2.6/Makefile"
                      :system-include-path '(
                                             "/home/taocp/learning/c/nginx-1.2.6/objs"
                                             "/home/taocp/learning/c/nginx-1.2.6/src/mail"
                                             "/home/taocp/learning/c/nginx-1.2.6/src/os/unix"
                                             "/home/taocp/learning/c/nginx-1.2.6/src/misc"
                                             "/home/taocp/learning/c/nginx-1.2.6/src/core"
                                             "/home/taocp/learning/c/nginx-1.2.6/src/event"
                                             "/home/taocp/learning/c/nginx-1.2.6/src/event/modules"
                                             "/home/taocp/learning/c/nginx-1.2.6/src/http"
                                             "/home/taocp/learning/c/nginx-1.2.6/src/http/modules"
                                             "/home/taocp/learning/c/nginx-1.2.6/src/http/modules/perl"
                                             )
                      )

(setq ede-locate-setup-options
       '(ede-locate-global
         ede-locate-base)) 

;; ;; 调用
;; (require 'deft)
;; ;; 匹配文档类型 .txt和路径
;; (setq deft-extension "txt")
;; (setq deft-directory "~/org")

;; ;; 使用markdown-mode作为主模式：
;; (setq deft-text-mode 'markdown-mode)

;; ;; 使用org-mode：
;; (setq deft-extension "org")
;; (setq deft-text-mode 'org-mode)

;; ;; 使用文件名为浏览的标题（默认是文件的第一行）：
;; (setq deft-use-filename-as-title t)

;; ;; 定义默认快捷键
;; (global-set-key [f8] 'deft)
;; 大于4M 的文件警告
(setq large-file-warning-threshold 4000000)

(setq mm-coding-system-priorities '(iso-8859-1 gb2312 utf-8)) 

(add-to-list 'semantic-lex-c-preprocessor-symbol-file "/usr/include/bits/time.h")  

(add-to-list 'semantic-lex-c-preprocessor-symbol-file "/usr/include/time.h")  

(add-to-list 'semantic-lex-c-preprocessor-symbol-file "/usr/include/sys/time.h")

(add-to-list 'semantic-lex-c-preprocessor-symbol-file "/usr/include/bits/sockaddr.h")  
(add-to-list 'semantic-lex-c-preprocessor-symbol-file "/usr/include/sys/socket.h")





(when (fboundp 'winner-mode)
      (winner-mode)
)



(setq-default initial-scratch-message "峰哥在此")



;; (ede-cpp-root-project "hello"
;;                       :name "hello"
;;                       :file "/home/taocp/learning/cpp/hello/Project.ede"
;;                       :include-path '("/include/")
;; 					  :local-variables
;;                       '((grep-command . "grep -nHi -e ")
;;                        (compile-command . "make"))
;;                       )


(setq auto-mode-alist (cons '("\\.pc$" . c++-mode) auto-mode-alist))

(defconst cedet-user-include-dirs
  (list ".." "../include" "../inc" "../common" "../common/inc" "../public" "../public/inc/" "../.." "../../include" "../../inc" "../../common" "../../public" "../../public/inc"  "../../common/inc/"))

(defvar cedet-sys-include-dirs nil "")
(let ((include-dirs cedet-user-include-dirs))
  (setq include-dirs (append include-dirs cedet-sys-include-dirs))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode)) 
        include-dirs))

(put 'narrow-to-page 'disabled nil)
(require 'ido)
(ido-mode t)
(require 'ibuffer) 
(global-set-key (kbd "C-x C-b") 'ibuffer) 

;; Turn on Recentf for Future Sessions
(recentf-mode 1)   ;keep a list of recently opened files

;; Assign a key shortcut
(global-set-key (kbd "<f7>") 'recentf-open-files)
