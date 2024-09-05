#lang sicp

(#%require rackunit)

; Exercise 2.1

(define (make-rat n d)
  (define (sign x) (if (< x 0) -1 1))
  (let ((g (gcd n d))
        ; Rational number is positive if either both n and d are positive, or if both are negative.
        (pos (= (sign n) (sign d))))
    (cons
     (/ (if pos (abs n) (* -1 (abs n))) g)
     (/ (abs d) g))))

(define (numer x) (car x))
(define (denom x) (cdr x))

(let ((num (make-rat 2 7)))
  (check-eq? (numer num) 2)
  (check-eq? (denom num) 7))

(let ((num (make-rat -2 7)))
  (check-eq? (numer num) -2)
  (check-eq? (denom num) 7))

(let ((num (make-rat 2 -7)))
  (check-eq? (numer num) -2)
  (check-eq? (denom num) 7))

(let ((num (make-rat -2 -7)))
  (check-eq? (numer num) 2)
  (check-eq? (denom num) 7))

(let ((num (make-rat -3 -9)))
  (check-eq? (numer num) 1)
  (check-eq? (denom num) 3))

(let ((num (make-rat 3 -9)))
  (check-eq? (numer num) -1)
  (check-eq? (denom num) 3))
