#lang racket

(provide π
         gen:tensor)

(define π pi)

(require malt
         rackcheck)

;; Generates non-zero natural numbers. I.e., integers greater than or equal to 1.
(define gen:non-zero-natural
  (gen:filter gen:natural
              (lambda (n) (not (zero? n)))))

(define gen:rank
  gen:natural)

(define gen:shape
  (gen:list (gen:integer-in 1 9) #:max-length 5))

(define (gen:tensor-of-length n generator)
  (gen:let ([list (gen:filter (gen:list generator #:max-length n)
              (lambda (list) (= (length list) n)))])
           (list->tensor list)))

(define gen:tensor
  (gen:let ([shape gen:shape])
           (foldr (lambda (length acc) (gen:tensor-of-length length acc))
                  gen:natural
                  shape)))

