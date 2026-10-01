(define (search f neg-point pos-point)
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
      midpoint
      (let ((test-value (f midpoint)))
        (cond ((positive? test-value)
               (search f neg-point midpoint))
              ((negative? test-value)
               (search f midpoint pos-point))
              (else midpoint)))))))

;; use half-interval method to find the zero-point of f in [a, b]
;; based on a more general procedure similar to binary search
(define (half-interval f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
           (search f a b))
          ((and (negative? b-value) (negative? a-value))
           (search f b a))
          (else
            (error "Values are not of opposite sign" a b)))))
