(define (div_interval x y)
  (if (and (<= (lower_bound y) 0)
           (>= (upper_bound y) 0))
    (error "Denominator interval spans zero" y)
    (mul_interval
      x
      (make_interval (/ 1.0 (upper_bound y))
                     (/ 1.0 (lower_bound y))))))
