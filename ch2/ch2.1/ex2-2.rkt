#lang sicp

; Exercise 2.2

(define (make-segment start end) (cons start end))
(define (start-segment segment) (car segment))
(define (end-segment segment) (cdr segment))

(define (make-point x y) (cons x y))
(define (x-point point) (car point))
(define (y-point point) (cdr point))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define (average a b) (/ (+ a b) 2.0))

(define (midpoint-segment segment)
  (make-point
   (average (x-point (start-segment segment))
            (x-point (end-segment segment)))
   (average (y-point (start-segment segment))
            (y-point (end-segment segment)))))

; Let's check:
(print-point (midpoint-segment (make-segment (make-point 1 2) (make-point 3 4)))) ; => (2,3)
