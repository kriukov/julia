# The four operations on intervals. Left end is rounded down, right end is rounded up.

type Interval
    lo
    hi
end

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
