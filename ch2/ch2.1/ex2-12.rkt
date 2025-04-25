#lang sicp

(#%require rackunit)
; (#%require racket) ; Required for thunk and exn:fail?

(define (make-interval a b) (cons a b))

(define (lower-bound x) (car x))
(define (upper-bound x) (cdr x))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x)
               (lower-bound y)))
        (p2 (* (lower-bound x)
               (upper-bound y)))
        (p3 (* (upper-bound x)
               (lower-bound y)))
        (p4 (* (upper-bound x)
               (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) 
        (upper-bound i)) 
     2))

(define (width i)
  (/ (- (upper-bound i) 
        (lower-bound i)) 
     2))

; Exercise 2.11

; percent: width / center
(define (make-center-percent c p)
  (let ((delta (* c p)))
    (make-interval (- c delta) (+ c delta))))

(define (percent i)
  (/ (width i) (center i)))

; Using the example from the introduction in 2.1.4 here.
(let ((epsilon 0.00001) (i (make-center-percent 6.8 0.1))) 
  (check-= epsilon (center i) 6.8)
  (check-= epsilon (width i) 0.68)
  (check-= epsilon (percent i) 0.1)
  (check-= epsilon (lower-bound i) (- 6.8 (* 0.1 6.8)))
  (check-= epsilon (upper-bound i) (+ 6.8 (* 0.1 6.8))))
  
