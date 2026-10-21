(define (exponentiation? x)
  (and (pair? x) (eq? (car x) '**)))

(define (base x) (cadr x))

(define (exponent x) (caddr x))

(define (make_exponentiation b n)
  (cond ((and (number? n) (= n 0)) 1)
        ((and (number? n) (= n 1)) b)
        (else (list '** b n))))

;; (define (deriv exp var)
;;   (cond ((number? exp) 0)
;;         ((variable? exp)
;;          (if (same_variable? exp var) 1 0))
;;         ((sum? exp)
;;          (make_sum (deriv (addend exp) var)
;;                    (deriv (augend exp) var)))
;;         ...

(define (deriv_exponentiation x v)
  (make_product (make_product (exponent x) (make_exponentiation (base x) (- (exponent x) 1)))
                (deriv (base x) v)))
