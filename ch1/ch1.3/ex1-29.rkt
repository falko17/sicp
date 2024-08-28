#lang sicp

; Exercise 1.29

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))


(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))


; Simpson's Rule for approximating definitive integrals below:

(define (simpsons-rule f a b n)
  ; I wish we'd get variable bindings at some point (if they exist in Scheme)...
  (define (simpsons-rule-aux f a n h)
    (define (y k) (f (+ a (* k h))))
    (define (simpsons-factor x)
      (cond ((or (= x 0) (= x n)) 1)
            ((even? x) 2)
            (else 4)))
    (define (simpsons-term x)
      (* (simpsons-factor x) (y x)))

    (* (/ h 3) (sum simpsons-term 0 inc n)))

  (simpsons-rule-aux f a n (/ (- b a) n)))


#|
(integral cube 0 1 0.01)
.24998750000000042

(integral cube 0 1 0.001)
.249999875000001


Use your procedure to integrate cube between 0 and 1 (with n=100 and n=1000), and compare the results to those of the integral procedure shown above.
|#

(define (cube n) (* n n n))

(simpsons-rule cube 0 1 100)  ; => Exactly 1/4
(simpsons-rule cube 0 1 1000) ; => Exactly 1/4

; Since the integral of x^3 is x^4/4, this is exactly right!
