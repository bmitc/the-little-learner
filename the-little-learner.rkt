#lang racket

(provide line
         shape
         rank)

(require malt)

;; Given an argument x, returns a parameterized function with parameters
;; θ = (θ_1, θ_2) = (w, b) = (slope, y-intercept at origin) representing
;; the parameterization of a line.
(define line
  (λ (x)
    (λ (θ)
      (+ (* (ref θ 0) x)
         (ref θ 1)))))

;; Determines the shape of a tensor.
(define shape
  (λ (t)
    (cond [(scalar? t) (list)]
          [else (cons (tlen t) (shape (tref t 0)))])))

;; Determines the rank of a tensor.
(define rank
  (λ (t)
    (ranked t 0)))

;; Helper function to help efficiently calculate the rank of a tensor.
(define ranked
  (λ (t a)
    (cond
      [(scalar? t) a]
      [else (ranked (tref t 0) (add1 a))])))

(module+ test
  (require rackunit)

  (check-dual-equal? ((line 7.3) (list 1.0 0.0)) 7.3)
  )