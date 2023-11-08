function [A, b, c, basiques_1, no_basiques_1, x_b, z, B_inv, it_1] = simplex1(c_1, c_N, c_B, basiques, no_basiques, A_N, B_inv, x_b, z, A, b, c, it)

%Calculem els costos reduits r
r = c_N - c_B*B_inv*A_N;

if all(r >= 0)
    if z > eps
        basiques_1 = 0;
        no_basiques_1 = 0;
        z = 0;
        it_1 = -1;
        X = ['[ASP1]    Iteració ', num2str(it), ' : ', 'Probema Infactible'];
        disp(X)
        return
    end
    X = ['[ASP1]    Iteració ', num2str(it), ' : ', 'Solució bàsica factible trobada.'];
    disp(X)
    mask = no_basiques > length(no_basiques);
    no_basiques_1 = no_basiques(~mask);
    basiques_1 = basiques;
    z = c(basiques)*x_b;
    it_1 = it;
    return
end
%Trobem la variable no bàsica d'entrada q
I = find(r < 0);
q = min(no_basiques(I));
index_q = find(no_basiques==q);
rq = r(index_q);

%Calculem les direccions bàsiques i la longitud de pas
d_b = -B_inv*A(:,q);


theta = ones([1,length(x_b)])*Inf;

for i = 1:length(theta);
    if d_b(i) < 0
        theta(i) = -x_b(i)/d_b(i);
    end
end

[M,I] = min(theta);

minim = M;
bp = min(basiques(I));
p = find(basiques == bp);

    

%Actualitzem les bases
x_b = x_b + minim*d_b;
x_b(p) = minim;

z = z + rq*minim;

sortida = basiques(p);
entrada = q;

basiques(basiques == sortida) = entrada;
no_basiques(no_basiques == entrada) = sortida;

eta = -d_b/d_b(p);
eta(p) = -1/d_b(p);

H = eye(length(d_b));
H(:,p) = eta';

B_inv = H*B_inv;

A_N = A(:,no_basiques);


c_N = c_1(no_basiques);
c_B = c_1(basiques);

X = ['[ASP1]    Iteració ', num2str(it), ', q = ', num2str(q), ', rq = ', num2str(rq), ', B(p) = ', num2str(sortida), ', theta* = ', num2str(minim), ', z = ', num2str(z)];

disp(X)

[A, b, c, basiques_1, no_basiques_1, x_b, z, B_inv, it_1] = simplex1(c_1, c_N, c_B, basiques, no_basiques, A_N, B_inv, x_b, z, A, b, c, it+1);

end


    


        
    
    
    
    
        
    