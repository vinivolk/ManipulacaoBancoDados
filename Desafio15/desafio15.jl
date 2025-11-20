Threads.nthreads()

# criando um loop que demanda mais poder computacional
function loop_pesado(x)
    s = 0.0
    for i in 1:5_000_000
        s += sin(x) * cos(i)
    end
    return s
end

N = 100

# reprodução em serie
serie = @timed [loop_pesado(i) for i in 1:N]

# reprodução em paralelo
paralelo = @timed begin
    v = Vector{Float64}(undef, N)
    Threads.@threads for i in 1:N
        v[i] = loop_pesado(i)
    end
    v
end

# Acessando os tempos
println("Tempo serie:   ", serie.time)
println("Tempo paralelo: ", paralelo.time)