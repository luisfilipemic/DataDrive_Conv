clear, clc, clf, close
%Importação dos dados de saída e entrada a partir do CSV
dados_csv = readmatrix('Dadosensaio_prbs50us.csv');

%Remoção eventuais linhas vazias/NaN no final do arquivo
dados_csv = dados_csv(~isnan(dados_csv(:,1)), :);

Nd = 200;
Ts = 5.0e-5;

%Parametros 
Fs = 20000;


%(Tempo, PRBS e Saída)
t = dados_csv(1:end-Nd, 1)';
u = dados_csv(Nd:end-1, 2)';
v = dados_csv(Nd:end-1, 3)';

u = u - mean(u);
y = v - mean(v);
U = fft(u);
Y = fft(y);
MagU = fftshift(abs(U))
MagY = fftshift(abs(Y))
subplot(211)
stem(MagU(2:end))
grid
subplot(212)
stem(MagY(1:end))
