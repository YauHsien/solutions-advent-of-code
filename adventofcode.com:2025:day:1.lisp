(defvar adventofcode.com/2015/day/1/input.txt "adventofcode.com:2015:day:1:input.txt")
(defun adventofcode.com/2015/day/1 (&optional (pathname adventofcode.com/2015/day/1/input.txt))
 (apply '+ (with-open-file (stream pathname)
            (loop for c = (read-char stream nil :eof) until (eq c :eof) collect (case c (#\( 1) (#\) -1))))))
;; Call (adventofcode.com/2015/day/1) with a default file with pathname "adventofcode.com:2015:day:1:input.txt" to find the answer.
