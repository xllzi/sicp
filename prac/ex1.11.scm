(define (f-rec n)
  (if (< n 3) n
      (+ (f-rec (- n 1))
         (* 2 (f-rec (- n 2)))
         (* 3 (f-rec (- n 3))))))

;; store the state of computation f(n) into parameter
;; carry f(n-1) f(n-2) f(n-3) forward
(define (f-iter n a b c)
  (if (= n 0) a
      (f-iter (- n 1)  b c (+ (* 3 a) (* 2 b) (* 1 c)))))

(define assert1
  (= (f-rec 7) (f-iter 7 0 1 2)))
