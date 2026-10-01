;; define if as a procedure using cond
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))
;; it would be the same of `if`
;; because `if` as a special form have special evalution rule than ordinal procedure
;; Scheme only evalute one of the branches
;; By this way, Scheme implement this form of conditional control flow
