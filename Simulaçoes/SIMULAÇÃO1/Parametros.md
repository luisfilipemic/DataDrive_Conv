<p align="center">
  <img src="logouf.png" width="200" height="200" />
  <br>
  <em></em>
</p>


Título: Parametros simulação 1 - conversor buck
Ref.: Eletrônica de Potência: Dispositivos, Circuitos e Aplicações. Muhammad H. Rashid (Autor)

### Dimensionamento 1:

| Tensão entrada Vo | Tensão saída Vin | Potência máxima de saída | Frequência de chaveamento |
|-------------------|------------------|--------------------------|---------------------------|
| 30V               | 9V               | 90W                      | 500 Hz                    |

Ondulação de corrente(RIPPLE) no indutor:  

$$ \Delta Il = 10% $$   

Ondulação de Tensão no capacitor:

$$ \Delta Vc = 10% $$  

#### Fundamentação teórica:

- Corrente de saída (Io):

$$ Io = \frac{Po}{Vo} = \frac{90w}{9V} = 10A $$  

- Resistência de Carga(Ro):

$$ Ro = \frac{Vo^2}{Po} = \frac{9^2}{90} = 0.9\ohm $$  

- Indutor de saída(Lo):

$$ Lo = \frac{Vo\cdot(Vin - Vo)}{f\cdot \Delta Il \cdot Vin} $$  

$$ \therefore Lo = \frac{(30-9)\cdot9}{30\cdot 500\cdot (0.1\cdot 10)} = 0.0126H $$  

- Capacitor de saída(Co):

$$ Co = \frac{\Delta Il}{8\cdot f\cdot \Delta Vc} $$  

$$ \therefore Co = \frac{1}{360} = 0.0027F $$  

#### Dimensionamento Chave e diodo:

- Esforços na chave: 

- Valor médio da corrente(Ismd):

$$ Ismd = \frac{Vo \cdot Io}{Vin} = \frac{9 \cdot 10}{30} = 3A $$

- Valor eficaz de corrente(Isef):

$$ Isef = (\frac{Vo}{Vin})^{\frac{1}{2}} \cdot Io = (\frac{9}{30})^{\frac{1}{2}} \cdot 10 = apx 5.47A $$  

- Valor máximo de corrente(Ismax):

$$ Ismax = \frac{21}{2} = 10.5A $$

- Valor de tensão máxima:

$$ Vmax = Vin = 30V $$  

Dimensões do interrupitor devem ser especificados com base nos valor de corrente máxima(Vsmax) e tensão máxima(Vmax).


### Resultados:















