(define (count_leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

;; only leaf is number
(define (scale_tree tree factor)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (* tree factor))
        (else (cons (scale_tree (car tree) factor)
                    (scale_tree (cdr tree) factor)))))

(define (scale_tree tree factor)
  (map (lambda (sub_tree)
         (if (pair? sub_tree)
             (scale_tree sub_tree factor)
             (* sub_tree factor)))
       tree))

