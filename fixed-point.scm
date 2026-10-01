;; fixed-point iteratively apply lambda function on start point
;; util reach the fixed-point where f(x) = x (approximately)
(define (fixed-point f start)
  (define (close-enuf? u v)
    (define delta 0.0001)
      (< (abs (- u v)) delta))
  (define (iter prev next)
    (if (close-enuf? prev (begin (display next) (newline) next))
      next
      (iter next (f next))))
  (iter start (f start)))

(define (sqrt x)
  (fixed-point (lambda y (average (/ x y) y)) 1))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y)))
               1)

;; find zero-point x for function f such that f(x) = 0 (approximately)
(define (newton f guess)
  (fixed-point
    (lambda (x) (- x (/ (f x) ((deriv f) x))))
    guess))

(define (deriv f)
  (let ((dx 0.0001))
    (lambda (x)
      (/ (- (f (+ x dx))
            (f x))
         dx))))

(define (sqrt x)
  (newton (lambda (y) (- x (square y))) 1))
