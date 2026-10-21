(define (filter predicate sequence)
  (cond ((null? sequence) '())
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (accumulate op intial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op intial (cdr sequence)))))

(define (enumerate_interval low high)
  (if (> low high)
    nil
    (cons low (enumerate_interval (+ low 1) high))))

(define (enumerate_tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate_tree (car tree))
                      (enumerate_tree (cdr tree))))))

(define (sum_odd_squares tree)
  (accumulate + 0
              (map square 
                   (filter odd?
                           (enumerate_tree tree)))))

