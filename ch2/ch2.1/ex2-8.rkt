#lang sicp

(#%require rackunit)

(define (make-interval a b) (cons a b))

(define (lower-bound x) (car x))
(define (upper-bound x) (cdr x))

; Exercise 2.8

; The minimum the resulting interval could be is the lower interval subtracted by the upper interval.
; Conversely, the maximum it could be is the upper interval subtractedby the lower one.

(define (sub-interval x y)
  (make-interval
   (- (lower-bound x) (upper-bound y))
   (- (upper-bound x) (lower-bound y))))

(let
    ((interval1 (make-interval 3 4))
     (interval2 (make-interval 7 10)))
  (check-equal?
   (sub-interval interval2 interval1) (make-interval 3 7)))

