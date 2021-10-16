function I = idn(n)

% Generar matriz identidad
I = zeros(n,n);
for iter = 1:n
    I(iter,iter) = 1;
end

end

