#lang racket

(require pict
         ppict)

(define chip-width 100)
(define chip-height 150)
(define register-width 75)
(define padding 7)
(define total-width 1000)
(define total-height 400)
(define chip-spacer 90)
(define base (colorize (filled-rectangle total-width total-height) "white"))

(define (offset-finder base dx dy)
  (λ (pict offset)
    (define-values (x y) (base pict offset))
    (values (+ x dx) (+ y dy))))

(define (rto-find offset)
  (offset-finder rt-find 0 offset))

(define (lto-find offset)
  (offset-finder lt-find 0 offset))

(define (c x y)
  (coord 0 0 'lb
         #:abs-x x
         #:abs-y (- total-height y)
         #:compose hb-append))

(define (multiline . label)
  (apply vc-append 0 (map text label)))

(define (register-cell . label)
  (let* ([label-pict (apply multiline label)]
         [label-height (pict-height label-pict)]
         [label-width (pict-width label-pict)]
         [height (+ label-height padding)]
         [width (max register-width (+ label-width (* 2 padding)))])
    (cc-superimpose (rectangle width height)
                    label-pict)))

(define (chip . contents)
  (cc-superimpose (rectangle chip-width chip-height)
                  (apply vc-append `(,padding ,@contents))))

(define registers
  (vc-append -1.0
             (register-cell "R15")
             (register-cell "." "." ".")
             (register-cell "R0")))

(define address-translation
  (register-cell "Address" "Translation"))

(define-syntax-rule (draw-arrow tag-1 finder-1 tag-2 finder-2)
  (let ([p ppict-do-state])
    (pin-arrow-line 6 p
                    (find-tag p tag-1) finder-1
                    (find-tag p tag-2) finder-2)))

(ppict-do base
          #:go (c 50 50)
          (tag-pict (chip (text "ARM Core") registers)
                    'arm-core)
          90
          (tag-pict (chip (multiline "Level 1" "Cache(s)")
                          (text "")
                          (text "")
                          (multiline "Tightly" "Coupled" "Memory")
                          (text "TCM(s)"))
                    'level-1)
          70
          (tag-pict (chip (multiline "Level 2" "Caches"))
                    'level-2)
          70
          (tag-pict (chip (text "Level 3")
                          (multiline "DRAM" "SRAM" "Flash" "ROM"))
                    'level-3)
          #:set (draw-arrow 'arm-core (rto-find 15) 'level-1 (lto-find 15))
          #:go (at-find-pict 'arm-core rt-find #:abs-x 65)
          (multiline "configuration/" "control")
          #:set (draw-arrow 'level-1 (lto-find 45) 'arm-core (rto-find 45))
          #:go (at-find-pict 'arm-core rt-find #:abs-x 45 #:abs-y 45)
          (multiline "Instruction" "Prefetch"))

