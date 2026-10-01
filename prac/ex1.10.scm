;; Ackermann's function
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

(define (f n) (A 0 n)) ;; 2n
(define (g n) (A 1 n)) ;; 2^n
(define (h n) (A 2 n)) ;; 2^(2^(...^2(2^2))...) for n-1 number of exponents piled up
;; the x describe the order of number of exponent
;; (A 2 n) means n-1 is in the order 2 of number of exponent
;; (A 3 n) means (A 3 n-1) is in the order 3 that describe the number of exponent of order 2
;; the asymptotic complexity of this function in terms of x is tremendous
