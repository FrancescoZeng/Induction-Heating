function [phi, hs, B] = vett_pot(sigma, w, vk, mu, Rc1, Rc2)

% Discretizzazione
N = 300;                                              % punti utilizzati per discretizzare
hs1 = (linspace(0,Rc1^2,floor(N/3)))';                % 100 p.ti equispaziati nell'intervallo:[1mm^2,20mm^2]                   
hs2 = (linspace(Rc1^2,Rc2^2,floor(N/3)+1))';          % 101 p.ti equispaz. nell'intervallo:[20mm^2,25mm^2]
hs3 = (linspace(Rc2^2,(Rc2*10)^2,floor(N/3)+1))';
a = numel(hs1);
b = a+numel(hs2)-1;
c = b+numel(hs3)-1;
hs = [hs1(1:end-1);hs2(1:end-1);hs3(1:end)];
N = numel(hs);
h = diff(hs);         % spaziatura tra 2 p.ti adiacenti
hmu = 4/mu;           

% Generazione matrice Afd
Afd = gen_Afd(a,b,c,N,sigma,w,hs,h,hmu,mu);
f = zeros(N,1);
f(a+1:b-1) = sigma*vk/(2*pi);  

% Soluzione V
V = Afd\f;

% Soluzione phi
phi = V./sqrt(hs);
phi(1) = V(1);

% Calcolo del campo B
B(1) = 2*(V(2)-V(1))/h(1);
for j=2:a-1
B(j) = (V(j+1)-V(j-1))/(h(j));
end

end

