;;; -*- coding:utf-8 -*-
;;; joseph-org.el --- config about org mode

;; Copyright (C) 2011  纪秀峰

;; Author: 纪秀峰 <jixiuf@gmail.com>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; `<TAB>'      子树的折叠
;; ,-> FOLDED -> CHILDREN -> SUBTREE --.
;; '-----------------------------------'
;; `S-<TAB>' 整个buffer的折叠
;; `C-u <TAB>'
;; ,-> OVERVIEW -> CONTENTS -> SHOW ALL --.
;; '--------------------------------------'
;; `C-u C-u C-u <TAB>' 显示所有

;;org buffer 打开时的初始状态是Overview ,可`org-startup-folded'进行配置
;; 也可在每个文件头部加入下面内容设置
;; #+STARTUP: overview
;; #+STARTUP: content
;; #+STARTUP: showall
;; #+STARTUP: showeverything
;; `C-u C-u <TAB>' 切换到buffer 初化的状态

;;可以 通过VISIBILITY 属性设置某一个节点的可视化状态，如：
;;                         ** adef
;;                         ** abc
;;                         :PROPERTIES:
;;                         :VISIBILITY: children
;;                         :END:
;;

;;与属性设置相关的键绑定

;;`C-cC-xp'插入一个属性

;; `S-<left>/<right>'
;; 在某个属性可取的值之间循环

;;在一个属性行上按`C-cC-c' 执行与属性相关的操作，如重新设置值，删除这个属性等,如
;; `C-c C-c d' 删除一个property
;; `C-c C-c D' 全局删除一个property
;; `C-c C-c c'
;; Compute the property at point, using the operator and scope from
;; the nearest column format definition.

;;`M-x org-insert-property-drawer'
;;插入 设置属性的开始与结束标记，即
;;                         :PROPERTIES:
;;                          这中间设置属性
;;                         :END:
;;一个属性可以设置它可以取哪些值，比如
;; prop1 可以属1 2 3 ,这样设置
;; prop1_ALL 1 2 3
;;这个属性如果像这样放在文件头部，此文件中有效
;; #+PROPERTY: NDisks_ALL 1 2 3 4
;; `org-global-properties' 所有文件中有效
;; 在一个节点设置，则此子点下性所有子节点有效
;;比如：
;;                         * CD collection
;;                         :PROPERTIES:
;;                         :NDisks_ALL:  1 2 3 4
;;                         :Publisher_ALL: "Deutsche Grammophon" Philips EMI
;;                         :END:
;;                         ** a cd
;;                         :PROPERTIES:
;;                         :NDisks: 1             --- 这里只能取值1 2 3 4
;;                         :Publisher: EMI         ----同理
;;                         :END:





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;`C-cC-xf'  脚注相关的操作 ,插入脚注，在脚注间跳转
;;`C-uC-cC-xf'  脚注相关的操作

;;Todo相关
;; `C-c C-t'
;; ,-> (unmarked) -> TODO -> DONE --.
;; '--------------------------------'
;;竖线之后表示处于完成状态
;; (setq org-todo-keywords
;;       '((sequence "待办" "结果反馈" "最终检查" "|" "完成" "DELEGATED")))

;;(setq org-todo-keywords '((type "homewordToDo" "JobToDo"  "|" "DONE")))

;;多个序列 (序列间切换)
;; `C-u C-u C-c C-t'
;; `C-S-<right>'
;; `C-S-<left>'
;;q所有keyword 间切换
;; `S-<right>'
;; `S-<left>'
;; (setq org-todo-keywords
;;       '((sequence "TODO(t)" "|" "DONE(d)")
;;         (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
;;         (sequence "|" "CANCELED(c)")))

(setq org-todo-keyword-faces
      '(("TODO"      . org-warning)
        ("DEFERRED"  . shadow)
        ("CANCELED"  . (:foreground "blue" :weight bold))))

;;每个keyword 后有字母，可以用`C-cC-t'后跟这个字母迅速切换到这种状态
;;只在某一文件有效的todo 设置
;; #+TODO: TODO | DONE
;; #+TODO: REPORT BUG KNOWNCAUSE | FIXED
;; #+TODO: | CANCELED

;; (setq org-startup-folded t)

(setq-default org-enforce-todo-dependencies t) ;; 子节点若有未完成事项，则父节点不能标记为Done
;;记录Done 的时刻
;;(setq org-log-done 'time)

(setq-default org-log-done 'note)
;; (setq org-log-done 'note) ;; 与(setq org-log-done 'time)相同，并且提示你输入一条note
;;默认情况下，只有Done 的时候才记录时刻或note ,也可以设置在处于某个关键字状态时也进行此操作
;;d在每个关键字后的括号中加入这两个标记`!' (for a timestamp) and `@' (for a note)

;;已经标记为“@” 了，后面却跟着一个'/!' ,表示 在从这个状态切换到其他状态时，当仅仅当
;;目标状态没有设置@也没! 时，它会记录此时的时刻，表示从这个状态切换为其他状态的时刻。
;; (setq org-todo-keywords
;;       '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")))
;;比如这个例子，从wait 切换为todo 状态时，它会记录时刻，因为todo状态，没有! 或@ 标记
;; (setq org-todo-keywords
;;       '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")))
(setq-default org-todo-keywords
      '((sequence "TODO(t!)" "|" "DONE(d@/!)")
        (sequence "REPORT(r!)" "BUG(b!)" "KNOWNCAUSE(k!)" "|" "FIXED(f@)")
        (sequence "|" "CANCELED(c@)")))
;;local同样的语法
;; #+TODO: TODO(t) WAIT(w@/!) | DONE(d!) CANCELED(c@)

;;如果仅想对革一特定的子节点进行定制，使用LOGGING属性
;;                        * TODO Log each state with only a time
;;                         :PROPERTIES:
;;                         :LOGGING: TODO(!) WAIT(!) DONE(!) CANCELED(!)
;;                         :END:
;;                         * TODO Only log when switching to WAIT, and when repeating
;;                         :PROPERTIES:
;;                         :LOGGING: WAIT(@) logrepeat
;;                         :END:
;;                         * TODO No logging at all
;;                         :PROPERTIES:
;;                         :LOGGING: nil
;;                         :END:
;设置优先级
;; `C-c ,'
;; `S-<up>'
;; `S-<down>'
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;-- Tag --
;设置了
;; #+FILETAGS: :Peter:Boss:Secret:
;;相当于本文档中所有标题中都含这几个tag
;;操作Tag 的操作
;; `C-c C-q' 插入xc
;; `C-c C-c'

;; `org-tag-alist'
;; #+TAGS: @work @home @tennisclub
;; #+TAGS: laptop car pc sailboat
;;(setq org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("laptop" . ?l)))
(setq-default org-tag-alist '(("@Erlang" . ?r)("@Emacs" . ?e) ("@AutoHotKey" . ?a) ("@SVN" . ?S) ("@SQL" . ?s) ("@Daily" . ?d)("@Java" . ?j)("@Windows" . ?w)  ("@Novel" . ?n)("@Oracle" . ?o) ("@DB" . ?b) ("@Linux" . ?l)))

;;或者：
;;#+TAGS: @work(w)  @home(h)  @tennisclub(t)  laptop(l)  pc(p)

;分组：同组只择其一
;;#+TAGS: { @work(w)  @home(h)  @tennisclub(t) }  laptop(l)  pc(p)
;;全局 如果要设置分组 要用`:startgroup' `:endgroup'来分组
;; (setq org-tag-alist '((:startgroup . nil)
;;                       ("@work" . ?w) ("@home" . ?h)
;;                       ("@tennisclub" . ?t)
;;                       (:endgroup . nil)
;;                       ("laptop" . ?l) ("pc" . ?p)))



;; C-caa
;;deadline and schedules 最后期限于 任务安排
;;(setq org-deadline-warning-days 5);;最后期限到达前5天即给出警告
;; *** TODO write article about the Earth for the Guide
;; The editor in charge is [[bbdb:Ford Prefect]]
;; DEADLINE: <2004-02-29 Sun>
;; `DEADLINE: <2004-02-29 Sun -5d>'.这种格式可以指定5天前警告
;;; schedules 则用于指定在未来的一天开始执行某任务
;; *** TODO Call Trillian for a date on New Years Eve.
;; SCHEDULED: <2004-12-25 Sat>
;; `C-cC-s'  插入schedule
;; # C-cC-s 计划任务 ，加一个 日期 C-caa显示计划任务
;; # C-uC-cC-s 删除此计划任务
;; # C-uC-uC-tc-s 延期此计划任务
;; # C-cC-d 插入一个deadline

;; `C-cC-xC-k' Mark the current entry for agenda action.
;;press `k s' or `k d' to schedule the marked item.

;; DROPBOX_DIR=%
(defvar dropbox-dir (expand-file-name "~/Documents/Dropbox"))
(when (equal system-type 'windows-nt)
  (setq  dropbox-dir (expand-file-name "Dropbox" (getenv "USERPROFILE"))) )

(setq-default org-agenda-deadline-leaders (quote ("最后期限:  " "%3d 天后到期: " "%2d 天前: ")))
;; (setq-default org-agenda-format-date (quote my-org-agenda-format-date-aligned))
(setq-default org-agenda-inhibit-startup t)
(setq-default org-agenda-scheduled-leaders (quote ("计划任务:" "计划任务(第%2d次激活): ")))
(setq-default org-agenda-window-setup (quote current-window))
(setq-default org-clock-string "计时:")
(setq-default org-closed-string "已关闭:")
(setq-default org-deadline-string "最后期限:")
(setq-default org-scheduled-string "计划任务:")
(setq-default org-time-stamp-formats  '("<%Y-%m-%d 周%u>" . "<%Y-%m-%d 周%u %H:%M>"))
;;(define-key mode-specific-map [?a] 'org-agenda)
(eval-after-load 'org-agenda
  '(progn
     (define-key org-agenda-mode-map "\C-n" 'next-line)
     (define-key org-agenda-keymap "\C-n" 'next-line)
     (define-key org-agenda-mode-map "\C-p" 'previous-line)
     (define-key org-agenda-keymap "\C-p" 'previous-line)
     (setq org-agenda-files  (list (expand-file-name "todo.org" dropbox-dir)))
     (setq org-deadline-warning-days 5);;最后期限到达前5天即给出警告
     (setq org-agenda-show-all-dates t)
     (setq org-agenda-skip-deadline-if-done t)
     (setq org-agenda-skip-scheduled-if-done t)


     ;; (setq org-agenda-span 7)
     ;;与     (setq org-agenda-start-on-weekday  nil)合作，表示显示未来7天
     ;;的agenda,而不是本周
     ;; (setq org-agenda-start-on-weekday  nil)
     ;; (setq org-agenda-start-on-weekday nil)
      (setq org-reverse-note-order t) ;;org.el
     ))

;;     (define-key global-map [(control meta ?r)] 'remember)
;;(require 'remember)
;; (eval-after-load 'remember
;;   '(progn
;;      (make-directory  (expand-file-name "~/.emacs.d/site-lisp/submodules/dotemacs_priv/") t)
;;      (add-hook 'remember-mode-hook 'org-remember-apply-template)
;;      (setq org-remember-store-without-prompt t)

;;      (autoload 'org-remember-annotation "org-remember")

;;      (setq org-remember-templates
;;            `((?t "* TODO %?\n  %u"  ,(expand-file-name "~/.emacs.d/site-lisp/submodules/dotemacs_priv/todo.org") "Tasks")
;;              (?n "* %u %?" ,(expand-file-name "~/.emacs.d/site-lisp/submodules/dotemacs_priv/notes.org") "Notes"))
;;            )
;;      (setq remember-annotation-functions (quote (org-remember-annotation)))
;;      (setq remember-handler-functions (quote (org-remember-handler)))
;;      )
;;   )
;; (autoload 'org-go-to-remember-target "org-remember")

(make-directory dropbox-dir t)

(setq-default org-default-notes-file (expand-file-name "notes.org" dropbox-dir))
(setq-default org-capture-templates
              `(("t" "Todo" entry (file+headline ,(expand-file-name "todo.org" dropbox-dir) "Tasks")
                 "* TODO %? 创建于:%T\n  %i\n")
                ("n" "Note" item (file ,org-default-notes-file)
                 " %? ")))

(autoload 'org-capture-goto-last-stored "org-capture")

;; C-car C-cab
(setq-default org-agenda-custom-commands
      '(("n"  "[Note] Go to  Target(Note )" ( (find-file org-default-notes-file)))
        ;; ("b" . "show item of tags prefix") ; describe prefix "h"
        ;; ("be" tags "+Emacs")
        ;; ("bj" tags "+Java")
        ;; ("ba" tags "+AutoHotKey")
        ;; ("bl" tags "+Linux")
        ;; ("bd" tags "+Daily")
        ;; ("bw" tags "+Windows")
        ("d" todo "DELEGATED" nil)
      ("c" todo "DONE|DEFERRED|CANCELLED" nil)
      ("W" todo "WAITING" nil)
      ("w" agenda "" ((org-agenda-start-on-weekday 1) ;start form Monday
                      (org-agenda-ndays 14)))
      ("A" agenda ""
       ((org-agenda-skip-function
         (lambda nil
           (org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]")))
        (org-agenda-ndays 1)
        (org-agenda-overriding-header "Today's Priority #A tasks: ")))
      ("u" alltodo ""
       ((org-agenda-skip-function
         (lambda nil
           (org-agenda-skip-entry-if (quote scheduled) (quote deadline)
                                     (quote regexp) "\n]+>")))
        (org-agenda-overriding-header "Unscheduled TODO entries: ")))
      ))

;;默认C-c' 与icicle冲突，所以绑定C-wC-e 为org-edit-special
;;这个函数是在 编辑org 中的源代码时，启用相应的mode进行编辑操作
(eval-after-load 'org '(define-key org-mode-map (kbd "C-w C-e") 'org-edit-special))
(eval-after-load 'org-src
  '(progn
     (define-key org-src-mode-map "\C-w\C-e" 'org-edit-src-exit)
     (define-key org-src-mode-map "\C-c\C-c" 'org-edit-src-exit)
     (define-key org-src-mode-map "\C-x\C-s" 'org-edit-src-exit)
     )
  )

(eval-after-load 'org
  '(progn
     (define-key org-mode-map "\C-k" 'joseph-kill-region-or-org-kill-line)
     (define-key org-mode-map "\C-a" 'org-mode-smart-beginning-of-line)
     (define-key org-mode-map "\C-e" 'org-mode-smart-end-of-line)
     )
  )
(provide 'joseph-org)
;;; joseph-org.el ends here
