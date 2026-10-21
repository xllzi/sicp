;; SICP Lecture 4A: a rule set produces a specialized simplification procedure.
;; A rule is (pattern skeleton). Load matcher.scm and instantiater.scm first.

(define (pattern rule) (car rule))
(define (skeleton rule) (cadr rule))

(define (simplifier rules)
  (define (simplify exp)
    (try-rules
     (if (pair? exp)
         (map simplify exp)
         exp)))

  (define (try-rules exp)
    (define (scan remaining)
      (if (null? remaining)
          exp
          (let* ((rule (car remaining))
                 (dictionary
                  (match (pattern rule) exp (empty-dictionary))))
            (if (eq? dictionary 'failed)
                (scan (cdr remaining))
                ;; New expressions restart at the complete captured rule set.
                (simplify (instantiate (skeleton rule) dictionary))))))
    (scan rules))

  ;; Returning the procedure retains this invocation's rules (a closure).
  simplify)

;; As discussed in Lecture 4A, rules that keep matching can loop forever.
;; This interpreter stops when no rule applies, not by comparing old/new trees.
