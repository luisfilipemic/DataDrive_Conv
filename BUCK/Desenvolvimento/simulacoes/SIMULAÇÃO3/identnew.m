%Identificação ARX conversor BUCK
%Luiz Felipe Souza - ufpa

%%
% Equações de diferenças ARX, pode ser definida por:
%
%
% $$ y(k) = \sum_{i=1}^{n} aiy(k-i) + \sum_{j=1}^{n} bjy(k-i) $$
% 
% $$y(k) = a1\cdot y(k-1) + a2\cdot y(k-2) + b1\cdot u(k-1) + b2\cdot u(k-2)$$

%%
clear, clc
%Parametrização
Fs = 1000;
Tpwm = 1/Fs;
Tsim = Tpwm/100;
d = 0.3;
Vs = 30;
C = 0.0027;
L = 0.0126;
R = 1.0;

num = Vs/(C*L);
den = [1,1/(C*R) , 1/(C*L)];
Gs = tf(num,den);

%Importação dos dados de saída e entrada
load("DataIdent.mat")
Nd = 2000;
t = DadosBuck(1,Nd:end-1);
u = DadosBuck(2,Nd:end-1);
v = DadosBuck(3,Nd:end-1);



%Médias de entrada e saída, respectivamente
mu_u = mean(u);
mu_v = mean(v);

u = u - mu_u;
v = v - mu_v;
y = transpose(v);

%relação gráfica de saída e entrada
figure(1)
subplot(211)
plot(t,u, LineWidth=1.4), grid on
title('relação tempo entrada');
legend('Duty cycle');
subplot(212)
plot(t,v, LineWidth=1.4), grid on
title('relação tempo saída');
legend('tensão na carga'); 

%Construção matricial - regressores
Ns = numel(t);

A = zeros(Ns-3,4);

for n = 3:Ns
    phi = [y(n-1), y(n-2), u(n-1), u(n-2)];
    A(n, :) = phi;
end

theta = A\y;
a1 = theta(1);
a2 = theta(2);
b1 = theta(3);
b2 = theta(4);
ys = zeros(size(y));
ys(1:2) = y(1:2);

for k = 3:Ns
    ys(k) = a1*ys(k-1) + a2*ys(k-2) + b1*u(k-1) + b2*u(k-2);
end

%Comparação ARX VS saída do sistema.
figure(2)
plot(ys)
hold on
plot(y,'r')
legend('ARX','Saída do sistema real');
hold off
grid on
title('ARX VS saída do sistema real');


Result = A * theta;

figure(3)
plot(Result)
title('Saída ARX');

load("Datamodelo.mat")
v1 = Dadosmodeloideal(2,Nd:end-1);

mu_v1 = mean(v1);
v1 = v1 - mu_v1;
y1 = transpose(v1);


%Comparação ARX VS Espço de estados.
figure(4)
plot(ys)
hold on
plot(v1,'r')
legend('ARX', 'Espaço de estados');
hold off
grid on
title('ARX VS saída Espaço de estados');

%Erro - modelo arx - saída real
e = y - ys;

figure(5)
plot(e)
title('Sinal de ERRO');

% Modelo ARX - Discreto 

[B, A] = c2d(Gs, Tsim ,'tustin')

B = [2.20050890435928e-05,4.40101780871856e-05,2.20050890435928e-05];
A = [1,-1.99630021102880,0.996303145040676];

Be = [0, b1, b2]
Ae = [1, -a1, -a2]

Gz = tf(B, A, Tpwm);
Gze = tf(Be, Ae, Tpwm)


