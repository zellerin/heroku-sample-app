(defmacro my-page (name pars &body body)
  `(hunchentoot:define-easy-handler (,name :uri ,(format nil "/~(~a~)" name)) ,pars
       (with-output-to-string (s)
	 (cl-who:with-html-output (s)
	   ,@body))))

(my-page reload ()
	 (:h1 "Reloading...")
	 (load "app.lisp" :if-does-not-exist nil))

(hunchentoot:define-easy-handler (main :uri "/") ()
  (with-output-to-string (s)
    (cl-who:with-html-output (s)
      (:h1 "It works"))))

(defun parse-connection-string (&optional (string (sb-posix:getenv "DATABASE_URL")))
  (cond ((null string)
	 '("zellerin" "zellerin" nil :unix))
	(t
	 (let* ((user-start (mismatch "postgres://" string))
		(passwd-start (position #\: string :start user-start))
		(url-start (position #\@ string :start passwd-start))
		(port-start (position #\: string :start url-start))
		(application (position #\/ string :start port-start)))
	   (list
	    (subseq string (1+ application))
	    (subseq string user-start passwd-start)
	    (subseq string (1+ passwd-start) url-start)
	    (subseq string (1+ url-start) port-start)
	    :port (parse-integer (subseq string (1+ port-start) application)))))))

(my-page pgtest ()
    (:h1 "PG test")
  (format s "<p>~s</p>"
	  (postmodern:with-connection (parse-connection-string)
		(postmodern:QUERY (:select 22 4.5 "HI")))))
