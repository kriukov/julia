T(x) = r*x*(1.0 - x)
r = 3.8286

# Finding solutions for T^2 (x) = x
f(x) = T(T(x)) - x

a = 0.1

for i = 1:20
    a = i/10
    include("newton.jl")
end