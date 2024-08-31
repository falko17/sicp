#lang sicp

(#%require rackunit)

; Exercise 1.39

(define (tan-cf x k)
  (define (tan-cf-aux r i)
    (cond
      ((= i 1) (/ x (- 1 r)))
      (else (tan-cf-aux (/ (* x x) (- (+ 1.0 (* 2 (dec i))) r)) (dec i)))))
  (tan-cf-aux 0 k))

(define (verify-tan x) (check-within (tan x) (tan-cf x 20) 0.0001))

(verify-tan 0)
(verify-tan 0.5)
(verify-tan 1)
(verify-tan 2)
(verify-tan 5)
(verify-tan 10)
(verify-tan -1)
(verify-tan -2)
(verify-tan -5)
(verify-tan -10)
