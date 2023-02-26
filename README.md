# The Little Learner

This is a collection of Racket code for the book *The Little Learner* by Daniel P. Friedman and Anurag Mendhekar.

The code is implemented for frames that contain questions regarding values of an expression or definitions of functions. Questions are most often implemented via unit tests. For example:

```racket
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
```

There are even a few property tests to verify properties in the book. For example, for *The Law of Rank and Shape* that says that the rank of a tensor is equal to the length of its shape, the following property test is implemented:

```racket
;; Frame 42
(check-property (make-config #:tests 50)
                (property #:name "The Law of Rank and Shape"
                          ([t gen:tensor])
                          (check-equal? (len (shape t)) (rank t))))
```

Hopefully this code is helpful to follow along with the book and can illustrate any of the code or questions in the book with actual Racket implementations.
