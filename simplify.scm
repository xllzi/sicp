;; Entry point: (load "simplify.scm")
;; MIT Scheme resolves the support files relative to this file, not the REPL cwd.
;; This is a learning implementation of SICP Lecture 4A, not a complete CAS.
;; Reference: https://ocw.mit.edu/courses/6-001-structure-and-interpretation-of-computer-programs-spring-2005/resources/4a-pattern-matching-and-rule-based-substitution/

(load (merge-pathnames "matcher.scm" (current-load-pathname)))
(load (merge-pathnames "instantiater.scm" (current-load-pathname)))
(load (merge-pathnames "simplifier.scm" (current-load-pathname)))

;; Rules are data. Keep distribution and commutativity out of this default set:
;; expanding or swapping terms does not necessarily move toward a normal form.
(define algebra-rules
  '(((+ 0 (? e)) (: e))
    ((+ (? e) 0) (: e))
    ((* 0 (? e)) 0)
    ((* (? e) 0) 0)
    ((* 1 (? e)) (: e))
    ((* (? e) 1) (: e))
    ((** (? e) 0) 1)
    ((** (? e) 1) (: e))
    ((+ (?c a) (?c b)) (: (+ a b)))
    ((- (?c a) (?c b)) (: (- a b)))
    ((* (?c a) (?c b)) (: (* a b)))
    ((/ (?c a) (?c b)) (: (/ a b)))
    ((** (?c a) (?c b)) (: (expt a b)))))

(define simplify (simplifier algebra-rules))

;; The same interpreter can differentiate by rewriting (d expression variable).
;; For the power rule, n is a numeric constant; all operations are binary.
(define derivative-rules
  '(((d (?c c) (?v v)) 0)
    ((d (?v v) (?v v)) 1)
    ((d (?v u) (?v v)) 0)
    ((d (+ (? u) (? v)) (?v x))
     (+ (d (: u) (: x)) (d (: v) (: x))))
    ((d (* (? u) (? v)) (?v x))
     (+ (* (: u) (d (: v) (: x)))
        (* (d (: u) (: x)) (: v))))
    ((d (** (? u) (?c n)) (?v x))
     (* (* (: n) (** (: u) (: (- n 1))))
        (d (: u) (: x))))))

(define dsimp (simplifier (append derivative-rules algebra-rules)))

;; Examples (not run on load):
;; (simplify '(+ 0 (* 1 x)))       => x
;; (dsimp '(d (** x 3) x))         => (* 3 (** x 2))
;; (dsimp '(d (+ (* x x) 3) x))    => (+ x x)
