typealias prec BigFloat

type Interval
lo
hi
function Interval(x, y)
set_rounding(prec, RoundDown)
xx = BigFloat(x)

set_rounding(prec, RoundUp)
yy = BigFloat(y)

new(xx, yy)
end
end
