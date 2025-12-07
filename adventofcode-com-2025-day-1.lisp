
(defvar adventofcode.com/2025/day/1/input.txt "adventofcode-com-2025-day-1-input.txt")
(defun adventofcode.com/2025/day/1 (&optional (pathname adventofcode.com/2025/day/1/input.txt))
  (let ((r 50) (c 0))
    (loop for i in (mapcar #'inst-to-num (uiop:read-file-lines pathname))
          do
          (setq r (mod (+ i r) 100))
          (if (= r 0) (setq c (1+ c))))
    c))
;; Call (adventofcode.com/2025/day/1) with a file with the default pathname "adventofcode.com-2025-day-1-input.txt" to find the answer.

(defun inst-to-num (instruction)
  (case (schar instruction 0)
    (#\R (parse-integer (subseq instruction 1)))
    (#\L (- (parse-integer (subseq instruction 1))))))

(defun adventofcode.com/2025/day/1/Part/II (&optional (pathname adventofcode.com/2025/day/1/input.txt))
  (let ((r 50) (c 0))
    (loop for i in (mapcar #'inst-to-num (uiop:read-file-lines pathname))
          do
          (setq r (mod (+ i r) 100))
          (if (= r 0)
              (setq c (+ 1 c (floor (if (> i 0) i (- i)) 100)))
              (progn
                (if (> i 0) (setq c (+ c (floor i 100))))
                (if (< i 0) (setq c (+ c (floor (- i) 100)))))))
    c))
;; Call (adventofcode.com/2025/day/1/Part/II) with a file with the default pathname "adventofcode.com-2025-day-1-input.txt" to find the answer.

;; II 5734 很低
