#lang sicp
; Exercise 1.8
;
; Using improved version from 1.7:


(define (good-enough? guess oldguess)
  (< (abs (- guess oldguess)) 0.00001))

(define (cbrt-iter guess oldguess x)
  (if (good-enough? guess oldguess)
      guess
      (cbrt-iter (improve guess x) guess x)))

(define (improve guess x) (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))

(define (cbrt x)
  (cbrt-iter 1.0 0.0 x))

(define (cube x) (* x x x))

; Testing:

(cbrt 27)
(cbrt 8)

; Small numbers:
(cbrt (cube 0.01))
(cbrt (cube 0.00001))

; Big numbers:
(cbrt (cube (cube (cube 10000000))))
