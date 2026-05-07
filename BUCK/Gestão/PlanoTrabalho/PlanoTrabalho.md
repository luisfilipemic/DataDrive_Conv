# Projeto: Identificação e Controle de Conversores de Energia CC-CC e CC-CA

**Alunos:** Luiz Felipe Souza de Lima Silva & 
**Orientador:** Prof. Dr. Raphael Teixeira  
**Instituição:** Universidade Federal do Pará (UFPA) / Laboratório LINCE  

---

## 📅 Plano de Trabalho Cronológico e Dinâmico

A tabela abaixo apresenta o fluxo de atividades planejado para o desenvolvimento do projeto, integrando a fundamentação teórica, simulações computacionais, modelagem matemática, controle e implementação em hardware.

| Fase | Atividade / Etapa | Descrição Técnica | Ferramentas / Recursos | Status |
| :---: | :--- | :--- | :--- | :---: |
| **1** | **Estudo Bibliográfico** | • Revisão de circuitos elétricos lineares ($R$, $L$, $C$).<br>• Semicondutores de potência (Diodos, MOSFETs, IGBTs).<br>• Princípio de funcionamento de conversores estáticos. | Literatura Técnica / Artigos | 🟢 Concluído |
| **2** | **Simulação e Coleta de Dados** | • Simulações numéricas do conversor.<br>• Ensaios em malha aberta e malha fechada.<br>• Geração de dados de entrada/saída para identificação. | MATLAB / Simulink | 🟡 Em Andamento |
| **3** | **Modelagem e Identificação** | • Modelagem analítica (linearização por valor médio de espaço de estados).<br>• Identificação de sistemas (métodos paramétricos como ARX/ARMAX).<br>• Comparação de desempenho (Analítico vs. Identificado). | MATLAB / System Identification Toolbox | 🟡 Em Andamento |
| **4** | **Projeto de Controladores** | • Projeto de controladores clássicos lineares (PI, PID).<br>• Análise de estabilidade em frequência (Bode, Nyquist e Margem de Fase). | MATLAB / Control System Toolbox | 🔴 Planejado |
| **5** | **Implementação em Sistema Real** | • Prototipagem física do conversor (drivers de acionamento como BTS442E2).<br>• Programação do algoritmo de controle no microcontrolador (geração de PWM). | Arduino (Uno / Mega 2560) / Hardware do LINCE | 🔴 Planejado |
| **6** | **Disseminação Científica** | • Escrita de relatórios técnicos de IC.<br>• Elaboração de artigo científico com os resultados obtidos. | LaTeX / Quarto Document | 🔴 Planejado |

---

## 🛠️ Detalhes das Metodologias

### 1. Modelagem por Espaço de Estados (State-Space Averaging)
Para o conversor CC-CC (Buck), as equações dinâmicas são extraídas para os estados de condução e bloqueio do interruptor ativo, resultando no modelo linearizado de pequenos sinais:

$$\dot{x}(t) = Ax(t) + Bu(t)$$
$$y(t) = Cx(t) + Du(t)$$


---

### 📝 Notas de Acompanhamento (Reuniões de Orientação)
* **Próximo Marco:** Apresentação dos dados de simulação comparativos para o Prof. Dr. Raphael Teixeira.