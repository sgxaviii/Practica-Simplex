function [c_1, c_N, c_B, basiques, no_basiques, A_N, B_inv, x_b, z, A] = inicialitzar(A, b, c)

   n = length(b);
	A = [A, eye(n)];

	c_1 = [zeros([1,length(c)]), ones([1,length(b)])];

	basiques = [length(c)+1:length(c)+length(b)];

	no_basiques = [1:length(c)];

	x_b = b';

	B_inv = eye(n);

	z = sum(b);

	c_N = c_1(no_basiques);
	c_B = c_1(basiques);
   A_N = A(:,no_basiques);


end
