(defvar adventofcode.com/2015/day/1/input.txt "adventofcode.com:2015:day:1:input.txt")
(defun adventofcode.com/2015/day/1 (&optional (pathname adventofcode.com/2015/day/1/input.txt))
 (apply '+ (with-open-file (stream pathname)
            (loop for c = (read-char stream nil :eof) until (eq c :eof) collect (case c (#\( 1) (#\) -1))))))
;; Call (adventofcode.com/2015/day/1) with a file with the default pathname "adventofcode.com:2015:day:1:input.txt" to find the answer.

(defun adventofcode.com/2015/day/1/Part/II (&optional (pathname adventofcode.com/2015/day/1/input.txt))
 (let ((collection nil))
      (with-open-file (stream pathname)
       (loop for c = (read-char stream nil :eof) until (eq -1 (apply '+ collection))
             collect (setq collection (cons (case c (#\( 1) (#\) -1)) collection))))
      (length collection)))
;; Call (adventofcode.com/2015/day/1/Part/II) with a file with the default pathname "adventofcode.com:2015:day:1:input.txt" to find the answer.
