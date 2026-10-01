(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))
;; applicative-order evalution make p evaluted first before application
;; which cause p infinite recursive define
