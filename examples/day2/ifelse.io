# if elseif else 的另一种写法
a := 100
if(a==100, "OK" println, "NOT" println);

x := 10
y := 20
if(y < 10) then(
		x := y
	       ) elseif(y == 11) then(
		       x := 0
		       ) elseif(y == 11) then(
			       x := 0
			       ) else(
				       x := 2
				     )
