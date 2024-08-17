#lang sicp
; Exercise 1.16

(define (expt-iter b n)
  (define (square x) (* x x))
  (define (expt-iter-aux b n a)
    (cond
      ((= n 0) a)
      ; Use b^n = (b^2)^(n/2)
      ; (this part took some time to figure out, despite the solution being infuriatingly simple...)
      ((even? n) (expt-iter-aux (square b) (/ n 2) a))
      ; We can just multiply b into our state a.
      (else (expt-iter-aux b (- n 1) (* a b)))))

  (expt-iter-aux b n 1))

(expt-iter 2 2)
(expt-iter 2 3)
(expt-iter 2 4)

(expt-iter 3 0)
(expt-iter 3 1)
(expt-iter 3 2)
(expt-iter 3 3)
(expt-iter 3 4)
(expt-iter 3 5)

(expt-iter 10 9)
(expt-iter 10 10)
(expt-iter 10 11)
(expt-iter 10 12)
(expt-iter 10 13)
