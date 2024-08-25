#lang sicp

; Exercise 1.24

(define (square x) (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder 
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder 
          (* base (expmod base (- exp 1) m))
          m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) 
         (fast-prime? n (- times 1)))
        (else false)))


(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))


(define (start-prime-test n start-time)
  (define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time))

  (if (fast-prime? n 100)
      (report-prime (- (runtime)
                       start-time))))


(define (search-for-primes start num)
  ; None of the numbers we'll hit on here are Carmichael numbers, so using fast-prime is fine.
  (cond ((and (> num 0) (fast-prime? start 100))
         (timed-prime-test start)
         (search-for-primes (inc start) (dec num)))
        ((> num 0) 
         (search-for-primes (inc start) num))))


(search-for-primes 1000 3)
(search-for-primes 10000 3)
(search-for-primes 100000 3)
(search-for-primes 1000000 3)
(search-for-primes 10000000 3)
(search-for-primes 100000000 3)
(search-for-primes 1000000000 3)
(newline)

#|

> Since the Fermat test has Θ(logn) growth, how would you expect the time to test primes near 1,000,000 to compare with the time needed to test primes near 1000?

I would expect (just using base 10 here to make it easier for me) each increase by a factor of 10 to result in a fixed increment to the time.
Hence, comparing the time needed for 1_000_000 with 1000, I'd expect three such increments (*except* that 1_000_000 was the first number for which the execution time was long enough to  have measurable results in previous exercises, so I'll check the next numbers too.)

Results:
1009 *** 37
1013 *** 34
1019 *** 36
10007 *** 41
10009 *** 40
10037 *** 41
100003 *** 46
100019 *** 48
100043 *** 48
1000003 *** 55
1000033 *** 54
1000037 *** 56
10000019 *** 70
10000079 *** 66
10000103 *** 67
100000007 *** 76
100000037 *** 75
100000039 *** 77
1000000007 *** 83
1000000009 *** 82
1000000021 *** 87

> Do your data bear this out?

Somewhat, at least. The increment appears to be roughly 7, but it varies between 4 and, in the most extreme case, 16 (although this is only a single outlier).
Still, there is a high amount of variance in the results, even if the differences between OOMs seem to be in the same ballpark.

> Can you explain any discrepancy you find?

The discrepancies/variance mentioned above stems from the fact that this is a *probabilistic* method.
Or at least, that's what I was thinking was the answer, but now I think this is wrong. The randomness determines the base of the expmod, but the logarithmic growth is based on the exponent (which is not randomly chosen).
Staying in the pure abstract scheme model, there isn't really an explanation I can think of (at least, not one we could arrive at using what SICP has given us.)
Outside of that model, there could be several reasons for the variance:
* Bigger numbers chosen by the RNG still cause computation time to lengthen if they don't fit into 32 bits (if for some reason 32 bit integers are used here). However, this should only have affected the last number (log10(2^32) ≈ 10)).
* The RNG may need to wait for more entropy to become available.
* CPUs do wild things sometimes (e.g., there could be weird optimizations that can only happen in some cases).
* There's probably a lot of other reasons too, but I need to move on to the next exercise now. Still, it may pay off to do a deep dive on this at some point.
|#
