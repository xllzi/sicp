(define (list_ref l n)
  (if (= n 0)
    (car items)
    (list_ref (cdr l) (- n 1))))

(define (length l)
  (if (null? l)
    0
    (+ 1 (length (cdr l)))))

(define (append l1 l2)
  (if (null? l1)
    l2
    (cons (car l1) (append (cdr l1) l2))))
