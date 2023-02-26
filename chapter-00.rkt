#lang racket

;; Frame 6
(define pie 3.14)

;; Frame 7
(define a-radius 8.4)
(define an-area (* pie (* a-radius a-radius)))

;; Frame 10
(define area-of-circle
  (λ (r)
    (* pie (* r r))))

;; Frame 12
(define area-of-rectangle
  (λ (width)
    (λ (height)
      (* width height))))

;; Frame 14
(define double-result-of-f
  (λ (f)
    (λ (z)
      (* 2 (f z)))))

;; Frame 15
(define add3
  (λ (x)
    (+ 3 x)))

;; Frame 24
(define abs
  (λ (x)
    (cond
      [(< x 0) (- 0 x)]
      [else x])))

;; Frame 26
(define silly-abs
  (λ (x)
    (let ([x-is-negative (< x 0)])
      (cond
        [x-is-negative (- 0 x)]
        [else x]))))

;; Frame 37
(define remainder
  (λ (x y)
    (cond
      [(< x y) x]
      [else (remainder (- x y) y)])))

;; Frame 49
;; This is slightly different from the book, as I feel it is more clear.
(define add
  (λ (n m)
    (cond
      [(zero? m) n]
      [else (add (add1 n) (sub1 m))])))

(module+ test
  (require rackunit)

  (check-= an-area 221.5584 0.0001)

  (check-= an-area (area-of-circle a-radius) 0.0001)

  (check-equal? ((double-result-of-f add3) 4) 14)

  (check-equal? (remainder 13 4) 1)
  
  (check-equal? (add 7 2) 9)
  )