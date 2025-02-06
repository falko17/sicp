#lang sicp

(#%require rackunit)
(#%require racket/trace)

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

(define (sgn x) (if (< x 0) -1 1))

; Possibilities (+ - within one interval is impossible):
; [+ + | + +] => [E1.l * E2.l, E1.h * E2.h]
; [- - | - -] => [E1.h * E2.h, E1.l * E2.l]
; [+ + | - -] => [E1.h * E2.l, E1.l * E2.h]
; [- - | + +] => [E1.l * E2.h, E1.h * E2.l]
; [- + | + +] => [E1.l * E2.h, E1.h * E2.h]
; [+ + | - +] => [E1.h * E2.l, E1.h * E2.h]
; [- + | - -] => [E1.h * E2.l, E1.l * E2.l]
; [- - | - +] => [E1.l * E2.h, E1.l * E2.l]
; [- + | - +] => [min(E1.h * E2.l, E1.l * E2.h), max(E1.l * E2.l, E1.h * E2.h)]
(define (mul-interval-fast x y)
  (let ((s1 (sgn (lower-bound x)))
        (s2 (sgn (upper-bound x)))
        (s3 (sgn (lower-bound y)))
        (s4 (sgn (upper-bound y)))
        (l1 (lower-bound x))
        (h1 (upper-bound x))
        (l2 (lower-bound y))
        (h2 (upper-bound y)))
    (cond
      ((= s1 s2 s3 s4 1) (make-interval (* l1 l2) (* h1 h2)))
      ((= s1 s2 s3 s4 -1) (make-interval (* h1 h2) (* l1 l2)))
      ((and (= s1 s2 1) (= s3 s4 -1)) (make-interval (* h1 l2) (* l1 h2)))
      ((and (= s1 s2 -1) (= s3 s4 1)) (make-interval (* l1 h2) (* h1 l2)))
      ((and (= s1 -1) (= s2 s3 s4 1)) (make-interval (* l1 h2) (* h1 h2)))
      ((and (= s3 -1) (= s1 s2 s4 1)) (make-interval (* h1 l2) (* h1 h2)))
      ((and (= s2 1) (= s1 s3 s4 -1)) (make-interval (* h1 l2) (* l1 l2)))
      ((and (= s4 1) (= s1 s2 s3 -1)) (make-interval (* l1 h2) (* l1 l2)))
      ((and (= s1 s3 -1) (= s2 s4 1)) (make-interval (min (* l1 h2) (* h1 l2)) (max (* l1 l2) (* h1 h2))))
      (else (error "Impossible case")))))

(let ((ipos (make-interval 2 3))
      (ineg (make-interval -7 -5))
      (inegpos (make-interval -11 13)))
  (check-equal? (mul-interval-fast ipos ipos) (mul-interval ipos ipos))
  (check-equal? (mul-interval-fast ineg ineg) (mul-interval ineg ineg))
  (check-equal? (mul-interval-fast ipos ineg) (mul-interval ipos ineg))
  (check-equal? (mul-interval-fast inegpos ipos) (mul-interval inegpos ipos))
  (check-equal? (mul-interval-fast ipos inegpos) (mul-interval ipos inegpos))
  (check-equal? (mul-interval-fast inegpos ineg) (mul-interval inegpos ineg))
  (check-equal? (mul-interval-fast ineg inegpos) (mul-interval ineg inegpos))
  ; This last check is not exhaustive, but I don't want to write a full extensive test suite here.
  ; This is just a spot check.
  (check-equal? (mul-interval-fast inegpos inegpos) (mul-interval inegpos inegpos)))
