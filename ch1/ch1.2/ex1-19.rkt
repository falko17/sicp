#lang sicp

; Exercise 1.19

#|
To show that T applied twice is the same, we just need to do some rearrangements:
a1 = bq + aq + ap
b1 = bp + aq
a2 = b1q + a1q + a1p = (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p
   = bpq + aqq + bqq + aqq + apq + bqp + aqp + app
   = b·2pq + b·qq + a·2qq + a·2pq + a·pp = b·(2pq + qq) + a·(2pq + qq) + a·(pp + qq)
b2 = b1p + a1q = (bp + aq)p + (bq + aq + ap)q = bpp + aqp + bqq + aqq + apq
   = b(pp + qq) + a(2pq + qq)

==> p' = pp + qq
    q' = 2pq + qq

For Fibonacci, p=0 and q=1, so p' = 1 and q' = 1
|#

; Now, we just need to put this into practice:
(define (fib n)
  (define (fib-iter a b p q count)
    (cond ((= count 0)
           b)
          ((even? count)
           (fib-iter a
                     b
                     ; p'
                     (+ (* p p) (* q q))
                     ; q'
                     (+ (* 2 p q) (* q q))
                     (/ count 2)))
          (else
           (fib-iter (+ (* b q)
                        (* a q)
                        (* a p))
                     (+ (* b p)
                        (* a q))
                     p
                     q
                     (- count 1)))))
  (fib-iter 1 0 0 1 n))


(fib 1)
(fib 2)
(fib 3)
(fib 4)
(fib 5)
(fib 6)
(fib 7)
(fib 8)
(fib 9)
