[A, b, c] = lectura();
disp("[ASP1]Inici ASP1.")

[c_1, c_N, c_B, basiques, no_basiques, A_N, B_inv, x_b, z, A] = inicialitzar(A, b, c);

disp("[ASP1]  Fase I")
[A, b, c, basiques_1, no_basiques_1, x_b, z, B_inv, it_1] = simplex1(c_1, c_N, c_B, basiques, no_basiques, A_N, B_inv, x_b, z, A, b, c, 1);

if it_1 ~= -1

    disp("[ASP1] Fase II")
    simplex2(A, b, c, basiques_1, no_basiques_1, x_b, z, B_inv, it_1+1);
    

end
