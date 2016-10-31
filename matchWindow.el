(defun get-buf-name-from-alive-window ()
  (setq exp "\\(?:\"\\*w3m\\*\\(?:\\(?:<\\(?:\\(?:1\\(?:0[0-9]\\|1[0-9]\\|2[0-9]\\|3[0-9]\\|4[0-9]\\|5[0-9]\\|6[0-9]\\|7[0-9]\\|8[0-9]\\|9[0-9]\\|[0-9]\\)\\|2\\(?:0[0-9]\\|1[0-9]\\|2[0-9]\\|3[0-9]\\|4[0-9]\\|5[0-9]\\|6[0-9]\\|7[0-9]\\|8[0-9]\\|9[0-9]\\|[0-9]\\)\\|3\\(?:0[0-9]\\|1[0-9]\\|2[0-9]\\|3[0-9]\\|4[0-9]\\|5[0-9]\\|6[0-9]\\|7[0-9]\\|8[0-9]\\|9[0-9]\\|[0-9]\\)\\|4\\(?:0[0-9]\\|1[0-9]\\|2[0-9]\\|3[0-9]\\|4[0-9]\\|5[0-9]\\|6[0-9]\\|7[0-9]\\|8[0-9]\\|9[0-9]\\|[0-9]\\)\\|5\\(?:00\\|[0-9]\\)\\|6[0-9]\\|7[0-9]\\|8[0-9]\\|9[0-9]\\|[1-9]\\)>\\)\\)?\"\\)\\)")
  (setq buffer-name-of-alive-w3m-window "0")
  (setq tmp-list (window-list))
  (while tmp-list
    (setq buf-name (buffer-name (window-buffer (car tmp-list))))
    (string-match exp buf-name)
    (if (string= (match-string 0 buf-name) "*")
        (setq tmp-list nil))
    (setq tmp-list (cdr tmp-list))
    (if (string= (match-string 0 buf-name) "*")
        (setq buffer-name-of-alive-w3m-window buf-name))))
(get-buf-name-from-alive-window)
buffer-name-of-alive-w3m-window

(save-excursion
  (let ((origin-window))
    (setq origin-window (selected-window))
    (get-buf-name-from-alive-window)
    (select-window (get-buffer-window (get-buffer
                                       buffer-name-of-alive-w3m-window)))
    ;;(select-window w3m-window)
    (w3m-goto-new-session-url)
    (select-window origin-window)))


