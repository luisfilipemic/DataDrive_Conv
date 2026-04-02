<p align="center">
  <img src="logouf.png" width="200" height="200" />
  <br>
  <em></em>
</p>


Título: Modelagem circuito RC(resistor e capacitor) sem fonte.



# Cicuito RC

- Seja o seguinte circuito RC:

<p align="center">
  <img src="CIRCUITORC.jpeg" width="200" height="200" />
  <br>
  <em></em>
</p>


Um circuito RC sem fonte ocorre quando sua fonte CC é desconectada abrup-tamente. A energia já armazenada no capacitor é liberada para os resistores.


- Tensão no capacitor no instante 0segundos:

$$ Vc(0) = Vo Volts $$

- Aplicando as leis de Kirchhoff(LKC)  


$$Icapcitor + Iresistor = 0$$  


Lembrando que:  


$$  Icapacitor = Ic = \frac{C*dv}{dt}$$ 


$$Iresistor = Ir = \frac{V}{R}$$  


- Substituindo na equação, teremos:  


$$Ic + Ir =0=\frac{C*dv}{dt}+\frac{V}{R} = 0$$  

- Portanto, a equação diferencial de primeira ordem do sistema é definida por:  

$$  \frac{C*dv}{dt} + \frac{V}{R} = 0 $$  


- Resolvendo a EDO:

$$  \frac{C*dv}{dt} + \frac{V}{R} = 0 $$  


$$ \frac{dv}{dt} = - \frac{V}{R*C} $$


$$ \therefore  \frac{dv}{v} = - \frac{dt}{R*C} $$


integrando em ambos os lados, teremos:


$$  int\frac{1}{V} \, dx = - int\frac{1}{RC} \, dt  $$


Após a resolução da integral, teremos:

$$ ln(v) = - \frac{t}{RC} + K  $$

OBS.:
K é definida como sendo a constante de integração, substituiremos por ln(A), para fins de operação matemática.

$$  ln(v) = - \frac{t}{RC} + ln(A)  \therefore  ln(\frac{t}{A}) = - \frac{t}{RC} $$


Portanto:

$$ e^{\frac{-t}{RC}} = \frac{V}{A} $$



Logo teremos a função V(t):

$$  V(t) = e^{\frac{-t}{RC}} * A  $$








