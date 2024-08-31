#lang sicp

(#%require rackunit)

; Iterative version copied over from 1.37:
(define (cont-frac n d k)
  (define (cont-frac-aux r i)
    (if (= i 0)
        r
        (cont-frac-aux (/ (n i) (+ (d i) r)) (dec i))))
  (cont-frac-aux 0 k))

; Exercise 1.38

(define e 2.71828)

(check-within
 (cont-frac
  (lambda (_) 1)
  (lambda (i) (if (= (remainder (inc i) 3) 0) (* 2 (/ (inc i) 3)) 1.0))
  10)
 (- e 2) 0.0001)
