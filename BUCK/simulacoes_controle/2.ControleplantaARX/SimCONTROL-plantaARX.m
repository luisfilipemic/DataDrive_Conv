clear, clc, close all

%%

b1 = 1.3780;
b2 = 0.9447;
a1 = 1.2262;
a2 = -0.3007;

Be = [0, b1, b2];
Ae = [1, -a1, -a2];
Gze = tf(Be, Ae, Ts)

%%
rltool(Gze);
%%
controlador_pi = pid(C);

gainP = controlador_pi.Kp
gainI = controlador_pi.Ki


%% 
%Função de transferencia controlador:

Gc = C 

%%
syms u(k) e(k)

bk_1 = gainP + (gainI*Ts)
bk_2 = gainP
u_k = u(k-1) + e(k)*(bk_1) - (bk_2)*e(k-1)

%% Resposta ao degrau

stepplot(IOTransfer_r2y)


%% LGR

rlocusplot(LoopTransfer_C)

