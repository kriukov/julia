for j = 0:400
    r = j/100
    x = 0.2
    for i = 1:10^6
	x = r*x*(1-x)
    end
    for i = 10^6:10^6+100
	x = r*x*(1-x)
	println("$r $x")
    end
end