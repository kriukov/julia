# This cycle code outputs good results for the Tucker exercise on p. 82, but it loses a root after 5 - 7 iterations.

arr_b = Interval[]

for i = 1:length(arr_a)
	push!(arr_b, N(arr_a[i]))
end

arr_a_new = Interval[]

for i = 1:max(length(arr_a), length(arr_b))
		if do_isect(i, i) != arr_a[i] && do_isect(i, i) != false
			arr_a_new = vcat(arr_a_new, do_isect(i, i))
		end
end

arr_a = arr_a_new

