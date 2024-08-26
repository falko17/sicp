#lang sicp

; Exercise 1.27

(define (square x) (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder 
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder 
          (* base (expmod base (- exp 1) m))
          m))))

(define (fast-prime-full? n)
  (define (fast-prime-full-aux? n a)
    (cond ((>= a n) true)
          ((= (expmod a n n) a) 
           (fast-prime-full-aux? n (inc a)))
          (else false)))
  (fast-prime-full-aux? n 1))

; There are 255 Carmichael numbers below 100,000,000. The smallest few are 561, 1105, 1729, 2465, 2821, and 6601.
(fast-prime-full? 50) ; Just to make sure the test works at all.
(fast-prime-full? 561)
(fast-prime-full? 1105)
(fast-prime-full? 1729)
(fast-prime-full? 2465)
(fast-prime-full? 2821)
(fast-prime-full? 6601)

; Output is as expected: Carmichael numbers fool the Fermat test!
