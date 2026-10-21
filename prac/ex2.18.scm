(define (reverse l)
  (if (null? l)
    '()
    (append (reverse (cdr l)) (list (car l)))))
;; procedure should applied on type list


;; build the reversed list with an accumulator
(define (reverse items)
  (define (iter remaining result)
    (if (null? remaining)
        result
        (iter (cdr remaining)
              (cons (car remaining) result))))
  (iter items '()))
