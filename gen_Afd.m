function [Afd] = gen_Afd(a,b,c,N,sigma,w,hs,h,hmu,mu)
% Funzione che genera la matrice AFd

% Inizializzazione della matrice ed inserimento dei coefficienti
Afd = zeros(N,N);
for j = (2):(a-1)   % (a-1)=99
Afd(j,j-1) = hmu.*sqrt(hs(j))./(h(j).^2);
Afd(j,j)   = -2*hmu.*sqrt(hs(j))./(h(j).^2);
Afd(j,j+1) = hmu.*sqrt(hs(j))./(h(j).^2);
end

for j=(a+1):(b-1)
Afd(j,j-1) = -hmu.*hs(j)./(h(j).^2);
Afd(j,j)   = 2*hmu.*hs(j)./(h(j).^2)+1i*sigma*w;
Afd(j,j+1) = -hmu.*hs(j)./(h(j).^2);
end

for j=(b+1):(c-1)
Afd(j,j-1) = hmu.*sqrt(hs(j))./(h(j).^2);
Afd(j,j)   = -2*hmu.*sqrt(hs(j))./(h(j).^2);
Afd(j,j+1) = hmu.*sqrt(hs(j))./(h(j).^2);
end

% Condiz. interf. in a: 25mm
Afd(a,a-1) = -2/(mu.*h(a));
Afd(a,a)   = 4/(mu.*h(a));
Afd(a,a+1) = -2/(mu.*h(a));

% Condiz. interf. in b: 30mm
Afd(b,b-1) = -2/(mu.*h(b));
Afd(b,b)   = 4/(mu.*h(b));
Afd(b,b+1) = -2/(mu.*h(b));

% Condiz. al contorno di Dirichlet in 0
Afd(1,1) = 1;

%Condiz. al  contorno  di Robin in c
Afd(c,c-1) = 2.*hs(c)./h(c-1);
Afd(c,c) = 2.*hs(c)./h(c-1)+1;

end

