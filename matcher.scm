;; SICP Lecture 4A: pattern matching and persistent binding dictionaries.
;; Source: MIT OCW 4A, transcript PDF pages 6-12.
;; Patterns: (? name) any expression, (?c name) number, (?v name) symbol.

(define (atom? x) (not (pair? x)))

(define (pattern-tagged? pattern tag)
  (and (pair? pattern) (eq? (car pattern) tag)))

(define (arbitrary-constant? pattern) (pattern-tagged? pattern '?c))
(define (arbitrary-variable? pattern) (pattern-tagged? pattern '?v))
(define (arbitrary-expression? pattern) (pattern-tagged? pattern '?))
(define (pattern-variable-name pattern) (cadr pattern))

(define (empty-dictionary) '())

(define (lookup name dictionary)
  (let ((entry (assq name dictionary)))
    ;; Unbound names remain literal; this also preserves numeric literals.
    (if entry (cdr entry) name)))

(define (extend-dictionary pattern datum dictionary)
  (let* ((name (pattern-variable-name pattern))
         (entry (assq name dictionary)))
    (cond (entry
           ;; Repetition is allowed only when the earlier binding agrees.
           (if (equal? (cdr entry) datum) dictionary 'failed))
          (else
           ;; Return a new dictionary; failed matches cannot mutate old ones.
           (cons (cons name datum) dictionary)))))

(define (match pattern expression dictionary)
  (cond ((eq? dictionary 'failed) 'failed)
        ((arbitrary-constant? pattern)
         (if (number? expression)
             (extend-dictionary pattern expression dictionary)
             'failed))
        ((arbitrary-variable? pattern)
         (if (symbol? expression)
             (extend-dictionary pattern expression dictionary)
             'failed))
        ((arbitrary-expression? pattern)
         (extend-dictionary pattern expression dictionary))
        ((atom? pattern)
         (if (and (atom? expression) (equal? pattern expression))
             dictionary
             'failed))
        ((atom? expression) 'failed)
        (else
         ;; The cdr match sees bindings (or failure) from the car match.
         (match (cdr pattern)
                (cdr expression)
                (match (car pattern) (car expression) dictionary)))))
