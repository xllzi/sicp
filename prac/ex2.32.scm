;; the subsets is divided in two groups: those without the first element, and those with it.
(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (subset) (cons (car s) subset)) rest)))))
