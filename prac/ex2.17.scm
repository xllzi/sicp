(define (last l)
  (list_ref l (- (length l) 1)))

(define (last l)
  (define (last_iter l)
    (if (null? (car (cdr l)))
      (car l)
      (last_iter (cdr l))))
  (if (null? l)
    nil
    (last_iter l)))
