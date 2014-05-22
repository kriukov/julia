for j = 0:400
    r = j/100
    x = Interval(0.2)
    for i = 1:10^6
	x = Interval(r)*(Interval(1/4)-(x-Interval(1/2))^2)
    end
    for i = 10^6:10^6+100
	x = Interval(r)*(Interval(1/4)-(x-Interval(1/2))^2)
	println("$r $x")
    end
end
