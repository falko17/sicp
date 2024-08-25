#lang sicp

; Exercise 1.23

(define (next x) (if (= 2 x) 3 (+ x 2)))

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
               (next test-divisor)))))

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
(search-for-primes 10000000 3)
(search-for-primes 100000000 3)
(search-for-primes 1000000000 3)
(newline)

#|
Results:
1009 *** 5
1013 *** 0
1019 *** 0
10007 *** 1
10009 *** 1
10037 *** 0
100003 *** 1
100019 *** 2
100043 *** 2
1000003 *** 3
1000033 *** 3
1000037 *** 3
10000019 *** 9
10000079 *** 9
10000103 *** 9
100000007 *** 28
100000037 *** 28
100000039 *** 28
1000000007 *** 107
1000000009 *** 89
1000000021 *** 88

> Since this modification halves the number of test steps, you should expect it to run about twice as fast. Is this expectation confirmed?

(Again starting from 1_000_000, see 1.22...)
Yes, the expectation is pretty much confirmed, with a slight error below 10%, except for 1_000_000, where the error is at 20%. As a former physics performance course student, the OOM matches, so I'm happy.
Specifically, even for this case where the ratio is most off, it's still at 1.6, which we could round to 2 if we're getting really daring.
|#
