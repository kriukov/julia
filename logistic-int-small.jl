    r = 1.1
    x = Interval(0.2, 0.2)
    for i = 1:400
	x = Interval(r)*(Interval(1/4)-(x-Interval(1/2))^2)
	println("$r $x")
    end
