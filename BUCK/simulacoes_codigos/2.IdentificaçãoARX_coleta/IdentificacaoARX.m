%Identificação ARX conversor BUCK
%Luiz Felipe Souza - ufpa

% Equações de diferenças ARX, pode ser definida por:
%
%
% $$ y(k) = \sum_{i=1}^{n} aiy(k-i) + \sum_{j=1}^{n} bjy(k-i) $$
% 
% $$y(k) = a1\cdot y(k-1) + a2\cdot y(k-2) + b1\cdot u(k-1) + b2\cdot u(k-2)$$


clear, clc
%Parametrização 
Fs = 20000;
Ts = 2.0e-5;
d =  0.3;
Vs = 30;
C = 0.000041666667;
L = 0.000470;
R = 1.0;
num = Vs/(C*L);
den = [1,1/(C*R) , 1/(C*L)];
Gs = tf(num,den);

%% Importação dos dados de saída e entrada
load("DataIdent.mat")
Nd = 200;
t = DadosBuck(1,1:end-Nd);
u = DadosBuck(2,Nd:end-1);
v = DadosBuck(3,Nd:end-1);
%%


mu_u = mean(u);
mu_v = mean(v);

u = u - mu_u;
v = v - mu_v;
y = transpose(v);

%% relação gráfica de saída e entrada
figure(1)
subplot(211)
stairs(t,u, LineWidth=1.4), grid on
title('relação tempo entrada');
legend('Duty cycle');
subplot(212)
plot(t,v, LineWidth=1.4), grid on
title('relação tempo saída');
legend('tensão na carga'); 

%% Construção matricial - regressores
Ns = numel(t);

M = zeros(Ns-3,4);

for n = 3:Ns
    phi = [y(n-1), y(n-2), u(n-1), u(n-2)];
    M(n, :) = phi;
end

theta = M\y;
a1 = theta(1);
a2 = theta(2);
b1 = theta(3);
b2 = theta(4);
ys = zeros(size(y));
ys(1:2) = y(1:2);

yp = M * theta;

%% Comparação ARX VS saída do sistema.
figure(2)
plot(t,y)
hold on
plot(t,yp,'r')
legend('ARX','Saída do sistema real');
hold off
grid on
title('ARX VS saída do sistema real');
exportgraphics(figure(2), 'comparacao_arx.png', 'Resolution', 300);


 %% Modelo ARX - Discreto 

[B, A] = c2d(Gs, Ts ,'zoh');

Be = [0, b1, b2];
Ae = [1, -a1, -a2];

Gz = tf(B, A, Ts)
Gze = tf(Be, Ae, Ts)

%%
figure('Position', [100, 100, 800, 500]);
plot(t, ys, 'b', 'LineWidth', 1.2); hold on;
plot(t, y, 'r', 'LineWidth', 1.2);
title('ARX VS saída do sistema real', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Tempo (s)', 'FontSize', 10);
ylabel('Tensão (V)', 'FontSize', 10);
xlim([0 0.03]);
ylim([-10 4]);
grid on;
legend('ARX', 'Saída do sistema real', 'Location', 'northeast');

% Exporta com alta definição (300 DPI)
exportgraphics(gcf, 'grafico_arx_hd.png', 'Resolution', 300);



