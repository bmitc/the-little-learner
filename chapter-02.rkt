#lang racket

(require malt
         "utilities.rkt")

;; Frame 25
(define rank0
  (λ (t)
    (cond [(scalar? t) 0]
          [else (add1 (rank (tref t 0)))])))

;; Frame 37
(define shape
  (λ (t)
    (cond [(scalar? t) (list)]
          [else (cons (tlen t) (shape (tref t 0)))])))

;; Frame 44
(define rank
  (λ (t)
    (ranked t 0)))

;; Frame 44
(define ranked
  (λ (t a)
    (cond
      [(scalar? t) a]
      [else (ranked (tref t 0) (add1 a))])))

(module+ test
  (require rackunit
           rackcheck)

  ;; Frame 2
  (check-true (exact-nonnegative-integer? 5))

  ;; Frame 3
  (check-true (exact-nonnegative-integer? 0))

  ;; Frame 4
  (check-false (exact-nonnegative-integer? -5))

  ;; Frame 5
  (check-true (real? 7.18))

  ;; Frame 6
  (check-true (real? -13.713))

  ;; Frame 7
  (check-true (scalar? 7.18))

  ;; Frame 8
  ;; See the following for entering symbols. On Windows, type \pi then hit alt + \.
  ;; https://docs.racket-lang.org/drracket/Keyboard_Shortcuts.html#%28part._.La.Te.X_and_.Te.X_inspired_keybindings%29
  (check-true (scalar? π))

  ;; Frame 10
  (check-true (tensor? [tensor 5.0 7.18 π]))

  ;; Frame 14
  (check-true (tensor? [tensor [tensor 7 6 2 5]
                               [tensor 3 8 6 9]
                               [tensor 9 4 8 5]]))

  ;; Frame 17
  (check-equal? (tlen [tensor 17 12 91 67]) 4)
  (check-equal? (tlen [tensor [tensor 3 2 8]
                              [tensor 7 1 9]])
                2)

  ;; Frames 18-19
  (check-true (tensor? [tensor [tensor [tensor 8]]]))

  ;; Frames 19-20
  (check-true (tensor? [tensor [tensor [tensor 5]
                                       [tensor 6]
                                       [tensor 7]
                                       [tensor 8]
                                       [tensor 9]
                                       [tensor 0]]]))

  ;; Frame 21
  (check-true (tensor? 9))

  ;;************************************************************
  ;;**** The Rule of Rank **************************************
  ;;************************************************************
  ;; A tensor's rank is the number of left square brackets
  ;; before its leftmost scalar.
  ;;************************************************************

  ;; Frame 26
  (check-equal? (rank [tensor [tensor [tensor 8]
                                      [tensor 9]]
                              [tensor [tensor 4]
                                      [tensor 7]]]) 3)

  ;; Frame 30
  (check-equal? (shape [tensor [tensor 5.2 6.3 8.0]
                               [tensor 6.9 7.1 0.5]])
                (list 2 3))

  ;; Frame 31
  (check-equal? (shape [tensor [tensor [tensor 5]
                                       [tensor 6]
                                       [tensor 8]]
                               [tensor [tensor 7]
                                       [tensor 9]
                                       [tensor 5]]])
                (list 2 3 1))

  ;; Frame 32
  (check-equal? (shape [tensor 9 4 7 8 0 1]) (list 6))

  ;; Frame 35
  (check-equal? (shape 9) (list))

  ;;************************************************************
  ;;**** The Rule of Members and Elements **********************
  ;;************************************************************
  ;; Non-empty lists have members and non-scalar tensors have
  ;; elements.
  ;;************************************************************

  ;; Frame 38
  (check-equal? (cons 3 (list 7 9)) (list 3 7 9))

  ;; Frame 39
  (check-equal? (shape 9) (list))

  ;; Frame 40
  (check-equal? (shape [tensor 9 4 7 8 0 1]) (list 6))

  ;;************************************************************
  ;;**** The Rule of Uniform Shape *****************************
  ;;************************************************************
  ;; All elements of a tensor must have the same shape.
  ;;************************************************************

  ;; Frame 41
  (check-equal? (shape [tensor [tensor [tensor 5]
                                       [tensor 6]
                                       [tensor 8]]
                               [tensor [tensor 7]
                                       [tensor 9]
                                       [tensor 5]]])
                (list 2 3 1))

  ;; Frame 42
  (check-property (make-config #:tests 50)
                  (property #:name "The Law of Rank and Shape"
                            ([t gen:tensor])
                            (check-dual-equal? (len (shape t)) (rank t))))

  ;;************************************************************
  ;;**** The Law of Rank and Shape *****************************
  ;;************************************************************
  ;; The rank of a tensor is equal to the length of its shape.
  ;;************************************************************

  ;;************************************************************
  ;;**** The Law of Simple Accumulator Passing *****************
  ;;************************************************************
  ;; In a simple accumulator passing function definition every
  ;; recursive function invocation is unwrapped, and the
  ;; definition has at most one argument that does not change;
  ;; an argument that changes towards a true base test; and
  ;; another that accumulates a result.
  ;;************************************************************
  )