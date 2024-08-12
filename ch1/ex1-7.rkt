#lang sicp
; Exercise 1.7
; First, copied original solution:

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (average x y)
  (/ (+ x y) 2))

(define (square x) (* x x))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

; The actual sqrt of this is 0.01. However, this returns 0.32 something.
; This is because we are stopping as soon as our guess is less than 0.001 off to the actual square.
; Hence, for numbers smaller than 0.001, this will not work well.
(sqrt (square 0.01))

; For a very large number like this, IEEE 754 inaccuracies will never make this number converge.
; (Which is why I commented it out.)
; (sqrt (square (square (square 10000000))))

; "An alternative strategy for implementing good-enough? is to watch how guess changes from one iteration to the next and to stop when the change is a very small fraction of the guess. Design a square-root procedure that uses this kind of end test. Does this work better for small and large numbers?"
; Let's see:

(define (good-enough2? guess oldguess)
  (< (abs (- guess oldguess)) 0.00001))

(define (sqrt-iter2 guess oldguess x)
  (if (good-enough2? guess oldguess)
      guess
      (sqrt-iter2 (improve guess x) guess x)))

(define (sqrt2 x)
  (sqrt-iter2 1.0 0.0 x))

; Small numbers work:
(sqrt2 (square 0.01))
(sqrt2 (square 0.00001))

; Big numbers:
(sqrt2 (square (square (square 10000000))))

; One chapter later they explain nested functions which would have helped with the modularization here... Oh well.
