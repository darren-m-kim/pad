;;;; pad.lisp

(in-package #:pad)

(defun hello ()
  (print db-spec))

(defun @prn (next)
  (print "HI DARREN")
  (funcall next))

(defun @head (next)
  (print (hunchentoot:query-string*))
  ;;(print (hunchentoot:get-header "mysecret" hunchentoot:*request*))
  (funcall next))

(defun @json (next)
  "JSON decoration. Sets reply content type to application/json"
  (setf (hunchentoot:content-type*) "application/json")
  (funcall next))

(rou:defroute foo
    ("/foo/:x" :method :get) (y &get z)
  (format nil "x: ~a y: ~a z: ~a" x y z))

(rou:defroute get-client
    ("/client" :method :get
	       :decorators (@json)) ()
  (format nil
	  (jso:to-json
	   '(:obj ('bingo . 24.93)
	     ("bang" 1 2 3 "foo" 4 5)
	     ("foo" . "bar")))))

(rou:defroute post-client!
    ("/client/:x/:y/:z" :method :post
			:decorators (@prn @head)) ()
  (format nil "POST! ~a y: ~a z: ~a" x y z))

(rou:defroute put-client!
    ("/client/:x/:y" :method :put
		     :decorators (@prn @json @head)) ()
  (format nil "{\"apple\": \"carrot\", \"love\": \"~a\", \"hate\": \"~a\"}" x y))

(defvar *server*
  (make-instance
   'rou:easy-routes-acceptor
   :port 1234))

(defun start ()
  (hun:start *server*))

(defun stop ()
  (hun:stop *server*))

(defun refresh ()
  (progn (stop)
	 (start)))
