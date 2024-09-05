#lang sicp

(#%require rackunit)

(define (square x) (* x x))

; Exercise 2.3

(define (make-segment start end) (cons start end))
(define (start-segment segment) (car segment))
(define (end-segment segment) (cdr segment))
(define (length-segment segment) (dist-point (end-segment segment) (start-segment segment)))
(define (move-segment segment x y)
  (let ((start (start-segment segment)) (end (end-segment segment)))
    (make-segment
     (make-point (+ (x-point start) x) (+ (y-point start) y))
     (make-point (+ (x-point end) x) (+ (y-point end) y)))))

(define (make-point x y) (cons x y))
(define (x-point point) (car point))
(define (y-point point) (cdr point))
(define (dist-point point other)
  (sqrt (+ (square (- (x-point point) (x-point other))) (square (- (y-point point) (y-point other))))))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define (print-segment s)
  (print-point (start-segment s))
  (print-point (end-segment s)))

(define (print-rect r)
  (print-segment (top-rectangle r))
  (print-segment (right-rectangle r))
  (print-segment (bottom-rectangle r))
  (print-segment (left-rectangle r)))

(define (perimeter rect)
  (* 2 (+
        (length-segment (left-rectangle rect))
        (length-segment (top-rectangle rect)))))

(define (area rect)
  (* (length-segment (left-rectangle rect)) (length-segment (top-rectangle rect))))

(define (make-rectangle left top)
  (cons left top))

(define (left-rectangle rect) (car rect))
; This will be the left line moved to the right by the length of top.
(define (right-rectangle rect) (move-segment (left-rectangle rect) (length-segment (top-rectangle rect)) 0))
(define (top-rectangle rect) (cdr rect))
; Similar for bottom rectangle.
(define (bottom-rectangle rect) (move-segment (top-rectangle rect) 0 (* -1 (length-segment (left-rectangle rect)))))


; Alternative definition below, switching the representation of our rectangle from left top to bottom right

#|
(define (make-rectangle right bottom) (cons right bottom))
(define (right-rectangle rect) (car rect))
(define (left-rectangle rect) (move-segment (right-rectangle rect) (* -1 (length-segment (bottom-rectangle rect))) 0))
(define (bottom-rectangle rect) (cdr rect))
(define (top-rectangle rect) (move-segment (bottom-rectangle rect) 0 (length-segment (left-rectangle rect))))
|#

(let
    ((example-rect (make-rectangle (make-segment (make-point 0 0) (make-point 0 10)) (make-segment (make-point 0 10) (make-point 20 10)))))
  (check-eq? (perimeter example-rect) 60)
  (check-eq? (area example-rect) 200)
  (let ((alt-rect (make-rectangle (right-rectangle example-rect) (move-segment (top-rectangle example-rect) 20 0))))
    (check-eq? (perimeter alt-rect) 60)
    (check-eq? (area alt-rect) 200)))
