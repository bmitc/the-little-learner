#lang racket

(provide (all-defined-out))

(require malt)

;; Given an argument x, returns a parameterized function with parameters
;; θ = (θ_1, θ_2) = (w, b) = (slope, y-intercept at origin) representing
;; the parameterization of a line.
(define line
  (λ (x)
    (λ (θ)
      (+ (* (ref θ 0) x)
         (ref θ 1)))))

(module+ test
  (require rackunit)

  (check-dual-equal? ((line 7.3) (list 1.0 0.0)) 7.3)
  )