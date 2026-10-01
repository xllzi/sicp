(define (midpoint_segment s)
  (make_point (/ (+ (x_point (start_segment s)) (x_point (end_segment s))) 2)
         (/ (+ (y_point (start_segment s)) (y_point (end_segment s))) 2)))
