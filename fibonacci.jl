x = BigInt(1)
y = BigInt(1)
for i = 1:100
x = x + y
print(x) 
print(" ")
y = x + y
print(y) 
print(" ")
end