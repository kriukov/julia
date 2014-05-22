## Newton's method (non-interval) code. 30 steps seem to be enough.

# ad.jl code needs to be addressed at every step

include("ad.jl")

for i = 1:30
    a = a - f(a)/f(x).up
    include("ad.jl")
end

println(a)