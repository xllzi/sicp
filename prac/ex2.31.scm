(define (tree_map proc tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (proc tree))
        (else (cons (tree_map proc (car tree))
                    (tree_map proc (cdr tree))))))

(define (square_tree tree) (tree_map square tree))
