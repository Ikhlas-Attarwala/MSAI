#lang dssl2
import cons # for lists

# Streams

# A Stream-of-numbres :
#   (make-stream Number (-> Stream-of-numbers))
# (define-struct Stream (ele rest))
# ; ones : Stream-of-numbers
# (define ones (con 1 ones))

let stream_of_numbers: contract? = stream? # don't need ": contract?"

struct stream:
    let ele: num?
    let rest: FunC[stream?]
# if it took two number:
#   let rest: FunC[num?,num?,stream?] # last one is always the ??

#let ones: stream? = stream(1,ones) #could just leave out ": stream?"

let ones = \
    stream(1, λ: ones) #function of no arguments, returns 1
let twos : stream? = \
    stream(2, λ: twos)

# try typing in: ones.ele
# try typing in: ones.rest().ele
# try typing in: ones.rest().rest().ele

# =====================================================================
# =====================================================================

# stream template:
def stream_template(s: stream_of_numbers): # can do stream_of_numbers or stream? b/c ^^ stream_of_numbers = stream?
# 1 alternative (no either or OrC)
# 2 compound data
    s.ele
    stream_template(s.rest())
# 3 references ^ use () <- function?

# to produce a stream that is like `s` but with each element
# being one larger than te corresponding element in `s`
# strategy : structural decomposition
def add1_stream(s: stream?) -> stream?:
    stream(s.ele+1,
           λ: add1_stream(s.rest())) # which stream ? : forget the first element, and then add to the rest of the string
           # contract said we need to be a function, but that's the function that returns it...?

#strategy: struct.decomp. on both `n` and `s`
def take(n: nat?, s: stream?):
    if n == 0:
        nil()
    else:
        cons(s.ele,take(n-1, s.rest()))

assert_eq take(10, add1_stream(ones)), take(10,twos) #assert_eq doesn't test on functions
# or can test as:
#test:
#    assert_eq take(10, add1_stream(ones)), take(10,twos)


# let nats : stream? = stream(0, add1_stream(nats))
let nats : stream? = stream(0, λ: add1_stream(nats)) # λ means I'm making a function!

# try typing in: nats.ele
# try typing in: nats.rest().ele
# try typing in: nats.rest().rest().ele