(asdf:defsystem #:pad
  :description "PIAS server"
  :author "Darren Minsoo Kim <darren_minsoo_kim@outlook.com>"
  :license  "All Rights Reserved"
  :version "0.0.1"
  :serial t
  :components ((:file "package")
	       (:file "database")
               (:file "main"))
  :depends-on (:hunchentoot
	       :easy-routes
	       :jsown))
