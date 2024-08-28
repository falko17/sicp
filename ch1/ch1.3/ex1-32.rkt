#lang sicp

; Exercise 1.32

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate combiner null-value term (next a) next b))))

(define (sum term a next b) (accumulate + 0 term a next b))

(define (product term a next b) (accumulate * 1 term a next b))

(define (factorial n) (product identity 1 inc n))

(define (int-sum a b)
  (sum identity a inc b))

(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner result (term a)))))
  (iter a null-value))

(define (sum-iter term a next b) (accumulate-iter + 0 term a next b))

(define (product-iter term a next b) (accumulate-iter * 1 term a next b))

(define (factorial-iter n) (product-iter identity 1 inc n))

(define (int-sum-iter a b) (sum-iter identity a inc b))

; New approach here: I'll combine tests using and, then I just need to check whether the output is #t.
(and
 (= 120 (factorial 5))
 (= 27 (int-sum 2 7))
 (= 120 (factorial-iter 5))
 (= 27 (int-sum-iter 2 7)))


