;; what is the solution to x^x = 1000?
(fixed-point (lambda (x) (/ (log 1000) (log x))) 2)
