(define (sigma a b term next)
  (if (> a b)
      0
      (+ (term a) (sigma (next a) b term))))

(define (sum a b)
  (sigma a b (lambda (x) x) 1+))

;; iterative version of sigma procedure
(define (sigma a b term next)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (+ result (term a)))))
  (iter a 0))

;; a more general method to accumulate values
(define (accumulate combiner null-value a b term next)
  (if (> a b)
    null-value
    (combiner (term a) (accumulate combiner null-value (next a) b term next))))
