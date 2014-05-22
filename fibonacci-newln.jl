x = BigInt(1)
y = BigInt(1)
for i = 1:100
x = x + y
println(x) 
y = x + y
println(y) 
end