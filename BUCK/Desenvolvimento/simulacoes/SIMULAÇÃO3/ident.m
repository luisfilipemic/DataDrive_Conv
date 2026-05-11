clear, clc

%Parametrização
Fs = 1000;
Tpwm = 1/Fs;
Tsim = Tpwm/100;
d = 0.3;
Vs = 30;
C = 0.0027;
L = 0.0126;
R = 1.0;

num = Vs/(C*L);
den = [1,1/(C*R) , 1/(C*L)];
Gs = tf(num,den);

load("DataIdent.mat")
Nd = 2000;
t = DadosBuck(1,Nd:end-1);
u = DadosBuck(2,Nd:end-1);
v = DadosBuck(3,Nd:end-1);



%Médias de entrada e saída, respectivamente
mu_u = mean(u);
mu_v = mean(v);

u = u - mu_u;
v = v - mu_v;
y = transpose(v);

figure(1)
subplot(211)
plot(t,u, LineWidth=1.4), grid on
subplot(212)
plot(t,v, LineWidth=1.4), grid on

%Construção matricial - regressores
Ns = numel(t);

A = zeros(Ns-3,4);

for n = 3:Ns
    phi = [y(n-1), y(n-2), u(n-1), u(n-2)];
    A(n, :) = phi;
end

theta = A\y;
a1 = theta(1);
a2 = theta(2);
b1 = theta(3);
b2 = theta(4);
ys = zeros(size(y));
ys(1:2) = y(1:2);

for k = 3:Ns
    ys(k) = a1*ys(k-1) + a2*ys(k-2) + b1*u(k-1) + b2*u(k-2);
end

figure(2)
plot(ys)
hold on
plot(y,'r')
hold off
grid on

Result = A * theta;

figure(3)
plot(Result)

num2 = [b1 b2];
den2 = [1 a1 a2];

load("Datamodelo.mat")
v1 = Dadosmodeloideal(2,Nd:end-1);

mu_v1 = mean(v1);
v1 = v1 - mu_v1;
y = transpose(v1);


figure(4)
plot(ys)
hold on
plot(v1,'r')
hold off
grid on

