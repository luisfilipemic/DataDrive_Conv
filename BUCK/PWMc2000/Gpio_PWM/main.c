/* main.c - Atualização dinâmica do gráfico */
#include "Perifericos_setup.h"

uint16_t pwm_buffer[100];

int main(void){
    volatile uint32_t count = 0;
    uint16_t i;
    uint16_t duty_dinamico = 10; // Começa em 10%

    InitSysCtrl();
    DINT;
    InitPieCtrl();
    IER = 0x0000;
    IFR = 0x0000;
    InitPieVectTable();

    Setup_GPIO();
    Setup_ePWM();

    while(1){
        // Atualiza o buffer com o novo duty cycle
        for(i = 0; i < 100; i++){
            if(i < duty_dinamico){
                pwm_buffer[i] = 1;
            } else {
                pwm_buffer[i] = 0;
            }
        }

        // Incrementa o duty cycle dinâmico de 10% até 90%
        duty_dinamico += 5;
        if(duty_dinamico > 90){
            duty_dinamico = 10;
        }

        // Delay para conseguir enxergar a transição no gráfico
        for(count = 0; count < 0x000FFFFF; count++);
    }
}
