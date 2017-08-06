#!/usr/bin/env python2.7

def map1(f, xs):
    if not xs:
        return []
    else:
        return [f(xs[0])] + map1(f, xs[1:])

def filter1(p, xs):
    if not xs:
        return []
    elif p(xs[0]):
        return [xs[0]] + filter1(p, xs[1:])
    else:
        return filter1(p, xs[1:])

def reduce1(f, a, xs):
    if not xs:
        return a
    else:
        return reduce1(f, f(a, xs[0]), xs[1:])

def foldr(f, a, xs):
    if not xs:
        return a
    else:
        return f(xs[0], foldr(f, a, xs[1:]))

def map2(f, xs):
    return foldr(lambda x, a: [f(x)]+a, [], xs)

def filter2(p, xs):
    return foldr(lambda x, a: [x]+a if p(x) else a, [], xs)

def reduce2(f, a, xs):
    return foldr(lambda x, a: f(a, x), a, xs)

assert map1(lambda x: x*x, range(1, 6)) == [1, 4, 9, 16, 25]
assert filter1(lambda x: x&1, range(1, 6)) == [1, 3, 5]
assert reduce1(lambda a, x: a/x, 120, range(1, 6)) == 1
assert reduce1(lambda a, x: a+x,   0, range(1, 6)) == 15
assert reduce1(lambda a, x: a*x,   1, range(1, 6)) == 120

assert foldr(lambda x, a: a/x, 120, range(1, 6)) == 1
assert foldr(lambda x, a: x+a,   0, range(1, 6)) == 15
assert foldr(lambda x, a: x*a,   1, range(1, 6)) == 120

assert map2(lambda x: x*x, range(1, 6)) == [1, 4, 9, 16, 25]
assert filter2(lambda x: x&1, range(1, 6)) == [1, 3, 5]
assert reduce2(lambda a, x: a/x, 120, range(1, 6)) == 1
assert reduce2(lambda a, x: a+x,   0, range(1, 6)) == 15
assert reduce2(lambda a, x: a*x,   1, range(1, 6)) == 120
