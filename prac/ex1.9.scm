;; recursive process of addition
(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))

;; interative process of addition
(define (+ a b)
  (if (= a 0)
      a
      (+ (dec a) (inc b))))
