clear, clc
s = tf('s');

L = 0.000525;
C1 = 0.000041666667;
R = 1;
U1 = 30;

%%
%Planta/Modelo Função de transferencia 
%Planta Obtida pela identificação ARX
% Modelo discreto ARX identificados

numz = [0.2589 0.225];       % Numerador
denz = [1 -1.602 0.6187];    % Denominador
Ts = 2.0e-5;                 % Período de amostragem (20 microsegundos)

% Criação da função de transferência discreta
Gz = tf(numz, denz, Ts);

% Conversão para contínuo usando Tustin (bilinear)
Gs_tustin = d2c(Gz, 'tustin');

% Exibir resultados
disp('Função discreta G(z):');
Gz

disp('Função contínua G(s) via Tustin:');
Gs_tustin

numS = [-0.01053 -1.397e04 1.502e09];   % Coeficientes do numerador s
denS = [1 2.368e04 5.185e07];           % Coeficientes do denominador s

controlSystemDesigner(Gs_tustin)

%%
%Importando os ganho controlador PI
controlador_pid = pid(C);

gainP = controlador_pid.Kp
gainI = controlador_pid.Ki
gainD = controlador_pid.Kd

%% 
%Função discreta Gc controlador:
Gc = gainP + gainI/s + gainD * s;

Ts = 2.0e-5;

Gdc = c2d(Gc, Ts, 'tustin');

Gdc

%%
%graficos PI para resposta em degrau:

modelo = 'controladorARX.slx'; 

load_system(modelo);

simOut = sim(modelo);
Dados = simOut.get('DadosPI');
Saida = Dados(:,1);        
Entrada = Dados(:,2);     

figure(1)
plot(Saida)

figure(2)
plot(Entrada)

%%
