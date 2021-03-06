## Interval arithmetic

type Interval
    lo
    hi
end

# Thin (degenerate) interval

Interval(x) = Interval(x, x)

# The four operations on intervals. Left end is rounded down, right end is rounded up.

# Addition

function +(x::Interval, y::Interval) 
    z1 = with_rounding(Float64, RoundDown) do
	x.lo + y.lo
    end
    z2 = with_rounding(Float64, RoundUp) do
	x.hi + y.hi
    end
    Interval(z1, z2)
end

# Subtraction

function -(x::Interval, y::Interval) 
    z1 = with_rounding(Float64, RoundDown) do
	x.lo - y.hi
    end
    z2 = with_rounding(Float64, RoundUp) do
	x.hi - y.lo
    end
    Interval(z1, z2)
end

# Multiplication

function *(x::Interval, y::Interval)
    z1 = with_rounding(Float64, RoundDown) do
	min(x.lo*y.lo, x.lo*y.hi, x.hi*y.lo, x.hi*y.hi)
    end
    z2 = with_rounding(Float64, RoundUp) do
	max(x.lo*y.lo, x.lo*y.hi, x.hi*y.lo, x.hi*y.hi)
    end
    Interval(z1, z2)
end

# Division

function /(x::Interval, y::Interval) 
    z1 = with_rounding(Float64, RoundDown) do
	1/y.hi
    end
    z2 = with_rounding(Float64, RoundUp) do
	1/y.lo
    end
    x*Interval(z1, z2)
end

## Interval properties

# Whether the point belongs to the interval

function belong(p::Float64, x::Interval)
    if p >= x.lo && p <= x.hi
	return true
    else return false
    end
end

function belong(p::Int32, x::Interval)
    if p >= x.lo && p <= x.hi
	return true
    else return false
    end
end


# Radius, midpoint, mignitude, magnitude, absolute value

rad(x::Interval) = (x.hi - x.lo)/2
mid(x::Interval) = (x.hi + x.lo)/2

function mig(x::Interval)
    if belong(0.0, x) == true
	return 0
    else return min(abs(x.lo), abs(x.hi))
    end
end

mag(x::Interval) = max(abs(x.lo), abs(x.hi))

import Base.abs
function abs(x::Interval)
    Interval(mig(x), mag(x))
end

# Hausdorff distance

hd(x::Interval, y::Interval) = max(abs(x.lo - y.lo), abs(x.hi - y.hi))

# "Union" (hull) and intersection

hull(x::Interval, y::Interval) = Interval(min(x.lo, y.lo), max(x.hi, y.hi))

function isect(x::Interval, y::Interval)
    if x.hi < y.lo || y.hi < x.lo
	return 0
    else return Interval(max(x.lo, y.lo), min(x.hi, y.hi))
    end
end

# Elementary functions

import Base.exp
exp(x::Interval) = Interval(exp(x.lo), exp(x.hi))

import Base.sqrt
sqrt(x::Interval) = Interval(sqrt(x.lo), sqrt(x.hi))

import Base.log
log(x::Interval) = Interval(log(x.lo), log(x.hi))

function ^(x::Interval, n::Int32)
    if n > 0 && n % 2 == 1
	return Interval(x.lo^n, x.hi^n)
    elseif n > 0 && n % 2 == 0
	return Interval((mig(x))^n, (mag(x))^n)
    elseif n == 0
	return Interval(1, 1)
    elseif n < 0 && belong(0, x) == false
	return Interval(1/x.hi, 1/x.lo)^(-n)
#    elseif return println("Error")
    end
end

import Base.sin
function sin(x::Interval)

    k = 0
    pcount = 0
    for k = -1000:1000
	p = pi/2 + 2pi*k
	if belong(p, x) == true
	    pcount = pcount + 1
	end
    end
    
    k = 0
    qcount = 0
    for k = -1000:1000
	q = - pi/2 + 2pi*k
	if belong(q, x) == true
	    qcount = qcount + 1
	end
    end
    
    if qcount != 0 && pcount != 0
	return Interval(-1, 1)
    elseif qcount != 0 && pcount == 0
	return Interval(-1, max(sin(x.lo), sin(x.hi)))
    elseif qcount == 0 && pcount != 0
	return Interval(min(sin(x.lo), sin(x.hi)), 1)
    elseif qcount == 0 && pcount == 0
	return Interval(min(sin(x.lo), sin(x.hi)), max(sin(x.lo), sin(x.hi)))
    end
end

cos(x::Interval) = sin(Interval(x.lo + pi/2, x.hi + pi/2))





for j = 0:400
    r = j/100
    x = Interval(0.2)
    for i = 1:10^6
	x = Interval(r)*(Interval(1/4)-(x-Interval(1/2))^2)
    end
    for i = 10^6:10^6+100
	x = Interval(r)*(Interval(1/4)-(x-Interval(1/2))^2)
	y = (x.hi+x.lo)/2
	println("$r $y")
    end
end
