#lang sicp

(#%require rackunit)

(define (average a b) (/ (+ a b) 2))

(define (average-damp f)
  (lambda (x)
    (average x (f x))))

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (compose f g) (lambda (x) (f (g x))))

(define (repeated f n)
  (define (repeated-aux res i)
    (if (= i n)
        res
        (repeated-aux (compose f res) (inc i))))
  (repeated-aux f 1))

; Exercise 1.45

; So, let's start with experimenting how many damps we need.
; We know for n=1 it's 0, for n=2 and n=3 it's 1, and for n=4 it's 2.

(define (pow b e)
  (define (pow-iter remaining result)
    (if (= remaining 0)
        result
        (pow-iter (dec remaining) (* result b))))

  (pow-iter e 1))

; Just to make sure I didn't screw up the pow implementation:
(check-equal? (pow 2 4) 16)
(check-equal? (pow 3 3) 27)

(define (nth-root-fixed-point n x)
  (lambda (y) (/ x (pow y (dec n)))))

(fixed-point (average-damp (nth-root-fixed-point 2 10)) 1.0)
(fixed-point (average-damp (nth-root-fixed-point 3 10)) 1.0)
(fixed-point ((repeated average-damp 2) (nth-root-fixed-point 4 10)) 1.0)
(fixed-point ((repeated average-damp 2) (nth-root-fixed-point 5 10)) 1.0)
(fixed-point ((repeated average-damp 2) (nth-root-fixed-point 6 10)) 1.0)
(fixed-point ((repeated average-damp 2) (nth-root-fixed-point 7 10)) 1.0)
(fixed-point ((repeated average-damp 3) (nth-root-fixed-point 8 10)) 1.0)
; Leaving out experiments in-between here...
(fixed-point ((repeated average-damp 3) (nth-root-fixed-point 15 10)) 1.0)
(fixed-point ((repeated average-damp 4) (nth-root-fixed-point 16 10)) 1.0)
; And again...
(fixed-point ((repeated average-damp 4) (nth-root-fixed-point 31 10)) 1.0)
(fixed-point ((repeated average-damp 5) (nth-root-fixed-point 32 10)) 1.0)

; At this point, we can be pretty sure that it's just powers of two.
; So:

(define (log2 x) (/ (log x) (log 2)))

(define (root n x)
  (fixed-point ((repeated average-damp ((compose floor log2) n))
                (nth-root-fixed-point n x)) 1.0))

(check-within (root 2 2) 1.41421 tolerance)
(check-within (root 2 9) 3 tolerance)
(check-within (root 3 5) 1.70998 tolerance)
(check-within (root 4 8) 1.68179 tolerance)
(check-within (root 16 20) 1.20591 tolerance)
(check-within (root 100 100) 1.04713 tolerance)
