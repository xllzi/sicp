(define (width i)
  (/ (- (upper_bound i) (lower_bound i)) 2))

;; the width of result of add(sub) two intervals is a function only of 
;; width of the argument intervals
(assert (let ((x (make_interval 1 2))
              (y (make_interval 3 4)))
          (= (width (add_interval x y)) (+ (width x) (width y)))))
