#lang sicp

; Exercise 1.17

(define (*-old a b)
  (if (= b 0)
      0
      (+ a (*-old a (- b 1)))))

(define (* a b)
  (define (halve x) (/ x 2))
  (define (double x) (+ x x))
  (cond
    ((= b 0) 0)
    ((even? b) (double (* a (halve b))))
    (else (+ a (* a (dec b))))))

(* 2 1)
(* 2 2)
(* 2 3)
(* 2 4)
(* 4 2)


(* 3 3)
(* 5 7)
(* 10 10)
(* 11 11)
(* 7 5)
