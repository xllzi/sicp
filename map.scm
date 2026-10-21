;; map is a general method to apply a procedure to every element in list in order
;; abstract away the detail about how elements of list are extracted and be applied and combined
;; help us focus on what transformation does to the sequence
(define (map proc l)
  (if (null? l)
    '()
    (cons (proc (car l))
          (map proc (cdr l)))))

;; iterative version
(define (map proc l)
  (define (iter remain ans)
    (if (null? remain)
      ans
      (iter (cdr remain)
            (cons ans
                  (proc (car remain)))))))

(define (scale_list l factor)
  (map (lambda (x) (* x factor))
       l))

(define (foreach proc l)
  (if (null? l)
    #t
    (begin (proc (car l)) (foreach proc (cdr l)))))
