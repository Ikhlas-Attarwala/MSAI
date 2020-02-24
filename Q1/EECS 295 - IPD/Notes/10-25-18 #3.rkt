#lang dssl2
# global variables

struct count:
    let num: int?

let my_count = count(0)

# to compute the sum of all of the numbers
# that I have been graced with (so far)
# strategy: 
def sum_args(x: int?) -> int?:
    my_count.num = my_count.num + x
    my_count.num

test:
    assert_eq sum_args(11),11
    assert_eq sum_args(3),14
    assert_eq sum_args(6),20



def f(a: count?, b: count?):
    a.num = 2*b.num

let a_count = count(2)
let another_count = count(3)
let a_third_count = count(4)

f(a_count, another_count)
f(another_count, a_count)
f(a_third_count, another_count)

# try typing: a_count
# try typing: another_count
# try typing: a_third_count

def f2(a:count?, b:count?) -> int?:
    a.num=12345
    b.num

# try typing: f2(count(0), count(0))
#             let my_favorite_count = count(0)
#             f2(my_favorite_count,my_favorite_count)