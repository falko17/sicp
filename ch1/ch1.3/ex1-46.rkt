#lang sicp

(#%require rackunit)

; Exercise 1.46

(define (iterative-improve good-enough? improve)
  (define (iterative-improve-aux guess)
    (if (good-enough? guess) guess (iterative-improve-aux (improve guess))))
  iterative-improve-aux)

(define (square x) (* x x))
(define (average a b) (/ (+ a b) 2))

; Here's our new sqrt-iter:
(define (sqrt-iter x)
  ((iterative-improve
    (lambda (guess) (< (abs (- (square guess) x)) 0.001))
    (lambda (guess) (average guess (/ x guess))))
   1.0))

(define tolerance 0.0001)

(check-within (sqrt-iter 4) 2 tolerance)
(check-within (sqrt-iter 2) (sqrt 2) tolerance)
(check-within (sqrt-iter 9) 3 tolerance)

; And here's our new fixed-point:

(define (fixed-point f first-guess)
  ((iterative-improve
    ; I struggled way too long to put the parens in the correct place here...
    (lambda (guess) (< (abs (- guess (f guess))) tolerance))
    (lambda (guess) (f guess)))
   first-guess))


(check-within (fixed-point cos 1.0) .73908 tolerance)
(check-within (fixed-point (lambda (y) (+ (sin y) (cos y))) 1.0) 1.25873 tolerance)

