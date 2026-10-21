(define (fold_right op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (fold_right op intial (cdr sequence)))))

(define (fold_left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
      result
      (iter (op result (car rest))
            (cdr rest))))
  (iter initial sequence))

;; op should satify the commutativity and associativity to guarantee that fold-right and fold-left will
;; procduce the same values for any sequence
;; for sequence (a b c), op(a, op(b, c)) = op(op(a, b), c)
