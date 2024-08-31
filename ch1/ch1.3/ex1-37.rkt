#lang sicp

(#%require rackunit)

; Exercise 1.37

(define (cont-frac n d k)
  (define (cont-frac-aux i)
    (if (> i k) 0 (/ (n i) (+ (d i) (cont-frac-aux (inc i))))))
  (cont-frac-aux 1))

; Now, let's approximate phi. Actual phi is 1.61803 (and so on).
; Actually, instead of trying this manually, it would be more fun to do it automatically, so let's try.

(define (steps-accurate f target target-accuracy k)

  (define (accurate? current)
    (< (abs (- current target)) target-accuracy))

  (let ((current (f k)))
    (display k)
    (display ": ")
    (display current)
    (newline)
    (if (accurate? current)
        k
        (steps-accurate f target target-accuracy (inc k)))))

(steps-accurate (lambda (k) (cont-frac (lambda (_) 1.0) (lambda (_) 1.0) k))
                (/ 1 1.61803)
                0.0001
                1)

; So, we need exactly 10 steps to reach an accuracy of four decimal points.

; Finally, the iterative version:

(define (cont-frac-iter n d k)
  (define (cont-frac-iter-aux r i)
    ; We will basically start "at the bottom" (n_k / d_k) and then work upwards.
    (if (= i 0)
        r
        (cont-frac-iter-aux (/ (n i) (+ (d i) r)) (dec i))))
  (cont-frac-iter-aux 0 k))

(check-within
 (cont-frac-iter (lambda (_) 1.0) (lambda (_) 1.0) 10)
 (/ 1 1.61803)
 0.0001)
