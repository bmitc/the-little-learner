#lang racket

(require malt)

;; Frame 24
(define sum1
  (λ (t)
    (summed t (sub1 (tlen t)) 0.0)))

;; Frame 24
(define summed
  (λ (t i a)
    (cond [(zero? i) (+ (tref t 0) a)]
          [else (summed t
                        (sub1 i)
                        (+ (tref t i) a))])))

(module+ test
  (require rackunit)

  ;; Frame 5
  (check-dual-equal? (+ 1 1) 2)

  ;; Frame 6
  (check-dual-equal? (+ [tensor 2] [tensor 7])
                     [tensor 9])

  ;; Frame 8
  (check-dual-equal? (+ [tensor 5 6 7] [tensor 2 0 1])
                     [tensor 7 6 8])

  ;; Frame 10
  (check-dual-equal? (+ [tensor [tensor 4 6 7] [tensor 2 0 1]]
                        [tensor [tensor 1 2 2] [tensor 6 3 1]])
                     [tensor [tensor 5 8 9] [tensor 8 3 2]])

  ;; Frame 12
  (check-dual-equal? (+ 4 [tensor 3 6 5])
                     [tensor 7 10 9])

  ;; Frame 14
  (check-dual-equal? (+ [tensor 6 9 1] [tensor [tensor 4 3 8] [tensor 7 4 7]])
                     [tensor [tensor 10 12 9] [tensor 13 13 8]])

  ;; Frame 15
  (check-dual-equal? (* [tensor [tensor 4 6 5] [tensor 6 9 7]] 3)
                     [tensor [tensor 12 18 15] [tensor 18 27 21]])

  ;; Frame 16
  (check-dual-equal? (sqrt 9) 3)

  ;; Frame 17
  (check-dual-equal? (sqrt [tensor 9 16 25])
                     [tensor 3 4 5])

  ;; Frame 19
  (check-dual-equal? (sqrt [tensor [tensor 49 81 16] [tensor 64 25 36]])
                     [tensor [tensor 7 9 4] [tensor 8 5 6]])

  ;; Frame 22
  (check-dual-equal? (sum [tensor 10.0 12.0 14.0])
                     36.0)

  ;; Frame 26
  (check-dual-equal? (sum [tensor [tensor [tensor 1 2] [tensor 3 4]]
                                  [tensor [tensor 5 6] [tensor 7 8]]])
                     [tensor [tensor 3 7] [tensor 11 15]])

  ;;************************************************************
  ;;**** The Law of Sum ****************************************
  ;;************************************************************
  ;; For a tensor t with rank r > 0, the rank of (sum t) is r-1.
  ;;************************************************************

  ;; Frames 29 and 31
  (check-dual-equal? ((line [tensor 2 7 5 11]) (list 4 6))
                     [tensor 14 34 26 50])
  )