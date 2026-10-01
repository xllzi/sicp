;; finite continue fraction
(define (cont-frac n d k)
  (define (iter i res)
    (if (< i 1)
      res
      (iter (-1+ i) (/ (n i) (+ (d i) res)))))
  (iter k 0))


;; print the iteration of an expression
(define (print k expr)
  (define (iter i) 
    (if (> i k)
      0
      (begin (display (expr i)) (newline) (iter (1+ i)))))
  (iter 1))

(print 10 (lambda (k) (cont-frac (lambda (i) 1.0)
                                 (lambda (i) 1.0)
                                 k)))
