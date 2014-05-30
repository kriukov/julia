include("interval.jl")
include("ad-int.jl")

for i = -500:500
	a = Interval(i/10)
	x = ad(a, Interval(1.))
	f(x) = sin(x)
	y = mid(differentiate(f, a))
	print("{$(i/10), $y},")
end
