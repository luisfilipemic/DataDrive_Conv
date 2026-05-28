/*
 * Perifericos_setup.c
 *
 *  Created on: 27 de mai de 2026
 *      Author: luisf
 */
#include "Perifericos_setup.h"

void Setup_GPIO(void){
    EALLOW;

    //LED 31 A, 2
    //LED 34 B, 1

    GpioCtrlRegs.GPAGMUX2.bit.GPIO31 = 0;
    GpioCtrlRegs.GPAMUX2.bit.GPIO31 = 0;

    GpioCtrlRegs.GPBGMUX1.bit.GPIO34 = 0;
    GpioCtrlRegs.GPBMUX1.bit.GPIO34 = 0;

    GpioCtrlRegs.GPAPUD.bit.GPIO31 = 1;
    GpioCtrlRegs.GPBPUD.bit.GPIO34 = 1;

    GpioCtrlRegs.GPADIR.bit.GPIO31 = 1;
    GpioCtrlRegs.GPBDIR.bit.GPIO34 = 1;

    GpioCtrlRegs.GPBCSEL1.bit.GPIO34 = GPIO_MUX_CPU1;

    //PWM
         GpioCtrlRegs.GPAGMUX1.bit.GPIO0 = 0;
         GpioCtrlRegs.GPAMUX1.bit.GPIO0 = 1;
         GpioCtrlRegs.GPAPUD.bit.GPIO0 = 1;

         GpioCtrlRegs.GPAGMUX1.bit.GPIO1 = 0;
         GpioCtrlRegs.GPAMUX1.bit.GPIO1 = 1;
         GpioCtrlRegs.GPAPUD.bit.GPIO1 = 1;

    EDIS;
}
void Setup_ePWM(void)
{
    EALLOW;
    CpuSysRegs.PCLKCR2.bit.EPWM1 = 1;
    CpuSysRegs.PCLKCR0.bit.TBCLKSYNC = 0;

    EPwm1Regs.TBPRD = 2000;                     // Set timer period
    EPwm1Regs.TBPHS.bit.TBPHS = 0;              // Phase is 0
    EPwm1Regs.TBCTL.bit.SYNCOSEL = TB_SYNC_DISABLE; // Clear counter
    EPwm1Regs.TBCTR = 0x0000;                   // Clear counter
    EPwm1Regs.TBCTL.bit.CTRMODE = TB_COUNT_UPDOWN; // Count up/down
    EPwm1Regs.TBCTL.bit.PHSEN = TB_DISABLE;     // Disable phase loading
    EPwm1Regs.TBCTL.bit.HSPCLKDIV = TB_DIV1;    // Clock ratio to SYSCLKOUT
    EPwm1Regs.TBCTL.bit.CLKDIV = TB_DIV1;

    EPwm1Regs.CMPCTL.bit.SHDWAMODE = CC_SHADOW; // Load registers every ZERO
    EPwm1Regs.CMPCTL.bit.LOADAMODE = CC_CTR_ZERO_PRD;
    EPwm1Regs.CMPCTL.bit.SHDWBMODE = CC_SHADOW;
    EPwm1Regs.CMPCTL.bit.LOADBMODE = CC_CTR_ZERO_PRD;

    EPwm1Regs.AQCTLA.bit.PRD = AQ_NO_ACTION;
    EPwm1Regs.AQCTLA.bit.ZRO = AQ_NO_ACTION;
    EPwm1Regs.AQCTLA.bit.CAU = AQ_CLEAR;
    EPwm1Regs.AQCTLA.bit.CAD = AQ_SET;                   // set actions for EPWM1A

    EPwm1Regs.DBCTL.bit.OUT_MODE = DB_FULL_ENABLE;       // enable Dead-band module
    EPwm1Regs.DBCTL.bit.POLSEL = DB_ACTV_HIC;            // Active Hi complementary
    EPwm1Regs.DBFED.bit.DBFED = 100;                      // FED = 20 TBCLKs
    EPwm1Regs.DBRED.bit.DBRED = 100;                      // RED = 20 TBCLKs

    EPwm1Regs.CMPA.bit.CMPA = EPwm1Regs.TBPRD >> 1;

    CpuSysRegs.PCLKCR0.bit.TBCLKSYNC = 1;

    EDIS;

}



