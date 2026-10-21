;; Run with: mit-scheme --quiet --load tests/rule-system.scm
;; Each check uses real matching/rewriting and hand-derived results.
(define rule-test-load-result
  (ignore-errors
   (lambda ()
     (load (merge-pathnames "../simplify.scm" (current-load-pathname))))))

(if (condition? rule-test-load-result)
    (begin
      (display "FAIL: cannot load rule system") (newline)
      (write rule-test-load-result) (newline)
      (exit 1)))

(define rule-test-count 0)
(define rule-test-failures 0)
(define (check label expected thunk)
  (let ((actual (ignore-errors thunk)))
    (set! rule-test-count (+ rule-test-count 1))
    (if (not (equal? expected actual))
        (begin
          (set! rule-test-failures (+ rule-test-failures 1))
          (display "FAIL: ") (write label)
          (display " expected ") (write expected)
          (display " got ") (write actual) (newline)))))

;; Literal/shape mismatches and a failed dictionary must stop safely.
(for-each
 (lambda (case)
   (check (car case) (cadddr case)
          (lambda () (match (cadr case) (caddr case) (empty-dictionary)))))
 '((literal + + ())
   (empty () () ())
   (different-literals + * failed)
   (pattern-list-expression-atom (+ (? x)) 3 failed)
   (pattern-atom-expression-list x (x) failed)
   (short-expression (+ (? a) (? b)) (+ x) failed)
   (long-expression (+ (? a)) (+ x y) failed)
   (constant-type (?c n) x failed)
   (variable-type (?v x) 3 failed)
   (repeated-conflict (+ (* (? a) (? b)) (? b)) (+ (* 3 x) 4) failed)))

(check 'failure-propagates 'failed
       (lambda () (match '(? x) 'anything 'failed)))
(check 'constant-binding 3
       (lambda () (lookup 'n (match '(?c n) 3 (empty-dictionary)))))
(check 'variable-binding 'x
       (lambda () (lookup 'v (match '(?v v) 'x (empty-dictionary)))))
(check 'whole-subtree '(+ x 1)
       (lambda () (lookup 'a (match '(? a) '(+ x 1) (empty-dictionary)))))
(check 'empty-binding '()
       (lambda () (lookup 'a (match '(? a) '() (empty-dictionary)))))
(check 'repeated-consistent 'x
       (lambda ()
         (lookup 'b (match '(+ (* (? a) (? b)) (? b))
                           '(+ (* 3 x) x) (empty-dictionary)))))
(check 'dictionary-not-mutated 'a
       (lambda ()
         (let ((original (empty-dictionary)))
           (match '(? a) 3 original)
           (lookup 'a original))))
(check 'existing-binding-preserved 'x
       (lambda ()
         (let ((dict (match '(? a) 'x (empty-dictionary))))
           (match '(? a) 'y dict)
           (lookup 'a dict))))

;; Instantiation distinguishes literal names, lookups, and evaluation.
(define subtree-dict (match '(? a) '(+ x 1) (empty-dictionary)))
(check 'literal-versus-lookup '(* a (+ x 1))
       (lambda () (instantiate '(* a (: a)) subtree-dict)))
(check 'lookup-whole-subtree '(+ x 1)
       (lambda () (instantiate '(: a) subtree-dict)))
(check 'instantiate-empty '()
       (lambda () (instantiate '() subtree-dict)))
(check 'arithmetic-skeleton 6
       (lambda ()
         (instantiate '(: (* a b))
                      (match '((? a) (? b)) '(3 2) (empty-dictionary)))))
(check 'operator-from-dictionary 5
       (lambda ()
         (instantiate '(: (op a b))
                      (match '((? op) (? a) (? b)) '(+ 3 2)
                             (empty-dictionary)))))
(check 'nested-arithmetic-skeleton 8
       (lambda ()
         (instantiate '(: (* a (+ b 1)))
                      (match '((? a) (? b)) '(2 3) (empty-dictionary)))))

;; These catch missed subtrees, failure to restart rules, shared rule sets,
;; and stopping immediately after instantiation.
(check 'no-rule '(f x)
       (lambda () ((simplifier '()) '(f x))))
(check 'default-simplify 'x
       (lambda () (simplify '(+ 0 (* 1 x)))))
(check 'constant-fold 14
       (lambda () (simplify '(+ 2 (* 3 4)))))
(check 'unknown-operator-unchanged '(f 2 3)
       (lambda () (simplify '(f 2 3))))
(check 'rule-order 'first
       (lambda ()
         ((simplifier '(((f (? x)) first) ((f (? x)) second))) '(f x))))
(check 'restart-complete-rule-set 'x
       (lambda ()
         ((simplifier '(((* 1 (? e)) (: e))
                        ((+ (? e) 0) (* 1 (: e))))) '(+ x 0))))
(define zero-only (simplifier '(((+ 0 (? e)) (: e)))))
(define one-only (simplifier '(((* 1 (? e)) (: e)))))
(check 'captured-zero-rules '(* 1 x)
       (lambda () (zero-only '(+ 0 (* 1 x)))))
(check 'captured-one-rules '(+ 0 x)
       (lambda () (one-only '(+ 0 (* 1 x)))))
(check 'simplify-instantiated-products '(+ x y)
       (lambda ()
         ((simplifier '(((* (? a) (+ (? b) (? c)))
                         (+ (* (: a) (: b)) (* (: a) (: c))))
                        ((* 1 (? e)) (: e)))) '(* 1 (+ x y)))))

;; Differentiation is rule data interpreted by the same engine.
(for-each
 (lambda (case)
   (check (car case) (caddr case) (lambda () (dsimp (cadr case)))))
 '((derivative-constant (d 3 x) 0)
   (derivative-same-variable (d x x) 1)
   (derivative-other-variable (d y x) 0)
   (derivative-sum (d (+ x y) x) 1)
   (derivative-product (d (* x y) x) y)
   (derivative-power (d (** x 3) x) (* 3 (** x 2)))
   (derivative-compound-base (d (** (+ x 1) 3) x) (* 3 (** (+ x 1) 2)))
   (derivative-zero-power (d (** x 0) x) 0)
   (derivative-one-power (d (** x 1) x) 1)
   (derivative-nested-power (d (** (** x 2) 3) x)
                            (* (* 3 (** (** x 2) 2)) (* 2 x)))))

(display "Rule-system checks: ") (write rule-test-count)
(display ", failures: ") (write rule-test-failures) (newline)
(exit (if (= rule-test-failures 0) 0 1))
