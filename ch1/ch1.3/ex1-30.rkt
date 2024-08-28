#lang sicp

; Exercise 1.30

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result))))
  (iter a 0))

(define (int-sum a b)
  (sum identity a inc b))

(int-sum 1 10)
(int-sum 2 7)

; Seems to work! Compared to previous iterative exercises, this luckily wasn't too hard.
