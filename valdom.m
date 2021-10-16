function vpd = valdom(A)

vp = real(eig(A)); % Valores propios, en caso sean complejos 
                   % tomamos la parte real
vpd = vp(1); % Valor propio dominante temporal
for iter = 2:length(vp)
    lb = vp(iter);
    if abs(vpd) < abs(lb)
        vpd = lb; % Valor propio dominante
    end
end

end

