#lang sicp

; Exercise 1.28

(define (square x) (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

(define (expmod base exp m)

  (define (non-trivial-sqrt? x)
      (and (= (remainder (square x) m) 1) (not (= x 1)) (not (= x (dec m)))))

  (define (handle-squared squared)
    (if (non-trivial-sqrt? squared) 0 (remainder (square squared) m)))

  (cond ((= exp 0) 1)
        ((even? exp)
         (handle-squared (expmod base (/ exp 2) m)))
        (else
         (remainder
          (* base (expmod base (- exp 1) m))
          m))))

(define (miller-rabin-test n)

  (define (try-it a)
    (define (maybe-prime? x)
      (and (= x a) (> x 0)))

    (maybe-prime? (expmod a n n)))

  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((miller-rabin-test n) 
         (fast-prime? n (- times 1)))
        (else false)))

(fast-prime? 2 100) ; t
(fast-prime? 3 100) ; t
(fast-prime? 4 100) ; f
(fast-prime? 5 100) ; t
(fast-prime? 6 100) ; f
(fast-prime? 7 100) ; t
(fast-prime? 8 100) ; f

(fast-prime? 46 100) ; f
(fast-prime? 47 100) ; t
(fast-prime? 48 100) ; f

; Carmichael numbers:
(fast-prime? 1105 100) ; f
(fast-prime? 1729 100) ; f
(fast-prime? 2465 100) ; f
(fast-prime? 2821 100) ; f
(fast-prime? 6601 100) ; f

; And finally, one more big prime number to make sure it still works
(fast-prime? 6661 100) ; t

; Seems to work!
