#lang sicp

; Exercise 1.22

(define (square x) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n)
         n)
        ((divides? test-divisor n)
         test-divisor)
        (else (find-divisor
               n
               (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
  

(define (start-prime-test n start-time)
  (define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time))

  (if (prime? n)
      (report-prime (- (runtime)
                       start-time))))


(define (search-for-primes start num)
  (cond ((and (> num 0) (prime? start))
         (timed-prime-test start)
         (search-for-primes (inc start) (dec num)))
        ((> num 0) 
         (search-for-primes (inc start) num))))


(search-for-primes 1000 3)
(search-for-primes 10000 3)
(search-for-primes 100000 3)
(search-for-primes 1000000 3)
; The exercise only specified until 10^6, but SICP is quite old now,
; so I'll go three OOMs further.
(search-for-primes 10000000 3)
(search-for-primes 100000000 3)
(search-for-primes 1000000000 3)
(newline)

#|
Results:
1009 *** 4
1013 *** 1
1019 *** 1
10007 *** 0
10009 *** 1
10037 *** 1
100003 *** 2
100019 *** 2
100043 *** 1
1000003 *** 6
1000033 *** 5
1000037 *** 5
10000019 *** 16
10000079 *** 17
10000103 *** 17
100000007 *** 52
100000037 *** 52
100000039 *** 52
1000000007 *** 164
1000000009 *** 164
1000000021 *** 167

> Since the testing algorithm has order of growth of Θ(√n), you should expect that testing for primes around 10,000 should take about √10 times as long as testing for primes around 1000. Do your timing data bear this out?

Well, since sqrt(10) is roughly 3, the data does not really agree with me here.
However, this is just because at this magnitude, the program runs so quickly that there is no measurable difference in runs here—except for the very first one, which probably doesn't benefit from caching (which is probably done in the CPU, but maybe also somewhere else?), so it neither confirms nor denies our hypothesis.

> How well do the data for 100,000 and 1,000,000 support the Θ(√n) prediction?

100_000 still doesn't really help here, but at least the numbers get bigger at this point.
1_000_000 does get more interesting: 6 = 2 * 3, and 5 isn't too far off either, so these now start to conform to the sqrt(n) hypothesis.
Looking at the following runs, we have (with error in square brackets) 5 * 3 ≈ 17 [12%], 17 * 3 ≈ 52 [2%], 52 * 3 ≈ 164 [5%].


> Is your result compatible with the notion that programs on your machine run in time proportional to the number of steps required for the computation?

Yes, at least as a general measure. We obviously can't use it to make very exact predictions, but it at least points us in an accurate direction (i.e., there will be errors, but—as long as we're not missing some critical optimization or so that's happening at some level—the accuracy should be quite high.)
|#
