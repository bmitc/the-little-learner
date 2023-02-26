#lang racket

(require malt)

;; Frame 9
(define line0
  (λ (x)
    (λ (w b)
      (let ([y (+ (* w x) b)])
        y))))

;; Frame 11
(define line1
  (λ (x)
    (λ (w b)
      (+ (* w x) b))))

;; Frame 17
(define line-xs [tensor 1.0 4.0 3.0])
(define line-ys [tensor 1.8 1.2 4.2 3.3])

;;************************************************************
;;**** The Rule of Parameters (Initial Version) **************
;;************************************************************
;; Every parameter is a number.
;;************************************************************

;; Frame 25
;; See the following for entering symbols. On Windows, type \pi then hit alt + \.
;; https://docs.racket-lang.org/drracket/Keyboard_Shortcuts.html#%28part._.La.Te.X_and_.Te.X_inspired_keybindings%29
(define line
  (λ (x)
    (λ (θ)
      (+ (* (ref θ 0) x)
         (ref θ 1)))))

(module+ test
  (require rackunit)

  ;; Frame 14
  (check-dual-equal? ((line0 8) 4 6) 38)

  ;; Frame 22
  (check-dual-equal? ((line1 3.79) 1.0 0.0) 3.79)

  ;; Frame 28
  (check-dual-equal? ((line 7.3) (list 1.0 0.0)) 7.3)
  )