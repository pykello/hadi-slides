#lang slideshow

(require pict
         ppict/slideshow2)

(provide load-imagepack
         introduce)

;; global defaults
(current-main-font "Fira Sans")
(set-margin! 50)

;; load-imagepack
(define (load-imagepack base images)
  (define (load-image file)
    (define full-path (path->string (build-path base file)))
    (displayln full-path)
    (bitmap full-path))
  (define (image-assoc img)
    (define name (car img))
    (define file (cdr img))
    (cons name (load-image file)))
  (make-immutable-hash (map image-assoc images)))

;; images
(define template-directory
  (let ([p1 (build-path (current-directory) ".." "common")]
        [p2 (build-path (current-directory) "common")])
    (if (directory-exists? p1)
        p1
        p2)))

(define image-pack
  (load-imagepack template-directory
                  `((microsoft-logo . "microsoft-logo.png")
                    (citus-logo . "citus-logo.png")
                    (magnetic-drum . "magnetic-drum.jpg"))))
;;
;; slide templates
;;
(define (introduce topic-l author-name)
  (let* ([w (+ (* 2 margin) client-w)]
         [h (+ (* 2 margin) client-h)]
         [background (rb-superimpose (colorize (filled-rectangle w h) "black")
                                     (hash-ref image-pack `magnetic-drum))]
         [affiliation (hc-append (hash-ref image-pack `citus-logo)
                                 (scale/improve-new-text (t " now part of  ") 0.5)
                                 (hash-ref image-pack `microsoft-logo))]
         [topic (vl-append (scale/improve-new-text (t (first topic-l)) 2)
                           (scale/improve-new-text (t (second topic-l)) 2)
                           (scale/improve-new-text (t (third topic-l)) 1.5))]
         [author (scale/improve-new-text (t author-name) 1)]
         [content (colorize (vl-append topic author affiliation) "white")]
         [padding (ghost (disk 150))])
    (pslide (lc-superimpose background (hc-append padding content)))))