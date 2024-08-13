#lang sicp

; What are the values of the following expressions?
; (A 1 10)
; = (A 0 (A 1 9)) = (* 2 (A 1 9)) = (* 2 (A 0 (A 1 8))) = (* 2 (* 2 (A 1 8))) = (* 2 (* 2 (* 2 (A 1 7))))
; And so on, until (* 2 2 2 2 2 2 2 2 2 (A 1 1)) = (* 2 2 2 2 2 2 2 2 2 2)
(* 2 2 2 2 2 2 2 2 2 2)
; => 1024

;(A 2 4)
; = (A 1 (A 2 3)) = (A 1 (A 1 (A 2 2))) = (A 1 (A 1 (A 1 (A 2 1)))) = (A 1 (A 1 (A 1 2)))
; = (A 1 (A 1 (A 0 (A 1 1)))) = (A 1 (A 1 (A 0 2))) = (A 1 (A 1 4)) = (A 1 (A 0 (A 1 3))) = (A 1 (A 0 (A 1 3)))
; = (A 1 (A 0 (A 0 (A 1 2)))) = (A 1 (A 0 (A 0 (A 0 (A 1 1))))) = (A 1 (A 0 (A 0 (A 0 2)))) = (A 1 (A 0 (A 0 4)))
; = (A 1 (A 0 8)) = (A 1 16) = (A 0 (A 1 15)) = (A 0 (A 0 (A 1 14))) = ... =
(* 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2)
; => 65536

;(A 3 3)
; = (A 2 (A 3 2)) = (A 2 (A 2 (A 3 1))) = (A 2 (A 2 2)) = (A 2 (A 0 8)) -- taken from above --
; = (A 2 16) = (A 1 (A 2 15)) = (A 1 (A 1 (A 2 14))) = (A 1 (... nested 13 further times ... (A 2 1))) = (A 1 (... 12 times ... (A 1 2))
; = (A 1 (... 12 times ... (* 2 2))) -- taken from above -- = (A 1 (... 11 times ... (A 1 4)))
; Then (A 1 8), (A 1 16), and nine further times, leading to 16 * 2^9 = 8192, so:
; (A 1 8192), which is (* 2 ... 8191 times ...)
; to calculate it:
(define (pow x y) (cond ((= y 0) 1)
                        ((= y 1) x)
                        ((= x 1) 1)
                        (else (* x (pow x (- y 1))))))

(pow 2 8192)
; => Well, it's very big.
;
; Now, let's verify:
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

(= (A 1 10) 1024)
(= (A 2 4) 65536)
(= (A 3 3) (pow 2 8182))  ; Oops, looks like something went horribly wrong above and this is actually just 65536.
; Oh yeah, I see it. I thought (A 2 2) = (A 0 8), but actually (A 2 2) = (A 0 2) = 4, which means (A 3 3) = (A 2 4).
;
; Consider the following procedures, where A is the procedure defined above:

(define (f n) (A 0 n))
(define (g n) (A 1 n))
(define (h n) (A 2 n))
(define (k n) (* 5 n n))

;Give concise mathematical definitions for the functions computed by the procedures f, g, and h for positive integer values of n
;For example, (k n) computes 5n^2

; Alright.
; f(n) = 2 + ...(n)... + 2 = 2n
; g(n) = 2 * ...(n)... * 2 = 2^n
; h(n) = 2 ^ ...(n)... ^ 2 = -- Hmm, I guess we can use Knuth's up-arrow notation here? -- 2↑↑n
