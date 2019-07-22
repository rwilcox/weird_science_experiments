#lang racket
(require simple-http) ; package 
(require threading) ; package threading-lib
(require srfi/26)  ; (for cut aka partial application --> https://docs.racket-lang.org/srfi/srfi-std/srfi-26.html?q=cut#cut
(require lens)
(require unstable/lens)
(require net/url)


(define (url theurl [state (make-hash)] )
  (let ([theurl-struct (string->url theurl)])
    (hash-set! state 'host (url-host theurl-struct))
    (hash-set! state 'path (url-path theurl-struct))
    (identity state)
    )
 )


(define (method themethod [state (make-hash)] )
  (hash-set! state 'method themethod)
  (identity state)
)


(define (curl-execute state)
  (println state)
  (get-json-request-with-host
   (update-ssl (update-host json-requester (hash-ref state 'host)) #t)
   (hash-ref state 'path))
)


(define (get-html-request hostname path)  
  (define host (update-host html-requester hostname) )
  (define res (get host path))
  
  (match ( html-response-status res )
    [ "HTTP/1.1 200 OK" (html-response-body res)]
    [ "HTTP/1.1 404 Not Found" (error "not found")]
  )
)


(define (get-json-request-with-host hostinfo path)
  (define res (get hostinfo path) )

  (match (json-response-status res )
    [ "HTTP/1.1 200 OK" (json-response-body res)]
  )
)


(define get-json-request
  (cut get-json-request-with-host (update-ssl (update-host json-requester "api.github.com") #t) <>)
)



(define (process-data data-in)
  ; map-lens works on a plain old lisp list
  ; the jsonxp is a set of hash-refs inside the PoLL, as maps from the Json's array of records
  
 (let ([info-lens (map-lens (
                             lens-join/hash 'full_name (hash-ref-lens 'full_name)
                                            'owner_name  (lens-thrush (hash-ref-lens 'owner) (hash-ref-lens 'login) )
                                            ; thrush is odd here - lens-thru apllies the lens right -> left. This applies them left->right
                                            ; as login is INSIDE the owner record, it's easier to read this way
                                            'forked_project (hash-ref-lens 'fork)
                                            ))])
   (lens-view info-lens data-in)
 )
)

(~>>
 (url "https://api.github.com/users/rwilcox/repos")
 (method 'GET)
 (curl-execute)
 )
                     
; (~> (get-json-request "/users/rwilcox/repos") process-data)