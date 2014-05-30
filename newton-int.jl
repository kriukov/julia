## Newton's method (interval) code

include("interval.jl")
include("ad-int.jl")

N(x) = Interval(mid(x)) - f(Interval(mid(x)))//differentiate(f, x)
arr_a = Interval[]
arr_N = Interval[]
places = Interval[]
do_isect(x) = isectext(arr_N[x], arr_a[x])

a = Interval(-10, 10.001)
x = ad(a, Interval(1.))
f(x) = sin(x)*(x - cos(x))

push!(arr_a, a)

arr_N = Interval[]

for i = 1:length(arr_a)
	push!(arr_N, N(arr_a[i]))
end

for i = 1:length(arr_N)
	for j = 1:length(do_isect(i))
		push!(places, do_isect(i)[j])
	end
end

arr_a = places

places = Interval[]


for i = 1:length(arr_a)
	push!(arr_N, N(arr_a[i]))
end






#=

for i = 1:30
    N = Interval(mid(a)) - f(Interval(mid(a)))//differentiate(f, a)
    a = isectext(N, a)
    println(a)
end

println(a)
=#
