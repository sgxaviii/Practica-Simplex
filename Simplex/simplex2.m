function simplex2(A, b, c, basiques, no_basiques, x_b, z, B_inv,it)
    
%Calculem r:
A_N = A(:, no_basiques);
r = c(no_basiques) - c(basiques)*B_inv*A_N;
    
if r >= 0
    X = ['[ASP1]    Iteració ', num2str(it), ' : ', 'Solució òptima trobada.'];
    disp(X)
    disp("[ASP1]Fi ASP1")
    disp('VB* =')
    disp(basiques)
    disp('xb* = ')
    x_b = x_b';
    disp(x_b)
    disp('VNB* = ')
    disp(no_basiques)
    disp('r* = ')
    disp(r)
    disp('z* = ')
    disp(z)
    return
end
    
%Trobem la variable no bàsica d'entrada q

I = find(r < 0);
q = min(no_basiques(I));
index_q = find(no_basiques==q);
rq = r(index_q);
%Calculem les direccions bàsiques i la longitud de pas
d_b = -B_inv*A(:,q);

if d_b >= 0
    X = ['[ASP1]    Iteració ', num2str(it), ' : ', 'Probema Infactible'];
    disp(X)
    return
end


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

X = ['[ASP1]    Iteració ', num2str(it), ', q = ', num2str(q), ', rq = ', num2str(rq), ', B(p) = ', num2str(sortida), ', theta* = ', num2str(minim), ', z = ', num2str(z)];

disp(X)

simplex2(A, b, c, basiques, no_basiques, x_b, z, B_inv, it+1);

end
    
        