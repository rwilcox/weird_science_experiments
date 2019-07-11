#lang racket
(require simple-http) ; package 
(require threading) ; package threading-lib
(require srfi/26)  ; (for cut aka partial application --> https://docs.racket-lang.org/srfi/srfi-std/srfi-26.html?q=cut#cut

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
  (cut get-json-request-with-host (update-ssl (update-host json-requester "seeclickfix.com") #t) <>)
)

(get-json-request "/open311/v2/requests.json?lat=41.307153&long=-72.925791")