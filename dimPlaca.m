function [m, n] = dimPlaca(nodos)

divisores = zeros(2,1);
divisorMAX = round(nodos/2);
if mod(nodos, 2) == 0
    divisorMAX = divisorMAX - 1;
end

col = 1;
for divisor = 1:divisorMAX
    if mod(nodos,divisor) == 0
        divisores(1,col) = divisor;
        divisores(2,col) = nodos/divisor;
        col = col+1;
    end
end

[~,colMAX] = size(divisores);

diferenciaMIN = abs(divisores(1,1) - divisores(2,1));
for col = 2:colMAX
    diferencia = abs(divisores(1,col) - divisores(2,col));
    if diferenciaMIN > diferencia
        diferenciaMIN = diferencia;
        m = divisores(1,col);
        n = divisores(2,col);
    end
end

if m > n
    temp = m;
    m = n;
    n = temp;
end

end

