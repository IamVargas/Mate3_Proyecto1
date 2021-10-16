function [z] = metSOR1(A, b, w, x0, Tol)

D = diag(diag(A));
w_opt = w;

% Calcular factor de relajación ópitmo (w_opt)
% para una tasa de convergencia mayor
if w > 0 && w < 2
    [n,~] = size(A);
    Cj = idn(n)-D\A; % Matriz de iteración de Jacobi
    u = abs(valdom(Cj)); % Radio espectral
    if u < 1
        if det(A) ~= 0
            w_opt = 1 + (u / (1+sqrt(1-u^2)) )^2;            
        end
    end

end

L = -tril(A,-1);
U = -triu(A,1);
Tw = -(D-w_opt*L)\(-w_opt*U+(w_opt-1)*D); % Matriz de iteración
Cw = (D-w_opt*L)\(w_opt*b); % Vector columna
error = 1;
z = [x0' error];
while error > Tol
    x1 = Tw*x0 + Cw;
    error = norm(x1-x0, inf);
    z = [z;x1' error];
    x0 = x1;
end

end