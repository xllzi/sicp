(define (fast-expt-recr b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt-recr b (/ n 2))))
        (else (* b (fast-expt-recr b (- n 1))))))

(define (even? n)
  (= (remainder n 2) 0))

(define (fast-expt b n)
  (fast-expt-iter b n 1))

;; carry alone the accumulator a such that invarient a * b^n holds
(define (fast-expt-iter b n a)
  (cond ((= n 0) a)
        ((even? n) (fast-expt-iter (square b) (/ n 2) a))
        (else (* b (fast-expt-iter b (- n 1) (* a b))))))

