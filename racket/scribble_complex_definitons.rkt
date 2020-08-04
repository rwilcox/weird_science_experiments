#lang scribble/text

@(define (quote-highlight 
                          #:title title
                          #:is-boot? [is-book? 'f]
                          #:author author
                          #:page-number page-num
                          #:url [url ""]
                          . body ) @list{*@|body|*})

 

Hello world @quote-highlight[
 #:title       "yo"
 #:author      "Ryan Wilcox"
 #:page-number 42
 #:url         "http://example.com"
 ]{ 
 bello
  world
}
