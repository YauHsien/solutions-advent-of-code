(defun perm (list)
  (cond ((null (cdr list))     (cons list nil))
	((= 2 (length list))   (cons list (cons (reverse list) nil)))
	(t
	 (apply 'append (mapcar (lambda (a)
				  (mapcar (lambda (p) (cons a p))   (perm (remove a list))))
				list)))))
