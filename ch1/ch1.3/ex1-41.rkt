#lang sicp

; Exercise 1.41

(define (double f) (lambda (x) (f (f x))))

((double inc) 5) ; => 7
((double (lambda (x) (* x x))) 2) ; => 16

; Expectation: (double double) applies its function four times, hence double that applies its function eight times, so I'd expect 5+8 = 13 here.
(((double (double double)) inc) 5) ; => 21

; Hm, well, let's think about this, I probably missed something.
((double (double (double inc))) 5) ; => 13

; Okay, good to know—so what's different between these two?
; (double double) returns a procedure that applies its function four times, that much should still be true.
; Ah, I think I see now. The function that's applied four times here isn't inc, it's double!
; So we actually double twice first:
; (double double) => (double (double x))
; Now, if we call double on this again, we get:
; (double (double double)) => (double (double (double (double x))))
; So in total, we have four doublings here, which means 2^4 applications of inc, so actually 16.
