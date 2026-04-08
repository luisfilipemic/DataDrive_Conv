<p align="center">
  <img src="logouf.png" width="200" height="200" />
  <br>
  <em></em>
</p>


Título: Parametros simulação 1 - conversor buck


### Dimensionamento 1:

| Tensão entrada Vo | Tensão saída Vin | Potência máxima de saída | Frequência de chaveamento |
|-------------------|------------------|--------------------------|---------------------------|
| 30V               | 9V               | 90W                      | 500 Hz                    |

Ondulação de corrente(RIPPLE) no indutor:
$$ \delta Il = 10% $$   

Ondulação de Tensão no capacitor:

$$ \deltal Vc = 10% $$  

Cálculos:

- Corrente de saída (Io):

$$ Io = \frac{Po}{Vo} = \frac{90w}{9V} = 10A $$  

- Resistência de Carga(Ro):

$$ Ro = \frac{Vo^2}{Po} = \frac{9^2}{90} = 0.9\ohm $$




