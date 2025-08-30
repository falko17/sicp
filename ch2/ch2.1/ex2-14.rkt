#lang sicp

(#%require rackunit)
(#%require racket) ; Required for thunk and exn:fail?
; (#%require racket/format)

(define (make-interval a b) (cons a b))

(define (lower-bound x) (car x))
(define (upper-bound x) (cdr x))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

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

(define (sgn x)
  (cond ((= x 0) 0) ((> x 0) 1) (else -1)))

(define (spans-zero? x)
  (or (not (= (sgn (lower-bound x)) (sgn (upper-bound x))))
      (= (lower-bound x) 0)
      (= (upper-bound x) 0)))


(define (div-interval x y)
  (if (spans-zero? y)
      (error "Cannot divide by interval spanning zero.")
      (mul-interval x
                    (make-interval
                     (/ 1.0 (upper-bound y))
                     (/ 1.0 (lower-bound y))))))

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

(define (make-center-percent c p)
  (let ((delta (* c p)))
    (make-interval (- c delta) (+ c delta))))

(define (percent i)
  (/ (width i) (center i)))

(define (par1 r1 r2)
  (div-interval
   (mul-interval r1 r2)
   (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval 
     one
     (add-interval 
      (div-interval one r1) 
      (div-interval one r2)))))

; Exercise 2.14

(define (demonstrate r)
  (let ((c (center r)) (p (percent r))) 
    (println (string-append (number->string c) " +- " (number->string (* p 100)) "%  (" (number->string(lower-bound r)) ", " (number->string (upper-bound r)) ")"))))

(let ((i1 (make-center-percent 4 0.01)) (i2 (make-center-percent 16 0.01)) (one (make-interval 1 1)))
  (demonstrate (make-interval 62.7264 65.2864))
  (demonstrate (par1 i1 i2))
  (demonstrate (par2 i1 i2))
    ; See ex2-15.rkt
  (demonstrate (div-interval i1 i1))
  (demonstrate (div-interval (make-center-percent 4 0.02) (make-center-percent 4 0.07)))
  (demonstrate (make-interval (/ 1.0 (upper-bound i1)) (/ 1.0 (lower-bound i1)))))

; Floating-point inaccuracies seem to pile up here.

