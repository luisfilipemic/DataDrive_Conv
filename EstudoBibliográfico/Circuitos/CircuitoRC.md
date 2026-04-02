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


