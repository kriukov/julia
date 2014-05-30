## Automatic differentiation

# First define the point (a = ...), then include("ad.jl"). Then define f(x). f(x) will then output ad(f(x), f'(x)).

type ad
    u
    up
end

ad(c) = ad(c, 0)

# x = ad(a, 1)

prec = Float64

differentiate(f, a) = f(ad(a, 1)).up

function +(x::ad, y::ad)
    ad(x.u + y.u, x.up + y.up)
end

function -(x::ad, y::ad)
    ad(x.u - y.u, x.up - y.up)
end

function *(x::ad, y::ad)
    ad(x.u*y.u, x.u*y.up + y.u*x.up)
end

function /(x::ad, y::ad)
    ad(x.u/y.u, (x.up - (x.u/y.u)*y.up)/y.u)
end

function *(x::ad, y::prec)
    ad(x.u*y, x.up*y)
end

function *(x::prec, y::ad)
    ad(x*y.u, x*y.up)
end

function +(x::prec, y::ad)
    ad(x) + y
end

function +(x::ad, y::prec)
    x + ad(y)
end

function -(x::prec, y::ad)
    ad(x) - y
end

function -(x::ad, y::prec)
    x - ad(y)
end

# Chain rule

# ad(x::ad) = ad() don't know yet

