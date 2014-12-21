#lang racket/base

(require racket/contract
         racket/format
         racket/match)

(provide
 (contract-out
  [pretty-print-bytes
   (->* (bytes?)
        (#:block-size exact-positive-integer? #:non-display-char char?)
        any)]))

(define (pretty-print-bytes bstr
                            #:block-size [block-size 16]
                            #:non-display-char [n/a #\-])
  (define len (bytes-length bstr))
  (let print-line ([from 0])
    (display (if (zero? from) "[" " "))
    (define next (+ from block-size))
    (define upto (min len next))
    ;; Left columns: hex
    (for ([ix (in-range from next)])
      (display (cond [(< ix upto) (~a #:min-width 2
                                      #:align 'right
                                      #:pad-string "0"
                                      (number->string (bytes-ref bstr ix) 16))]
                     [else        "  "]))
      (display " "))
    (display " ")
    ;; Right columns: display
    (for ([ix (in-range from next)])
      (display (cond [(< ix upto) (match (bytes-ref bstr ix)
                                    [(? displayable? b) (integer->char b)]
                                    [_                  n/a])]
                     [else " "])))
    (when (< next len)
      (newline)
      (print-line next)))
  (displayln "]"))

(define (displayable? b)
  (<= 32 b 126))
