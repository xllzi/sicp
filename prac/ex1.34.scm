(define (f g)
  (g 2))

;; eval (f f) will be error
;; because (f f) can be substituted as (f 2) and then (2 2)
;; object 2 is not applicable
