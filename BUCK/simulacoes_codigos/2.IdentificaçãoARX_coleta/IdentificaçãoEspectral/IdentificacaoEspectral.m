clear, clc
%Importação dos dados de saída e entrada a partir do CSV
dados_csv = readmatrix('Dadosensaio_prbs200us.csv');

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

U = fft(u);
Y = fft(v)
MagU = abs(U)
MagY = abs(Y)
subplot(211)
stem(MagU(2:600))
grid
subplot(212)
stem(MagY(2:600))
