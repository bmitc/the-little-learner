#lang racket

(require malt)

;; Frame 5
(define line-xs [tensor 2.0 1.0 4.0 3.0])
(define line-ys [tensor 1.8 1.2 4.2 3.3])

;; Frame 16
#;(define l2-loss
  (λ (xs ys)
    (λ (θ)
      (let ([pred-ys ((line xs) θ)])
        (sum (sqr (- ys pred-ys)))))))

;; Frame 19
#;(define l2-loss
  (λ (line)
    (λ (xs ys)
      (λ (θ)
        (let ([pred-ys ((line xs) θ)])
          (sum (sqr (- ys pred-ys))))))))

;; Frame 22
(define l2-loss
  (λ (target)
    (λ (xs ys)
      (λ (θ)
        (let ([pred-ys ((target xs) θ)])
          (sum (sqr (- ys pred-ys))))))))

(module+ test
  (require rackunit)

  ;; Frame 6
  (check-dual-equal? ((line line-xs) (list 0.0 0.0))
                     [tensor 0.0 0.0 0.0 0.0])
  )