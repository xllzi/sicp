(define (fib n)
  (fib-iter 1 0 n))

(define (fib-iter a b count)
  (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))

;; count number of computations fib(x) in fib(n) tree
(define (count-fib x n)
  (cond ((= x n) 1)
        ((> x n) 0)
        ((= x 0) (count-fib (+ x 2) n))
        (else (+ (count-fib (+ x 1) n) 
                 (count-fib (+ x 2) n)))))

;; the nodes of fibonacci tree is growing on the order of fibonacci
(define assert1
  (= (count-fib 1 7) (fib 7)))

(define assert2 
  (= (+ (count-fib 0 7) (count-fib 1 7)) (fib (+ 7 1))))
