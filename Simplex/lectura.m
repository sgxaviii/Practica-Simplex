function [A, b, c] = lectura()

n = input("Introdueix el nombre de files: ");
m = input("Introdueix el nombre de columnes: ");
A = zeros(n,m);


for i = 1:n
	fila = str2double(strsplit(input("", "s")));
	A(i,:) = fila(~isnan(fila));
end

b = str2double(strsplit(input("", "s")));
b = b(~isnan(b));

c = str2double(strsplit(input("", "s")));
c = c(~isnan(c));

end
