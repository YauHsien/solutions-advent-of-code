
(defvar adventofcode.com/2015/day/24/input.txt "adventofcode-com-2015-day-24-input.txt")
(defun adventofcode.com/2015/day/24 (&optional (pathname adventofcode.com/2015/day/24/input.txt))
	(let* ((forms (uiop:read-file-forms pathname))
         (sum   (floor (/ (apply '+ forms) 3.0))))
    (factors-list (combinations-sum-upto forms sum))
    ))
;; 我在 SWI-Prolog 裡寫
;; numbers([1,2,3,7,11,13,17,19,23,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101,103,107,109,113]).
;; ?- numbers(X),member(A,X),member(B,X),A=\=B,member(C,X),A=\=C,B=\=C,member(D,X),A=\=D,B=\=D,C=\=D,member(E,X),A=\=E,B=\=E,C=\=E,D=\=E,member(F,X),A=\=F,B=\=F,C=\=F,D=\=F,E=\=F,A+B+C+D+E+F=:=520.
;; 過了幾秒後能算出取了六個數的 QE ，
;; 但是，在 Roswell + SBCL 卻耗盡了它的 controll stack size 。
;; 我試著調整過 controll stack size ，但也不通過。
;; 不過，Lisp 算
;; (factors-list (combinations-sum-upto '(1 2 3 4 5 7 8 9 10 11) 20))
;; 能給出結果。
;;
;; 答題資料給我 29 個數，我瀏覽並注意到恰好都是質數，除 1 以外，
;; 再加上 SWI-Prolog 的解，以及我推想最大五個數的總和已超過全部加總的三分之一，
;; 於是，我猜就是 SWI-Prolog 幫我找的六個數的 QE。

(defun combinations-sum-upto (a-list upto)
  (let ((lol  (list (list upto)))
        (ls   a-list))
    (loop for x in ls do
          (setq lol
                (remove nil
                        (apply 'append
                               (mapcar (lambda (count-list)
                                         (if (eq :ok (car count-list)) (list count-list)
                                             (list count-list (fit x count-list))))
                                       lol)))))
    (mapcar (lambda (x)
              (cons (cdr x) (set-difference a-list (cdr x))))
            (remove-if (lambda (x) (not (eq :ok (car x)))) lol))
    ))

(defun factors-list (a-list)
  (mapcar (lambda (x)
            (let* ((group-1 (car x))
                   (rest    (cdr x))
                   (sum     (apply '+ (car x)))
                   ;(group-2&3 (combinations-sum-upto rest sum))
                   )
              (list (length (car x)) (apply '* (car x)) (cons group-1 :group-2&3))))
          a-list))

(defun fit (x ls)
  "Specification of ls: (<sum-upto> weight-1 weight-2 ...)
Complete one:   (:ok weight-1 weight-2 weight-3 ...)
Applicable one: (<number-great-than-0 weight-1 weight2 ...)"
  (cond ((> x (car ls)) nil)
        ((< x (car ls)) (cons (- (car ls) x)
                              (cons x (cdr ls))))
        (t              (cons :ok
                              (cons x (cdr ls))))))
