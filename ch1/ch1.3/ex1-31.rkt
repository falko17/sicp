#lang sicp

; Exercise 1.31

(define (product term a next b)
  (if (> a b)
      1
      (* (term a) (product term (next a) next b))))

(define (factorial n) (product identity 1 inc n))

(factorial 5) ; => 120

(define (square x) (* x x))

(define (approx-pi n)
  (define (next x) (+ x 2))
  (define (term x) (/ (* x (next x)) (square (inc x))))
  (product term 2 next n))

(* 4.0 (approx-pi 1000)) ; => close to pi

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b) result (iter (next a) (* (term a) result))))
  (iter a 1))

(define (factorial-iter n) (product-iter identity 1 inc n))

(define (approx-pi-iter n)
  (define (next x) (+ x 2))
  (define (term x) (/ (* x (next x)) (square (inc x))))
  (product-iter term 2 next n))


(factorial-iter 5)
(* 4.0 (approx-pi-iter 1000))
; Same results!
