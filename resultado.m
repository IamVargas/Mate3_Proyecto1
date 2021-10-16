function  nueva_placa = resultado(x, Placa)

[m,n] = size(x);
vector_temperaturas = x(m,1:n-1); % vector fila
iter = 1;
[m,n] = size(Placa);
nueva_placa = zeros(m,n);
for fil = 1:m
    for col = 1:n
        nueva_placa(fil,col) =  vector_temperaturas(iter);
        iter = iter+1;
    end
end

end

