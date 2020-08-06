#lang scribble/text

@(require "scribble-utils.rkt")

@(define (old-quote-highlight 
                          #:title title
                          #:is-boot? [is-book? 'f]
                          #:author author
                          #:page-number page-num
                          #:url [url ""]
                          . body ) @list{*@|body|*})

 

My first program is:
@quote-highlight[
 #:title       "yo"
 #:author      "Ryan Wilcox"
 #:page-number 42
 #:url         "http://example.com"
 #:is-book?    't
 ]{
bello
world
}
