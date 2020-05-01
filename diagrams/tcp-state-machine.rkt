#lang racket

(require metapict)

(with-window (window -100 400 -250 250)
  (current-label-gap (px 10))
  (current-node-minimum-size (px 50))
  (current-neighbour-distance (px 50))
  
  (def closedStart  (rectangle-node "CLOSED"))
  (def listen (rectangle-node "LISTEN" #:below closedStart))

  (scale 1.0
         (draw closedStart
               listen))
  )