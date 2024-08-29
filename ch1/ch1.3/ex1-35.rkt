#lang sicp

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

; Exercise 1.35

; To show that this fixed point is a golden ratio, we just need to multiply both sides by x:
; $x = 1 + 1/x \Rightarrow x^2 = x + 1$, this latter definition is equivalent to the definition of the golden ratio.

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1) ; The result here is indeed close to phi.
