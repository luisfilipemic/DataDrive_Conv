clear, clc

%% Simulação do conversor Buck
% Nome do arquivo Simulink
modelo = 'Buckop2.slx';  % substitua pelo nome real do seu arquivo

% Carregar o modelo
load_system(modelo);

% Executar a simulação
simOut = sim(modelo);

% Extrair os dados salvos pelo bloco "To Workspace"
Dados = simOut.get('Dados');

% Separar tempo e sinais (formato Array)
tempo = Dados(:,1);        % primeira coluna = tempo
corrente = Dados(:,2);     % segunda coluna = corrente
tensao = Dados(:,3);       % terceira coluna = tensão
%extra = Dados(:,4);        % quarta coluna (se houver outro sinal)

%% Plotar os sinais
figure;
plot(tempo, corrente, 'b-', 'LineWidth', 1.5);
hold on;
plot(tempo, tensao, 'r--', 'LineWidth', 1.5);
plot(tempo, extra, 'g-.', 'LineWidth', 1.5);
hold off;

xlabel('Tempo (s)');
ylabel('Amplitude');
title('Sinais exportados do Simulink - Conversor Buck');
legend('Corrente','Tensão','Extra');
grid on;

%% Salvar gráfico automaticamente
saveas(gcf, 'grafico_buck.png');
