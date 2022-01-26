;;;; pad.lisp

(in-package #:pad)

(defun hello ()
  (print db-spec))

;; (ql:quickload 'hunchentoot)
;; (ql:quickload 'easy-routes)

(easy-routes:defroute foo ("/foo/:x" :method :get) (y &get z)
  (format nil "x: ~a y: ~a z: ~a" x y z))

(easy-routes:defroute get-client ("/client/:x" :method :get) (y &get z)
  (format nil "x: ~a y: ~a z: ~a" x y z))


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

(easy-routes:defroute post-client!
    ("/client/:x/:y/:z" :method :post
			:decorators (@prn @head)) ()
  (format nil "POST! ~a y: ~a z: ~a" x y z))

(easy-routes:defroute put-client!
    ("/client/:x/:y" :method :put
		     :decorators (@prn @json @head)) ()
  (format nil "{\"apple\": \"carrot\", \"love\": \"~a\", \"hate\": \"~a\"}" x y))



(defvar *server* (make-instance 'easy-routes:easy-routes-acceptor :port 1234))

(hunchentoot:start *server*)
