clear, clc 

Fs = 1000;
Tpwm = 1/Fs;
Tsim = Tpwm/100;

B = [2.20050890435928e-05,4.40101780871856e-05,2.20050890435928e-05];
A = [1,-1.99630021102880,0.996303145040676];


Be = [0,-8.14529968572852e-08,8.70284222406413e-05];
Ae = [1,-1.99637300531677,0.996375956500999];

Gz = tf(B, A, Tsim)
Gze = tf(Be, Ae, Tsim)

simOut = sim('dados.slx');

figure;
plot(simOut.arx, 'b-', 'LineWidth', 1.5);   
hold on;                                
plot(simOut.esp, 'r--', 'LineWidth', 1.5);  
hold off;

xlabel('Tempo (s)');
ylabel('Tensão');
title('Comparação arx/espaço de estados');
legend('ARX', 'espaço de estados');

