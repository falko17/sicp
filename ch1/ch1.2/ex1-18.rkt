#lang sicp

; Exercise 1.18
; This is simply a combination of exercises 1.16 and 1.17.

(define (* a b)
  (define (halve x) (/ x 2))
  (define (double x) (+ x x))
  (define (*-aux a b c)
    (cond
      ((= b 0) c)
      ; Use b*n = 2*(a*(b/2)) = a*(2*(b/2))
      ((even? b) (*-aux (double a) (halve b) c))
      ; We can just add a into our state c.
      (else (*-aux a (- b 1) (+ c a)))))
  (*-aux a b 0))

(* 2 1)
(* 2 2)
(* 2 3)
(* 2 4)
(* 4 2)

(* 3 3)
(* 5 7)
(* 10 10)
(* 11 11)
(* 7 5)
