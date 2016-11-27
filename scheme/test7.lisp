(define (menor-dist pontos pontoinicial)
    (cdr
        (fold
            (lambda (acc elemento)
                (let
                    ((indiceAtual (car acc))
                     (indice (cadr acc))
                     (menorDist (caddr acc))
                     (distAtual (distancia pontoinicial elemento)))
                    (if (< distAtual menorDist)
                        (list (+ indiceAtual 1) indiceAtual distAtual)
                        (list (+ indiceAtual 1) indice menorDist)
)   )   ) `(0 -1 99999999) pontos )))

(define (distancia ponto1 ponto2)
    (let
        ((x1 (car ponto1)) (x2 (car ponto2))
         (y1 (cadr ponto1)) (y2 (cadr ponto2)))
        (sqrt (+ (* (- x1 x2) (- x1 x2)) (* (- y1 y2) (- y1 y2))))
)   )