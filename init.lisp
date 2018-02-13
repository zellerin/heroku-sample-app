(load "quicklisp/setup")
(asdf:disable-output-translations)
(push :hunchentoot-no-ssl *features*)
(ql:quickload 'hunchentoot)
(hunchentoot:start
 (make-instance 'hunchentoot:easy-acceptor
		:port (parse-integer (sb-posix:getenv "PORT"))))
(loop
      (sleep 1000))

