
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; package管理
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))
(add-to-list 'load-path "/usr/local/share/gtags")

(package-initialize)

;; rainbow-delimiters を使うための設定
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;;定義ジャンプ
(setq dumb-jump-mode t)

;;検索の手助け
(ivy-mode 1)

;; 括弧の色を強調する設定
(require 'cl-lib)
(require 'color)
(defun rainbow-delimiters-using-stronger-colors ()
  (interactive)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
    (cl-callf color-saturate-name (face-foreground face) 15))))
(add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors)
(add-hook 'c++-mode-hook 'rainbow-delimiters-using-stronger-colors)
(add-hook 'c-mode-hook 'rainbow-delimiters-using-stronger-colors)
(add-hook 'python-mode-hook 'rainbow-delimiters-using-stronger-colors)

(add-to-list 'custom-theme-load-path "~/.emacs.d/atom-one-dark-theme/")
(load-theme 'atom-one-dark t)
;; line numberの表示
(require 'linum)
(global-linum-mode 1)

(setq-default indent-tabs-mode nil)
;; ホックを使った設定
(defun my-c-c++-mode-init ()
  (setq c-basic-offset 4)
  )
(add-hook 'c-mode-hook 'my-c-c++-mode-init)
(add-hook 'c++-mode-hook 'my-c-c++-mode-init)

;; left command
(setq mac-command-modifier 'super)

;; tabサイズ
(setq-default tab-width 4 indent-tabs-mode nil)
;;(setq default-tab-width 8)

;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

;;メニューバーを消す
(menu-bar-mode -1)
					;
;;ツールバーを消す
(tool-bar-mode -1)

;; カーソルの点滅をやめる
(blink-cursor-mode 0)

;; カーソル行をハイライトする
(global-hl-line-mode t)

;;選択行をハイライト
(transient-mark-mode t)

;; 対応する括弧を光らせる
(show-paren-mode 1)
(setq show-paren-style 'expression)

;;; 起動時の画面はいらない
(setq inhibit-startup-message t)

;; 選択範囲に色をつける
(transient-mark-mode t)
;(set-face-background 'region "gray70") ;選択範囲の色

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "MediumBlue"))))
 '(transient ((t (:background "red")))))

;;
;; Auto Complete
;;

;;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; '(ahs-default-range (quote ahs-range-whole-buffer))
;; '(package-selected-packages
;;   (quote
;;	(company-irony-c-headers company-irony ctags-update helm-gtags highlight-symbol python-mode js2-mode neotree auto-complete))))
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <down>")  'windmove-down)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <right>") 'windmove-right)

;;補完

(add-hook 'c-mode-hook
	  (lambda ()
	    (require 'auto-complete)
        (c-set-offset 'substatement-open 0)))

(add-hook 'c++-mode-hook
	  (lambda ()
	    (require 'auto-complete)
        (c-set-offset 'substatement-open 0 )))

;;(add-hook 'java-mode-hook
;;	  (lambda ()
;;	    (require 'auto-complete)))

;; auto-java-complete
(add-to-list 'load-path "~/.emacs.d/auto-java-complete")
(require 'ajc-java-complete-config)
(add-hook 'java-mode-hook 'ajc-java-complete-mode)

;;treeを表示
;;(require 'neotree)
;;(global-set-key "\C-q" 'neotree-toggle)

;; 現在ポイントがある関数名をモードラインに表示
(which-function-mode 1)

;; スクロールは1行ごとに
(setq mouse-wheel-scroll-amount '(3 ((shift) . 5)))

;; スクロールの加速をやめる
(setq mouse-wheel-progressive-speed nil)

;; bufferの最後でカーソルを動かそうとしても音をならなくする
(defun next-line (arg)
  (interactive "p")
  (condition-case nil
      (line-move arg)
    (end-of-buffer)))

;; エラー音をならなくする
(setq ring-bell-function 'ignore)

;; 行末の空白を強調表示
;;(setq-default show-trailing-whitespace t)
;;(set-face-background 'trailing-whitespace "#b14770")


;;括弧2個
(add-hook 'c-mode-common-hook
          (lambda ()
         ;;(define-key c-mode-base-map "\"" 'electric-pair)
         ;;(define-key c-mode-base-map "\'" 'electric-pair)
         (define-key c-mode-base-map "(" 'electric-pair)
         (define-key c-mode-base-map "[" 'electric-pair)
         (define-key c-mode-base-map "{" 'electric-pair)))

;;括弧2個
(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map "\"" 'electric-pair)
            (define-key python-mode-map "\'" 'electric-pair)
            (define-key python-mode-map "(" 'electric-pair)
            (define-key python-mode-map "[" 'electric-pair)
            (define-key python-mode-map "{" 'electric-pair)))

(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))

;;pythonの時の色指定
;;(require 'python-mode)
;;(set-face-foreground 'py-variable-name-face "red")
;;(set-face-foreground 'py-import-from-face "pink1")
;;(set-face-foreground 'py-builtins-face "maroon2")

(setq tags-table-list '("~/.emacs.d/soccer_tag"))
;;定義ジャンプのショートカットキー
(define-key global-map "\C-d" 'grep-find)
(define-key global-map "\C-w" 'dumb-jump-go)
(define-key global-map "\C-t" 'pop-tag-mark)
(define-key global-map "\C-f" 'find-file)
(define-key global-map "\C-u" 'goto-line)
(define-key global-map "\C-p" 'forward-word)
(define-key global-map "\C-o" 'backward-word)
(define-key global-map "\C-j" 'copy-region-as-kill)
(define-key global-map "\C-q" 'scroll-down)
;;(define-key global-map "\C-m" 'comment-or-uncomment-region)
(global-set-key (kbd "\C-z")   'advertised-undo)
(global-set-key (kbd "\C-s")   'swiper)

;;指定文字のハイライト
(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ahs-default-range (quote ahs-range-whole-buffer))
 '(package-selected-packages
   (quote
    (swiper ivy dumb-jump web-mode rainbow-delimiters racer quickrun rust-mode yatex go-autocomplete company-go go-mode yasnippet company-irony-c-headers atom-dark-theme company-irony jedi python-mode neotree multi-term company auto-highlight-symbol auto-complete))))

(add-hook 'c-mode-hook
	  (lambda ()
(require 'company)
(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 3) ; デフォルトは4
(setq company-selection-wrap-around t))) ; 候補の一番下でさらに下に行こうとすると一番上に戻る

(add-hook 'c++-mode-hook
	  (lambda ()
(require 'company)
(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 2) ; デフォルトは4
(setq company-selection-wrap-around t))) ; 候補の一番下でさらに下に行こうとすると一番上に戻る

(require 'multi-term)
(global-company-mode) ; 全バッファで有効にする

(require 'epc)
(require 'auto-complete-config)
(require 'python)
;;;;; PYTHONPATH上のソースコードがauto-completeの補完対象になる ;;;;;
(setenv "PYTHONPATH" "/Users/kansei.ishikawa/.pyenv/versions/3.6.1/lib/python3.6/site-packages/")
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(require 'irony)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-to-list 'company-backends 'company-irony) ; backend追加
(add-hook 'c++-mode-hook 'yas-global-mode)
(add-hook 'c-mode-hook 'yas-global-mode)

(setq irony-lang-compile-option-alist
      '((c++-mode . ("c++" "-std=c++11" "-lstdc++" "-lm"))
        (c-mode . ("c"))
        (objc-mode . '("objective-c"))))
(defun irony--lang-compile-option ()
  (irony--awhen (cdr-safe (assq major-mode irony-lang-compile-option-alist))
    (append '("-x") it)))

;;; racerやrustfmt、コンパイラにパスを通す
(add-to-list 'exec-path (expand-file-name "/usr/local/racer/target/release/racer"))
;;; rust-modeでrust-format-on-saveをtにすると自動でrustfmtが走る
(eval-after-load "rust-mode"
  '(setq-default rust-format-on-save t))
;;; rustのファイルを編集するときにracerとflycheckを起動する
(add-hook 'rust-mode-hook (lambda ()
                            (racer-mode)))
;;; racerのeldocサポートを使う
(add-hook 'racer-mode-hook #'eldoc-mode)
;;; racerの補完サポートを使う
(add-hook 'racer-mode-hook (lambda ()
                             (company-mode)
                             ;;; この辺の設定はお好みで
                             (set (make-variable-buffer-local 'company-idle-delay) 0.1)
                             (set (make-variable-buffer-local 'company-minimum-prefix-length) 0)))
;; Goのパスを通す
;(add-to-list 'exec-path (expand-file-name "/usr/local/Cellar/go/1.11.1/bin"))
;; go get で入れたツールのパスを通す
;(add-to-list 'exec-path (expand-file-name "/Users/kansei.ishikawa/dev/go/bin"))


