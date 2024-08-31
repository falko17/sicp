#lang sicp

(#%require rackunit)

(define (compose f g) (lambda (x) (f (g x))))

(define (repeated f n)
  (define (repeated-aux res i)
    (if (= i n)
        res
        (repeated-aux (compose f res) (inc i))))
  (repeated-aux f 1))

; Exercise 1.44

(define dx 0.00001)

(define (smooth f) (lambda (x) (/ (+ (f x) (f (- x dx)) (f (+ x dx))) 3)))

(check-within ((smooth sin) 2) (sin 2) 0.0001)
(check-not-equal? ((smooth sin) 2) (sin 2))

(define (n-smooth f n) ((repeated smooth n) f))

(check-equal? ((n-smooth sin 1) 2) ((smooth sin) 2))
(check-equal? ((n-smooth sin 3) 2) ((smooth (smooth (smooth sin))) 2))
