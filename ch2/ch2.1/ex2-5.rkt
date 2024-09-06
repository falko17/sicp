#lang sicp

(#%require rackunit)

; Exercise 2.5

(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (car x)
  (define (car-iter r i)
    (if (= (modulo (/ x r) 2) 1)
        i
        (car-iter (* r 2) (inc i))))
  (car-iter 1 0))

(define (cdr x)
  (log (/ x (expt 2 (car x))) 3))

(define tolerance 0.0000001)

(let ((num1 (cons 1 2))
      (num2 (cons 0 0))
      (num3 (cons 3 8))
      (num4 (cons 5 0))
      (num5 (cons 0 5)))
  (check-within (car num1) 1 tolerance)
  (check-within (car num2) 0 tolerance)
  (check-within (car num3) 3 tolerance)
  (check-within (car num4) 5 tolerance)
  (check-within (car num5) 0 tolerance)
  (check-within (cdr num1) 2 tolerance)
  (check-within (cdr num2) 0 tolerance)
  (check-within (cdr num3) 8 tolerance)
  (check-within (cdr num4) 0 tolerance)
  (check-within (cdr num5) 5 tolerance))


