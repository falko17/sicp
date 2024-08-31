#lang sicp

(#%require rackunit)

(define (compose f g) (lambda (x) (f (g x))))

; Exercise 1.43

(define (repeated f n)
  (define (repeated-aux res i)
    (if (= i n)
        res
        (repeated-aux (compose f res) (inc i))))
  (repeated-aux f 1))

(define (square x) (* x x))

(check-eq? ((repeated square 2) 5) 625)
