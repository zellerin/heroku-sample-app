(load "quicklisp/setup")
(asdf:disable-output-translations)
(push :hunchentoot-no-ssl *features*)
(ql:quickload 'hunchentoot)
(hunchentoot:start
 (make-instance 'hunchentoot:easy-acceptor
		:port (parse-integer (sb-posix:getenv "PORT"))))

(hunchentoot:define-easy-handler (test :uri "/") ()
    "<h1>Test works.</h1>")

(loop
      (sleep 1000))

