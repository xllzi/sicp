(define (make_rat n d)
  (let (g (gcd n d))
    (cons (/ n g)
          (/ d g))))

(define (numer rat)
  (car rat))

(define (demon rat)
  (cdr rat))

(define (add_rat x y)
  (make_rat (+ (* (numer x) (demon y)) (* (numer y) (demon x)))
            (* (demon x) (demon y)))) 

;; make_rat, numer, demon compose an abstranction barrier 
;; seperate the use of data object and object representation

