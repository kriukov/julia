## Newton's method (interval) code

include("interval.jl")
include("ad-int.jl")

N(x) = Interval(mid(x)) - f(Interval(mid(x)))//differentiate(f, x)
arr_a = Interval[]
arr_b = Interval[]
do_isect(x, y) = isectext(arr_a[x], arr_b[y])

a = Interval(-10, 10.001)
x = ad(a, Interval(1.))
f(x) = sin(x)*(x - cos(x))

push!(arr_a, a)

# cycle

arr_b = Interval[]

for i = 1:length(arr_a)
	push!(arr_b, N(arr_a[i]))
end

arr_a_new = Interval[]

for i = 1:length(arr_b)
	if do_isect(i, i) != false
		arr_a_new = vcat(arr_a_new, do_isect(i, i))
	end
end

arr_a = arr_a_new

