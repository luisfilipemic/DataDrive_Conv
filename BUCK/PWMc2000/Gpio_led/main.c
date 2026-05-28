#include "Perifericos_setup.h"

/**
 * main.c
 */

uint32_t count = 0;

__interrupt void isr_cpu_timer0(void);

int main(void)
{

    InitSysCtrl();        // inicia o sistema;
    DINT;                 // Desabilita todas as interrupições

    InitPieCtrl();
    IER = 0x0000;
    IFR = 0x0000;
    InitPieVectTable();

    Setup_GPIO();
    Setup_ePWM();

    EALLOW;
    PieVectTable.TIMER0_INT = &isr_cpu_timer0;
    PieCtrlRegs.PIEIER1.bit.INTx7 = 1;    //Timer 0
    EDIS;

    EINT;         //Enable global interrupit
    ERTM;

    GpioDataRegs.GPBDAT.bit.GPIO34 = 1;
    GpioDataRegs.GPADAT.bit.GPIO31 = 0;

    while(1){
        for(count = 0; count < 0x00FFFFFF; count++){
        }

    }
	return 0;
}

__interrupt void isr_cpu_timer0(void){
    GpioDataRegs.GPATOGGLE.bit.GPIO31 = 1;
    PieCtrlRegs.PIEACK.all = PIEACK_GROUP1;
}


