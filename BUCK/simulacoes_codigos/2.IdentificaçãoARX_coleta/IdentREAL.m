clear, clc
%Importação dos dados de saída e entrada a partir do CSV
dados_csv = readmatrix('Dadosensaio_prbs300us.csv');

%Remoção eventuais linhas vazias/NaN no final do arquivo
dados_csv = dados_csv(~isnan(dados_csv(:,1)), :);

Nd = 200;
Ts = 5.0e-5;

%Parametros 
Fs = 20000;
d =  0.3;
Vs = 30;
C = 0.000041666667;
L = 0.000470;
R = 1.0;
num = 1/(C*L);
den = [1,1/(C*R) , 1/(C*L)];
Gs = tf(num,den);

%(Tempo, PRBS e Saída)
t = dados_csv(1:end-Nd, 1)';
u = dados_csv(Nd:end-1, 2)';
v = dados_csv(Nd:end-1, 3)';

%% 
mu_u = mean(u);
mu_v = mean(v);

u = u - mu_u;
v = v - mu_v;
y = transpose(v); 

%% Relação gráfica de saída e entrada
figure(1);
clf;

subplot(2,1,1);
stairs(1:length(u), u, 'LineWidth', 1.4);
ylabel('Entrada PRBS (u)');
title('Ensaio de Identificação - Conversor Buck');
grid on;

subplot(2,1,2);
plot(t(1:length(v)), v, 'LineWidth', 1.4);
ylabel('Saída Real (v)');
xlabel('Tempo (s)');
grid on;
exportgraphics(figure(1), 'saidaentrada.png', 'Resolution', 300);


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
exportgraphics(figure(2), 'comparacao_arxREAL.png', 'Resolution', 300);

%% Modelo ARX - Discreto 

Gz = c2d(Gs, Ts ,'matched')

Be = [0, b1, b2];
Ae = [1, -a1, -a2];

Gze = tf(Be, Ae, Ts)

%% Ajuste

R2 = 1 - sum((y - yp).^2) / sum((y - mean(y)).^2)
fit_percentual = (1 - norm(y - yp) / norm(y - mean(y))) * 100

%%
figure(4)
pzmap(Gz)
zgrid
hold on

pzmap(Gze)
hold off