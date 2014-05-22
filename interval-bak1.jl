type Interval
    lo
    hi
end

+(x::Interval, y::Interval) = Interval(x.lo + y.lo, x.hi + y.hi)
-(x::Interval, y::Interval) = Interval(x.lo - y.hi, x.hi - y.lo)
*(x::Interval, y::Interval) = Interval(min(x.lo*y.lo, x.lo*y.hi, x.hi*y.lo, x.hi*y.hi), max(x.lo*y.lo, x.lo*y.hi, x.hi*y.lo, x.hi*y.hi))
/(x::Interval, y::Interval) = x*Interval(1/y.hi, 1/y.lo)