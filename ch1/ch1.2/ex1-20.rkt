#lang sicp

; Euclid's Algorithm
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

; Exercise 1.20

; GCD(206,40) = GCD(40,6)
;             = GCD(6,4)
;             = GCD(4,2)
;             = GCD(2,0) = 2)))
;
; For applicative-order evaluation:
; (gcd 40 (rem 206 40)) = (gcd 40 6) = (gcd 6 (rem 40 6)) = (gcd 6 4) = (gcd 4 (rem 6 4)) = (gcd 4 2) = (gcd 2 (rem 4 2)) = (gcd 2 0) = 2
; So, in total, rem was evaluated 4 times.
;
; For normal-order evaluation:
; (gcd 40 (rem 206 40)) = (gcd (rem 206 40) (rem 40 (rem 206 40))) = (gcd (rem 40 (rem 206 40)) (rem (rem 206 40) (rem 40 (rem 206 40))))
;  = (gcd (rem (rem 206 40) (rem 40 (rem 206 40))) (rem (rem 40 (rem 206 40)) (rem (rem 206 40) (rem 40 (rem 206 40)))))
; We just need to count here to know how often remainder is evaluated: 11 times.
;
; After looking at the solution, I skipped the if's when writing this down, so I missed 7 additional remainer instances.
; The actual number for normal-order is 18.
