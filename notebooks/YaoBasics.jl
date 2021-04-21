### A Pluto.jl notebook ###
# v0.14.2

using Markdown
using InteractiveUtils

# ╔═╡ 006e37a0-a26b-11eb-00c4-25633f8481ab
begin
	using DrWatson
	quickactivate(findproject())
	
	using Pkg
	Pkg.instantiate()
	
	using PlutoUI
	using Yao, YaoPlots
	
end

# ╔═╡ 5f50d00e-9ce9-41fe-b248-59c277b5174e
md"# Yao basics"

# ╔═╡ 0e77c904-6f2b-41a5-a27e-5d17adfdd984
with_terminal() do
	Pkg.status()
end

# ╔═╡ 7a18cb3d-8fb9-4067-b98c-084677eec44b
md"
Yao represents quantum circuits/gates using **Yao Blocks**, they are a collection of Julia objects.

For example, you can implement a quantum Fourier transformation circuit as following:
"

# ╔═╡ 4f58182c-e9b5-489b-8403-5615956f04a5
A(i, j) = control(i, j=>shift(2π/(1<<(i-j+1))))

# ╔═╡ 61741646-7a47-4b0d-9f7f-51a6a4b34b11
B(n, k) = chain(n, j==k ? put(k=>H) : A(j, k) for j in k:n)

# ╔═╡ 3749bf71-be62-4d51-9a33-bafd69e74928
qft(n) = chain(B(n, k) for k in 1:n)

# ╔═╡ 674d1b8d-bc1b-49de-a2d6-f098f1adba6a
plot(qft(3))

# ╔═╡ a223976d-a323-4bee-ba93-caab8ea94e28
md"
here we use `plot` function to plot the generated quantum circuit, you can also use it to check what are the block `A` and block `B`.

The `chain` function is used to chain two blocks of same size together:
"

# ╔═╡ b21837b4-a1d7-494c-8a7a-e1d5b2a4cbfe
plot(chain(X, Y, H))

# ╔═╡ 772043b4-624e-4011-9a6f-7363f5f94da7
md"
the `put` function is used to put a gate on a specific location, it thus creates a larger block
"

# ╔═╡ b289ec5c-ec09-43ea-addd-0e3adf03451f
plot(put(5, 2=>H))

# ╔═╡ 689422c5-b36c-4750-80c3-039f35f7e230
md"
the control gates are defined using `control` block with another block as its input.

- the 1st argument is the number of qubits

- the 2nd argument is the controlled gate and its location
"

# ╔═╡ 3573ce31-d34d-4ef7-b2c0-893f9c6b178c
plot(control(5, 3, 2=>H))

# ╔═╡ 1a9fcaa6-394b-4746-866f-a5fe3dd398de
md"
the quantum blocks defined for a quantum circuit eventually form a tree-like structure, they are also printed in this way:
"

# ╔═╡ 3e9df781-07b4-4263-a720-06ac9fd78cdc
qft(3)

# ╔═╡ Cell order:
# ╟─5f50d00e-9ce9-41fe-b248-59c277b5174e
# ╠═006e37a0-a26b-11eb-00c4-25633f8481ab
# ╠═0e77c904-6f2b-41a5-a27e-5d17adfdd984
# ╟─7a18cb3d-8fb9-4067-b98c-084677eec44b
# ╠═4f58182c-e9b5-489b-8403-5615956f04a5
# ╠═61741646-7a47-4b0d-9f7f-51a6a4b34b11
# ╠═3749bf71-be62-4d51-9a33-bafd69e74928
# ╠═674d1b8d-bc1b-49de-a2d6-f098f1adba6a
# ╟─a223976d-a323-4bee-ba93-caab8ea94e28
# ╠═b21837b4-a1d7-494c-8a7a-e1d5b2a4cbfe
# ╟─772043b4-624e-4011-9a6f-7363f5f94da7
# ╠═b289ec5c-ec09-43ea-addd-0e3adf03451f
# ╟─689422c5-b36c-4750-80c3-039f35f7e230
# ╠═3573ce31-d34d-4ef7-b2c0-893f9c6b178c
# ╟─1a9fcaa6-394b-4746-866f-a5fe3dd398de
# ╠═3e9df781-07b4-4263-a720-06ac9fd78cdc
