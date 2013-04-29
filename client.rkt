#lang racket
(require net/url)
(require net/uri-codec)

(define PORT 9000)
(define MSG #"THISISATEST")

(define (remote port msg)
 (string->url 
  (format "http://localhost:~a/compile/~a"
          port
          msg
          )))

(define (go)
  (port->string (get-pure-port 
                 (remote PORT MSG))))
                 