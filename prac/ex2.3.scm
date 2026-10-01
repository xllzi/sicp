;; define rectangle as 3 point
(define (rectangle a b c)
  (cons (cons a b) c))

(define (edge_x rec)
  (segment (car (car rec)) (car (cdr rec)))) 

(define (edge_y rec)
  (segment (car (car rec)) (cdr rec)))

(define (area rec)
  (* (length (edge_x rec)) (length (edge_y rec))))

(define (perimeter rec)
  (+ (length (edge_x rec)) (length (edge_y rec))))
