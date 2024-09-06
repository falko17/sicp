#lang sicp

(#%require rackunit)

(define zero (lambda (f) (lambda (x) x)))

; Exercise 2.6

(define one
  (lambda (f) (lambda (x) (f x))))

(define two
  (lambda (f) (lambda (x) (f (f x)))))

(define three
  (lambda (f) (lambda (x) (f (f (f x))))))

#| (define (+ a b) |#
#|   (lambda (f) (lambda (x) ((a (b f)) x)))) |#

; Whoops, the above appears to be multiplication, let's try again
;
(define (+ a b)
  (lambda (f) (lambda (x) ((a f) ((b f) x)))))

(check-eq? (((+ three one) inc) 0) 4)
(check-eq? (((+ one one) inc) 0) 2)
(check-eq? (((+ zero one) inc) 0) 1)
(check-eq? (((+ two three) inc) 0) 5)
(check-eq? (((+ zero zero) inc) 0) 0)
