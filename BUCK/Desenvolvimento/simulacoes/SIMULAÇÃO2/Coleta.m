clear, clc
%Parametros SIMULINK
%Frequencia de chaveamento e ciclo de trabalho
Fs = 1000;
d = 0.3;
Tpwm = 1/Fs;
Tsim = Tpwm/100;
b1 = -2.7151e-09;
b2 = 2.9009e-06;
a1 =  1.9964;
a2 =  -0.9964;
%Parametrização dos elementos passivos:
Vs = 30;
C = 0.0027;
L = 0.0126;
R = 1.0;
%Parametrização Função de transferencia:
num = Vs;
den = [L*C, L/R , 1];
%Função transferencia - coleta
num1 = [b1, b2];
den1 = [1, a1, a2];
% Rodar simulação
simOut = sim('Simulacao2MA.slx');

%1.99275960701833 -0.992771360935098 1.56871699071251e-09 1.15380338648455e-05

figure;
plot(simOut.modelo, 'b-', 'LineWidth', 1.5);   
hold on;                                
plot(simOut.Vcarga, 'r--', 'LineWidth', 1.5);  
hold off;

xlabel('Tempo (s)');
ylabel('Tensão');
title('Comparação modelo/sistemaReal');
legend('Modelo', 'Tensão na carga');
