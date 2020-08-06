#lang racket

(require threading) ; package threading-lib
(require racket/format)

(provide quote-highlight)
(define (short-str-join s)
  (string-join s ""))

(define (add-attribution strs-as-lists title is-book? author page-num url )
  (append strs-as-lists
          (~a "\n> \n" "> From " title " by " author " on page " (number->string page-num)  " (" url ")" )
           ))


(define (quote-highlight #:title title
                          #:is-book? [is-book? 'f]
                          #:author author
                          #:page-number page-num
                          #:url [url ""]
                          . body) (
~> (append-map (lambda (arg)
                 (if (string=? arg "\n") (list arg) (list "> " arg)))
       body)   ; (add-between body ">" #:before-first "> ")
   (add-attribution title is-book? author page-num url)
   (flatten)
   (short-str-join)))

; (string-join (flatten (list "*" body "*")))