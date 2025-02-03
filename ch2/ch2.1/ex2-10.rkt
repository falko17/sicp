#lang sicp

(#%require rackunit)
(#%require racket) ; Required for thunk and exn:fail?

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

; Exercise 2.10

(define (sgn x)
  (cond ((= x 0) 0) ((> x 0) 1) (else -1)))

(define (spans-zero? x)
  (or (not (= (sgn (lower-bound x)) (sgn (upper-bound x))))
      (= (lower-bound x) 0)
      (= (upper-bound x) 0)
      ))

(define (div-interval x y)
  (if (spans-zero? y)
      (error "Cannot divide by interval spanning zero.")
      (mul-interval x
                    (make-interval
                     (/ 1.0 (upper-bound y))
                     (/ 1.0 (lower-bound y))))))

(check-not-exn (thunk (div-interval (make-interval 1 2) (make-interval 1 2))))
(check-not-exn (thunk (div-interval (make-interval 1 2) (make-interval 2 4))))
(check-not-exn (thunk (div-interval (make-interval -1 -2) (make-interval -1 -2))))
(check-not-exn (thunk (div-interval (make-interval 1 1) (make-interval 1 1))))
(check-not-exn (thunk (div-interval (make-interval -1 -1) (make-interval -1 -1))))
(check-not-exn (thunk (div-interval (make-interval -1 -1) (make-interval 1 1))))
(check-not-exn (thunk (div-interval (make-interval 1 1) (make-interval -1 -1))))
(check-not-exn (thunk (div-interval (make-interval -1 1) (make-interval -1 -1))))
(check-not-exn (thunk (div-interval (make-interval 0 1) (make-interval 1 2))))
(check-not-exn (thunk (div-interval (make-interval 0 0) (make-interval 2 4))))

(check-exn exn:fail? (thunk (div-interval (make-interval 1 2) (make-interval -1 1))))
(check-exn exn:fail? (thunk (div-interval (make-interval 1 2) (make-interval 0 1))))
(check-exn exn:fail? (thunk (div-interval (make-interval 1 2) (make-interval -1 0))))
(check-exn exn:fail? (thunk (div-interval (make-interval 1 2) (make-interval 0 0))))
