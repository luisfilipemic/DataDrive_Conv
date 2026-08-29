clear, clc
s = tf('s');

L = 0.000470;
C1 = 0.000041666667;
R = 1;
U1 = 30;

%%
%Planta/Modelo Função de transferencia 
%Planta da modelagem analítica

numG = U1;
denG = [L*C1 L/R 1];
G = tf(numG,denG);
controlSystemDesigner(G)

%%
%Importando os ganho controlador PI
controlador_pid = pid(C);

gainP = controlador_pid.Kp
gainI = controlador_pid.Ki
%gainD = controlador_pid.Kd

%% 
%Função discreta Gc controlador:
Gc = gainP + gainI/s ;

Ts = 2.0e-5;  

Gdc = c2d(Gc, Ts, 'tustin');

Gdc

%%
%graficos PI para resposta em degrau:

modelo = 'controlador.slx'; 

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
