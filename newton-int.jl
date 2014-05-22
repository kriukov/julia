## Newton's method (interval) code

# ad.jl code needs to be addressed at every step

include("interval.jl")
include("ad.jl")

for i = 1:30
    N = Interval(mid(a)) - Interval(f(mid(a)))/f(x).up
    include("ad.jl")
    a = isect(N, a)
end

println(a)