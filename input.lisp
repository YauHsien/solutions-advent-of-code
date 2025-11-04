(defvar *input-file-format* "adventofcode-com-~a-day-~a-input.txt")
(defvar *session*)

(defun ensure-input-file (year &key day (session *session*)) ;=> pathname
  (assert (not (null day)))
  (let ((pathname (format nil *input-file-format* year day)))
    (if (probe-file pathname) pathname
	(progn (assert (not (null session)))
	       (download-input-file year :day day :session session)))))

(defun download-input-file (year &key day (session *session*)) ;=> pathname
  (assert (not (null day)))
  (assert (not (null session)))
  (let ((content
	 (let ((cookie-jar (make-instance
			    'drakma:cookie-jar
			    :cookies (list (make-instance 'drakma:cookie
							  :name "session"
							  :value session
							  :domain ".adventofcode.com")))))
	   (drakma:http-request
	    (format nil "https://adventofcode.com/~a/day/~a/input" year day)
	    :cookie-jar cookie-jar)))
	(pathname (format nil *input-file-format* year day)))
    (with-open-file (stream pathname
                            :direction :output    ;; Write to disk
                            :if-exists :supersede ;; Overwrite the file
                            :if-does-not-exist :create)
      (format stream "~a" content))
    pathname))
