(defun get-port (&optional (string (sb-posix:getenv "PORT")))
  (print
   (if string
       (parse-integer string)
       8988)))

(hunchentoot:start
 (make-instance 'hunchentoot:easy-acceptor
		:port (get-port)
		:document-root (merge-pathnames "./www/" *load-truename*)))


(setq tbnl:*show-lisp-errors-p* (sb-posix:getenv "SHOW-ERRORS"))

(load "app")
(handler-case
  (loop
    (sleep 1000))
  (t (err)
    (format t "Finishing due to ~s" err)
    (sb-ext:quit)))
