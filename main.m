clc;

fprintf("A más cantidad de nodos, más preciso es el resultado.\n");
nodos = input("Cantidad de nodos: ");

[altura, largo] = dimPlaca(nodos);
fprintf("Dimensiones de la placa: %dx%d\n\n", altura, largo);

Temp_sup = 500; % Temperatura superior de la placa
Temp_der = 400; % Temperatura lateral derecha de la placa
Temp_inf = 500; % Temperatura inferior de la placa
Temp_izq = 360; % Temperatura lateral izquierda de la placa

Placa = zeros(altura,largo); % Placa rectangular con nodos
Tn = 1; % Número de nodo
for fil = 1:altura
    for col = 1:largo
        Placa(fil,col) = Tn;
        Tn = Tn+1;
    end
end

n = altura*largo;
A = zeros(n,n); % Matriz de coeficientes | Es una matriz cuadrada
b = zeros(n,1); % Matriz independiente
for fil = 1:altura
    for col = 1:largo
        ecn = Placa(fil,col); % #ecuación
        A(ecn,ecn) = 4;
        if fil-1 > 0
            A(ecn, Placa(fil-1,col)) = -1;
        else
            b(ecn,1) = b(ecn,1)+Temp_sup;
        end
        if fil+1 < altura+1
            A(ecn, Placa(fil+1,col)) = -1;
        else
            b(ecn,1) = b(ecn,1)+Temp_inf;
        end
        if col-1 > 0
            A(ecn, Placa(fil,col-1)) = -1;
        else
            b(ecn,1) = b(ecn,1)+Temp_izq;
        end
        if col+1 < largo+1
            A(ecn, Placa(fil,col+1)) = -1;
        else
            b(ecn,1) = b(ecn,1)+Temp_der;
        end
    end
end

clear Tn ecn altura largo Temp_sup Temp_inf Temp_der Temp_izq;

% MÉTODO ITERATIVO SOBRERRELAJACIÓN SUCESIVA (SOR)
% [z] = metSORn(A, b, w, x0, Tol)

% Error absoluto/relativo
x0 = zeros(n,1);
fprintf("Error:\n[1] Absoluto\n[2] Relativo\n");
tipo_error = 0;
while tipo_error < 1 || tipo_error > 2
    tipo_error = input("Ingrese opción: ");
    if tipo_error < 1 || tipo_error > 2
        disp("No existe esa opción");
    end
end

% Tolerancia (se especificará su valor en las líneas 96 y 98)
if tipo_error == 1
    multiplicador = "0.5";
else
    multiplicador = "5";
end
fprintf("\nTolerancia: "+multiplicador+"*10^(-t) = "+multiplicador+"*(1e-t)\n");
t = -1;
while t < 0
    t = input("Ingrese t (t >= 0): ");
    if t < 0
        disp("No existe esa opción");
    end
end

% Factor de relajación
w = -1;
while w <= 0 || w >= 2 || w == 1
    % A =  M_nxn -> 0 < w < 2: SOR converge
    % w == 1 -> método Gauss Seidel (no hay relajación)
    w = input("\nFactor de relajación [(0 < w < 2) ~= 1]: ");
end

% Resolviendo con el método
if tipo_error == 1
    Tol = 0.5*10^(-t);
    x = metSOR1(A, b, w, x0, Tol);
else
    Tol = 5*10^(-t);
    x = metSOR2(A, b, w, x0, Tol);
end
fprintf("\nSolucionando con método SOR:\n");
disp(x);

clear t multiplicador tipo_error;

% Determinar si es convergente
% Si A es simétrica y definida positiva, el método SOR converge para
% cualquier 0 < w < 2
es_convergente = true;
if A == transpose(A)
    for iter = 1:n
        if det(A(1:iter,1:iter)) <= 0
            es_convergente = false;
            break;
        end
    end
end

fprintf("El método SOR ");
if es_convergente
    disp("es convergente.");
else
    disp("no es convergente.");
end

% Resultados
fprintf("\nLas temperaturas (K) de la placa son las siguientes:\n\n");
nueva_placa = resultado(x, Placa);
disp(nueva_placa);