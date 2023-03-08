#Find the right triangle that has integers for alla sides, all sides
#equal to or smaller than 10 and a perimeter of 24
[(a, b, c) for a in range(1,11) for b in range(a,11) for c in range(b,11) if (a + b+ c == 24) if (a*a+b*b==c*c)]