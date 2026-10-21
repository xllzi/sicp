;; SICP Lecture 4A: instantiate a skeleton using a matched dictionary.
;; Load matcher.scm first, or use the simplify.scm entry point.
;; (: name) substitutes data; (: (* a b)) evaluates a small arithmetic form.

(define (skeleton-evaluation? skeleton)
  (and (pair? skeleton) (eq? (car skeleton) ':)))

(define (evaluation-expression skeleton) (cadr skeleton))

;; Keep evaluation explicit and small so the interpreter remains readable.
;; This replaces the lecture's lookup of procedures in a Scheme environment.
(define rule-evaluation-operators
  (list (cons '+ +) (cons '- -) (cons '* *) (cons '/ /)
        (cons 'expt expt) (cons '** expt)))

(define (evaluate form dictionary)
  (if (atom? form)
      ;; Return a bound expression as data, without evaluating its contents.
      (lookup form dictionary)
      (let* ((name (lookup (car form) dictionary))
             (operator (assq name rule-evaluation-operators)))
        (if operator
            (apply (cdr operator)
                   (map (lambda (argument) (evaluate argument dictionary))
                        (cdr form)))
            (error "Unknown skeleton arithmetic operator" name)))))

(define (instantiate skeleton dictionary)
  (define (walk s)
    (cond ((atom? s) s)
          ;; Recognize (: ...) before ordinary list reconstruction.
          ((skeleton-evaluation? s)
           (evaluate (evaluation-expression s) dictionary))
          (else
           (cons (walk (car s)) (walk (cdr s))))))
  (walk skeleton))
