% INDUCTION HEATING

%% Inizializzazione

% Coil in Stainless Steel X5CrNi 18/9 (1.4301)
f = 10000;                % frequenza[Hz]
w = 2*pi*f;               % pulsazione
Tf = 950;                 % temp. finale [Gradi Celsius]
Tamb = 20;                % temp. ambiente [Gradi Celsius]
vk = 77;                  % tensione applicata[V]
mu = 1.256637e-6;         % perm. magnetica nel vuoto[H/m]
stb = 5.670374e-8;        % cost.di Stefan-Boltzmann [W*m^-2*K^-4]

% Sigma: conducibilita' elettrica
a = 4.6659e-5;     
b = 8.4121e-9;
c = -3.7246e-13;
d = 6.1960e-16;
        % a = 4.9659e-7;
        % b = 8.412e-10;
        % c = -3.7246e-13;
        % d = 6.1960e-17;
sigma = 1/(a+b*Tf+c*Tf^2+d*Tf^3);

% Distanze tra l'origine e il..
Rc1 = 25e-3;            % ..raggio interno del coil
Rc2 = 30e-3;            % ..raggio esterno del coil

%% Funzione vettore potenziale
[phi,hs,B] = vett_pot(sigma, w, vk, mu, Rc1, Rc2);

% Valori dei campi H e B all'interno del coil
campoH = max(abs(B)/mu)
campoB = max(abs(B))

% Grafici potenziale vettore e Campi B,H
figure(1)
plot(sqrt(hs), abs(phi), 'r')
title('MODULO DEL VETTORE POTENZIALE')
xlabel('RAGGIO r');
ylabel('MODULO DI PHI');
legend('PHI')

figure(2)
plot(sqrt(hs(1:99)),abs(B),'b')
title('MODULO DEL CAMPO INDUZIONE MAGNETICA')
ylabel('MOMDULO DI B')
xlabel('RAGGIO r')
legend('B')

figure (3)
plot(sqrt(hs(1:99)),abs(B)/mu,'k')
title('MODULO DEL CAMPO MAGNETICO')
ylabel('MOMDULO DI H')
xlabel('RAGGIO r')
legend('H')

%% CALCOLI ANALITICI

% raggio della sezione della spira (diametro=5mm)
        r_spi = 2.5e-3;
% numero di spire/metro
        n_spi = 200;
% spessore pelle 
        delta = sqrt(2/(sigma*w*mu));
% lunghezza di filo/metro
        L = 2*pi*(Rc1+r_spi)*n_spi;
% Resistenza del filo/metro
        Res = L/(sigma*pi*(r_spi^2));
% corrente che scorre nelle spire
        Analit_corrente = (vk)/Res; 
% campo induzione magnetica B
        Analit_campoB = mu*n_spi*Analit_corrente
        Analit_campoH = Analit_campoB/mu
% potenziale vettore con r=Rc1
        Analit_Rc1_vettA = 0.5*Analit_campoB*Rc1;