;; procedural representation of pair
;; using closure than contain x y to construct pair
(define (cons x y)
  (lambda (m) (m x y)))

;; retrieve first half is apply the closure to a procedure
;; that return the first one from two argument
(define (car z)
  (z (lambda (p q) p)))

(define (cdr z)
  (z (lambda (p q) q)))
