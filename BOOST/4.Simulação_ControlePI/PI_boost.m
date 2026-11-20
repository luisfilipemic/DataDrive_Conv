%Controle PI conversor BOOST
%Luiz Felipe Souza - lince

s = tf('s');

clc, close all 
%Parametrização 
Ts = 5.0e-5;
L = 0.000551;
Vs = 30;
Cc = 0.000143;
R = 15;
k = 0.3;
fs = 20000; 


%% Obtenção de ganhos
num = [ -Vs/(R*Cc*(1-k)^2) , Vs/(L*Cc) ];
den = [ 1 , 1/(R*Cc) , ((1-k)^2)/(L*Cc) ];

Gs = tf(num, den);
%%
controlSystemDesigner(Gs)

%%
%Importando os ganho controlador PI
controlador_pid = pid(C);

gainP = controlador_pid.Kp
gainI = controlador_pid.Ki
gaibD = controlador_pid.Kd

%% 
s = tf('s');
%%

%Função discreta Gc controlador:
Gc = gainP + (gainI)/s + gaibD*s ;

Ts = 5.0e-5;  

Gdc = c2d(Gc, Ts, 'tustin');

Gdc

%% lugar das raízer lgr
figure(2)
rlocusplot(LoopTransfer_C)

%% Diagrama de bode - resposta em frequencia 

figure(3)
bodeplot(LoopTransfer_C)

%% Resposta ao degrau unitario
figure(4)
stepplot(IOTransfer_r2y)


