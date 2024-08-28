#lang sicp

(#%require rackunit)

(define (next x) (if (= 2 x) 3 (+ x 2)))

(define (square x) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n)
         n)
        ((divides? test-divisor n)
         test-divisor)
        (else (find-divisor
               n
               (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

; Exercise 1.33

(define (filtered-accumulate combiner null-value term a next b predicate)
  (define (next-where x)
    ; Slightly inefficient (calculating next twice, but don't want to write another procedure
    (if (predicate (next x)) (next x) (next-where (next x))))
  (define (iter a result)
    (if (> a b)
        result
        (iter (next-where a) (combiner result (term a)))))
  (iter a null-value))

(define (prime-square-sum a b)
  (filtered-accumulate + 0 square a inc b prime?))

; I don't have the patience to implement GCD right now, I'll just use the one provided by sicp.
(define (rel-prime-fac n)
  (define (coprime x) (= 1 (gcd x n)))
  (filtered-accumulate * 1 identity 1 inc (dec n) coprime))

; Also, rackunit is much more convenient than the `and` approach I've used in the last exercise.
(check-eq? (prime-square-sum 1 15)
           ; I wish we had lists...
           (+ 1 (square 2) (square 3) (square 5) (square 7) (square 11) (square 13)))
(check-eq? (rel-prime-fac 10) (* 1 3 7 9))
