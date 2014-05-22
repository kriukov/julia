	# Initial conditions

	include("interval.jl")

	r0 = [Interval(0.5), Interval(0.1)]
	v0 = [Interval(1.), Interval(0)]
	rho = Interval(1)/3.

	t = Interval(0.)

	#norm2(x) = sqrt(x[1]^2 + x[2]^2)
	function norm2(x)
		d = x[1]^2 + x[2]^2
		if belong(0., d) 
			println(x)
			error("NEGATIVE (DPS)")
		end

		sqrt(d)
	end

	dot2(x, y) = x[1]*y[1] + x[2]*y[2]

	# Perpendicular (z-) component of cross product (scalar quantity) for 2-D vectors
	crossz(x, y) = x[1]*y[2] - x[2]*y[1]

	while t.hi <= 9.6

	# Arrays of times, n and m corresponding to each intersection in both solutions
	# Zeroing the elements with zeros() doesn't work for intervals, so we do it manually

	array_t1nm = Array(Interval, 30, 3)
	for i = 1:size(array_t1nm)[1]
		array_t1nm[i, 1] = Interval(0)
		array_t1nm[i, 2] = Interval(0)
		array_t1nm[i, 3] = Interval(0)
	end

	# Checking the real intersection points

	i = 1
	for n = -10.:10.
		for m = -10.:10.
			R = [n,m]
			if mid(abs(crossz(v0, r0 - R))) < mid(rho)
				t1 = -dot2(v0, r0 - R) - sqrt(abs(rho^2 - (crossz(v0, r0 - R))^2))
				array_t1nm[i, 1] = t1
				array_t1nm[i, 2] = Interval(n)
				array_t1nm[i, 3] = Interval(m)
				i = i + 1
			end
		end
	end

	# Extracting the minimum positive time from both arrays (one was discarded)

	tmin1 = Interval(Inf)
	n1 = 0.
	m1 = 0.
	for i = 1:size(array_t1nm)[1]-1
		if (mid(array_t1nm[i, 1]) < mid(tmin1)) && (mid(array_t1nm[i, 1]) > 0)
			tmin1 = array_t1nm[i, 1]
			n1 = array_t1nm[i, 2]
			m1 = array_t1nm[i, 3]
		end
	end


	tfinal = tmin1
	nfinal = n1
	mfinal = m1

	# import Base./
	# function /(x::Array{Interval,1}, y::Interval)
	# 	[x[1]/y, x[2]/y]
	# end

	# Normal vector at the point of collision

	# println("r0 = ", r0, ", v0 =", v0, "tfinal = ", tfinal, "nfinal = ", nfinal)

	radial = r0 + v0*tfinal - [nfinal, mfinal]

	println("radial = ", radial)

	rnorm = norm2(radial)
	#N = [radial/norm2(radial)
	N = [radial[1] / rnorm, radial[2]/rnorm]

	# New velocity
	v1 = v0 - N*dot2(v0, N)*Interval(2)

	# New position
	r1 = r0 + v0*tfinal

	# New time
	t = t + tfinal

	# Taking on the new values of v and r
	v0 = v1
	r0 = r1

	println("r0 = ", r0, "v0 = ", v0, "t = ", t)
	println(typeof(t.lo))

	end

	# Now the location will be

	r = r0 + v0*(Interval(10) - t)
	d = norm2(r)
	println("r = ", r, "d = ", d)
