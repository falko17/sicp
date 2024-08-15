#lang sicp

#|
Exercise 1.11: A function f
 is defined by the rule that f(n)=n if n<3
 and f(n)=f(n−1)+2f(n−2)+3f(n−3) if n≥3.

Write a procedure that computes f
 by means of a recursive process. Write a procedure that computes f
 by means of an iterative process.
|#

(define (f-rec n)
  (if (< n 3)
      n
      (+ (f-rec (- n 1))
         (* 2 (f-rec (- n 2)))
         (* 3 (f-rec (- n 3))))))

(f-rec 2)
(f-rec 3)
(f-rec 10)
(f-rec 25)


; f as an iterative procedure (where a is f(n), b is f(n-1), and c is f(n-2))
; a = a + 2*b + 3*c
; b = a
; c = b
(define (f-iter n)
  (define (f-iter-help n a b c)
    (if (= n 0)
        a
        (f-iter-help (- n 1) (+ a (* 2 b) (* 3 c)) a b)))
  (if (< n 3)
      n
      (f-iter-help (- n 2) 2 1 0)))


(f-iter 2)
(f-iter 3)
(f-iter 10)
(f-iter 25)
(f-iter 100)
