;;;###autoload
(defun open-with-C-RET-on-w32()
  "in dired mode ,`C-RET' open file with ..."
  (interactive)
  (let ((openwith-associations
         '(("\\.pdf$" "open" (file))
           ("\\.mov\\|\\.RM$\\|\\.RMVB$\\|\\.avi$\\|\\.AVI$\\|\\.flv$\\|\\.mp4\\|\\.mkv$\\|\\.rmvb$" "open" (file) )
           ;;       ("\\.jpe?g$\\|\\.png$\\|\\.bmp\\|\\.gif$" "open" (file))
           ("\\.bmp$" "open" (file))
           ("\\.mp3$" "mpg123" (file))
           ("\\.wav" "open" (file))
           ("\\.cs$" "open" (file))
           ("\\.CHM$\\|\\.chm$" "open"  (file) )
           ("\\.HTML?$\\|\\.html?$" "open"  (file) )
           )))
    (if (equal major-mode 'dired-mode)
        (w32-shell-execute "open"  (expand-file-name (dired-get-filename)))
      (w32-shell-execute "open"  (expand-file-name  (or (buffer-file-name) "~"))))))

(defun w32explore (file)
  "Open Windows Explorer to FILE (a file or a folder)."
  (interactive "fFile: ")
  (let ((w32file (convert-standard-filename file)))
    (if (file-directory-p w32file)
        (w32-shell-execute "explore" w32file "/e,/select,")
      (w32-shell-execute "open" "explorer" (concat "/e,/select," w32file)))))

;;C-M-<RET> 用资源管理器打开当前文件所处目录
;;;###autoload
(defun explorer-open()
  "用windows 上的explorer.exe打开此文件夹."
  (interactive)
  (if (equal major-mode 'dired-mode)
      (w32explore (expand-file-name (dired-get-filename)))
    (w32explore (expand-file-name  (or (buffer-file-name) "~")))))


(provide 'joseph-openwith-w32-lazy)

;; Local Variables:
;; coding: utf-8
;; End:

;;; joseph-openwith-w32-lazy.el ends here
