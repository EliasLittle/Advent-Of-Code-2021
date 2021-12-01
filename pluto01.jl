### A Pluto.jl notebook ###
# v0.17.1

using Markdown
using InteractiveUtils

# ╔═╡ 988cecb8-5c0f-473e-90da-da48ec9f93ae
md"# Day 1"

# ╔═╡ 559fdfa0-7d11-4c8a-bba5-6b4886fc7796
md"### Part 1"

# ╔═╡ 0ddf2ef7-7350-49da-859a-959770822e4a
md"""
As the submarine drops below the surface of the ocean, it automatically performs a sonar sweep of the nearby sea floor. On a small screen, the sonar sweep report (your puzzle input) appears: each line is a measurement of the sea floor depth as the sweep looks further and further away from the submarine.

For example, suppose you had the following report:

```
199
200
208
210
200
207
240
269
260
263
```
This report indicates that, scanning outward from the submarine, the sonar sweep found depths of 199, 200, 208, 210, and so on.

The first order of business is to figure out how quickly the depth increases, just so you know what you're dealing with - you never know if the keys will get carried into deeper water by an ocean current or a fish or something.

To do this, count the number of times a depth measurement increases from the previous measurement. (There is no measurement before the first measurement.) In the example above, the changes are as follows:

```
199 (N/A - no previous measurement)
200 (increased)
208 (increased)
210 (increased)
200 (decreased)
207 (increased)
240 (increased)
269 (increased)
260 (decreased)
263 (increased)
```
In this example, there are 7 measurements that are larger than the previous measurement.

**How many measurements are larger than the previous measurement?**
"""

# ╔═╡ 5cd363e2-5244-11ec-2995-b10d950c58cb
function solution(filename)
	depths = []
	open(filename) do file
		for line in eachline(file)
			append!(depths, parse(Int, line))
		end
	end

	count = 0
	for i in 2:length(depths)
		if depths[i] > depths[i-1]
			count += 1
		end
	end
	return count
end

# ╔═╡ b8b84c91-a66a-4700-9c68-ca1cffbec41a
solution("day01.txt")

# ╔═╡ a4e7a20a-1e66-42e2-b96b-441d5aa3e32f
md"### Part 2"

# ╔═╡ 53619b37-5373-4dda-a44a-85b1fc598d85
md"""
Considering every single measurement isn't as useful as you expected: there's just too much noise in the data.

Instead, consider sums of a three-measurement sliding window. Again considering the above example:

```
199  A      
200  A B    
208  A B C  
210    B C D
200  E   C D
207  E F   D
240  E F G  
269    F G H
260      G H
263        H
```
Start by comparing the first and second three-measurement windows. The measurements in the first window are marked A (199, 200, 208); their sum is 199 + 200 + 208 = 607. The second window is marked B (200, 208, 210); its sum is 618. The sum of measurements in the second window is larger than the sum of the first, so this first comparison increased.

Your goal now is to count the number of times the sum of measurements in this sliding window increases from the previous sum. So, compare A with B, then compare B with C, then C with D, and so on. Stop when there aren't enough measurements left to create a new three-measurement sum.

In the above example, the sum of each three-measurement window is as follows:

```
A: 607 (N/A - no previous sum)
B: 618 (increased)
C: 618 (no change)
D: 617 (decreased)
E: 647 (increased)
F: 716 (increased)
G: 769 (increased)
H: 792 (increased)
```
In this example, there are 5 sums that are larger than the previous sum.

Consider sums of a three-measurement sliding window. **How many sums are larger than the previous sum?**
"""

# ╔═╡ 5b4bd798-dc95-4ebd-a34f-6d3658217f06
function solution2(filename)
	depths = []
	open(filename) do file
		for line in eachline(file)
			append!(depths, parse(Int, line))
		end
	end

	count = 0
	for i in 4:length(depths)
		l1 = [depths[j] for j in i-3:i-1]
		l2 = [depths[j] for j in i-2:i]
		if sum(l2) > sum(l1)
			count += 1
		end
	end
	return count
end

# ╔═╡ f40c2f9f-54ba-4749-ae27-daad31792063
solution2("day01.txt")

# ╔═╡ d1bbfe8c-7bb4-4c82-b812-23469321e731
md"

"

# ╔═╡ 51475956-a7bd-465d-8f23-e6263b2ca5c9
md"### Golf ⛳ Version"

# ╔═╡ e13554ce-0528-4f08-bd31-df5cb16db635
begin
d = parse.(Int,split(read("day01.txt",String),"\n")[1:end-1])
sum(d[2:end].>d[1:end-1]),sum([sum(d[i-2:i]).>sum(d[i-3:i-1]) for i in 4:length(d)])
end

# ╔═╡ Cell order:
# ╟─988cecb8-5c0f-473e-90da-da48ec9f93ae
# ╟─559fdfa0-7d11-4c8a-bba5-6b4886fc7796
# ╟─0ddf2ef7-7350-49da-859a-959770822e4a
# ╠═5cd363e2-5244-11ec-2995-b10d950c58cb
# ╠═b8b84c91-a66a-4700-9c68-ca1cffbec41a
# ╟─a4e7a20a-1e66-42e2-b96b-441d5aa3e32f
# ╟─53619b37-5373-4dda-a44a-85b1fc598d85
# ╠═5b4bd798-dc95-4ebd-a34f-6d3658217f06
# ╠═f40c2f9f-54ba-4749-ae27-daad31792063
# ╟─d1bbfe8c-7bb4-4c82-b812-23469321e731
# ╟─51475956-a7bd-465d-8f23-e6263b2ca5c9
# ╠═e13554ce-0528-4f08-bd31-df5cb16db635
