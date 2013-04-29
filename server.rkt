#lang racket
(require web-server/dispatch
         web-server/dispatch 
         web-server/http
         web-server/servlet-env
         web-server/servlet/servlet-structs
         )

(define (compile req str)
  (printf "COMPILE: ~a~n" str)
  (response/xexpr
   #:code 200 `(compile "OK")))

(define (echo req str)
  (response/xexpr #:code 200 `(echo ,str)))

(define-values (dispatch req)
  (dispatch-rules
   [("compile" (string-arg)) compile]
   [("echo" (string-arg)) echo]))

(define (serve)
  (with-handlers ([exn:fail? 
                   (lambda (e) 'ServeFail)])
    (serve/servlet dispatch
                   #:launch-browser? #f
                   #:port 9000
                   #:listen-ip #f
                   #:server-root-path (current-directory)
                   #:servlet-path "/"
                   #:servlet-regexp #rx""
                   )))

(serve)