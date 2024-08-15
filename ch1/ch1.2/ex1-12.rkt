#lang sicp

; Exercise 1.12: Compute Pascal's triangle by means of a recursive procedure.
; Sounds simple enough:
(define (pascal row col)
  (if (or (= col 0) (= col row))
      ; Numbers at the edge of the triangle are always 1
      1
      ; Otherwise, sum of left and right "parent" in triangle
      (+ (pascal (dec row) (dec col)) (pascal (dec row) col))))

(pascal 0 0)
(pascal 2 1)
(pascal 4 4)
