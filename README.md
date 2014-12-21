Pretty print bytes in a debugger/dump style.

I found this little function helpful while working through the first
couple sets of the [Matasano Crypto Challenges](http://cryptopals.com)
in Racket.

```racket
(pretty-print-bytes bstr
                    #:block-size [block-size 16]
                    #:non-display-char [n/a #\-])
```

Obviously if you will be typing this frequently, you may want to
rename it to something like `ppb`.

## Examples

```racket
(pretty-print-bytes #"Hello, world, I am a byte string which is the best string.")
```

prints:

```racket
[48 65 6c 6c 6f 2c 20 77 6f 72 6c 64 2c 20 49 20  Hello, world, I 
 61 6d 20 61 20 62 79 74 65 20 73 74 72 69 6e 67  am a byte string
 20 77 68 69 63 68 20 69 73 20 74 68 65 20 62 65   which is the be
 73 74 20 73 74 72 69 6e 67 2e                    st string.      ]
```

```racket
(pretty-print-bytes (list->bytes (for/list ([_ 60]) (random 256))))
```

prints

```racket
[5c 52 0e d8 9b f0 a5 ff b9 45 8f 46 58 61 30 e6  \R-------E-FXa0-
 96 a8 51 9c 1f 0f 5c 8e 8a 05 b4 89 5a a9 6c cc  --Q---\-----Z-l-
 18 d6 01 93 5d 5d f2 01 ee a6 69 ee 51 61 42 4b  ----]]----i-QaBK
 e1 cd 5e 16 1e bc 86 16 81 b2 83 cd              --^---------    ]
```
