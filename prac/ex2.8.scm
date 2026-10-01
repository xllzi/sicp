(define (sub_interval x y)
  (make_interval (- (lower_bound x) (upper_bound y))
                 (- (upper_bound x) (lower_bound y))))

