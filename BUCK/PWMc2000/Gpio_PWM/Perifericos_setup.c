/*
 * Perifericos_setup.c
 */

#include "Perifericos_setup.h"

void Setup_GPIO(void){
    EALLOW; // Libera registradores protegidos

    // --- 1. LEDs de Diagnóstico (GPIO31 e GPIO34) ---
    GpioCtrlRegs.GPAGMUX2.bit.GPIO31 = 0;
    GpioCtrlRegs.GPAMUX2.bit.GPIO31 = 0;
    GpioCtrlRegs.GPBGMUX1.bit.GPIO34 = 0;
    GpioCtrlRegs.GPBMUX1.bit.GPIO34 = 0;

    GpioCtrlRegs.GPAPUD.bit.GPIO31 = 1;   // Desabilita Pull-Up
    GpioCtrlRegs.GPBPUD.bit.GPIO34 = 1;
    GpioCtrlRegs.GPADIR.bit.GPIO31 = 1;   // Configura como saída
    GpioCtrlRegs.GPBDIR.bit.GPIO34 = 1;

    GpioCtrlRegs.GPACSEL4.bit.GPIO31 = GPIO_MUX_CPU1;
    GpioCtrlRegs.GPBCSEL1.bit.GPIO34 = GPIO_MUX_CPU1;

    // --- 2. Saída PWM1A no Pino GPIO0 (Pino 40 do Conector J4) ---
    GpioCtrlRegs.GPAGMUX1.bit.GPIO0 = 0;
    GpioCtrlRegs.GPAMUX1.bit.GPIO0 = 1;   // MUX 1 = Função ePWM1A
    GpioCtrlRegs.GPAPUD.bit.GPIO0 = 1;    // Desabilita Pull-Up

    EDIS; // Bloqueia registradores protegidos
}

void Setup_ePWM(void){
    EALLOW;

    // Habilita o clock para o ePWM1
    CpuSysRegs.PCLKCR2.bit.EPWM1 = 1;

    // Bloqueia a contagem do timer durante a configuração
    CpuSysRegs.PCLKCR0.bit.TBCLKSYNC = 0;

    // --- CONFIGURAÇÃO DO ePWM1A (20kHz | Duty 30%) ---
    EPwm1Regs.TBPRD = 2500;                        // Período de 20kHz em modo Up-Down
    EPwm1Regs.CMPA.bit.CMPA = 750;                 // Comparador em 30% de 2500

    EPwm1Regs.TBPHS.bit.TBPHS = 0;                 // Sem desfasamento de fase
    EPwm1Regs.TBCTR = 0x0000;                      // Zera o contador inicial

    EPwm1Regs.TBCTL.bit.CTRMODE = TB_COUNT_UPDOWN; // Contagem simétrica (Sobe e Desce)
    EPwm1Regs.TBCTL.bit.PHSEN = TB_DISABLE;        // Desabilita sincronismo de fase
    EPwm1Regs.TBCTL.bit.HSPCLKDIV = TB_DIV1;       // Prescaler Alta Velocidade = /1
    EPwm1Regs.TBCTL.bit.CLKDIV = TB_DIV1;          // Prescaler do Timer = /1

    // Atualização síncrona do registrador CMPA no Zero
    EPwm1Regs.CMPCTL.bit.SHDWAMODE = CC_SHADOW;
    EPwm1Regs.CMPCTL.bit.LOADAMODE = CC_CTR_ZERO;

    // Ações do Action-Qualifier para gerar Duty Cycle de 30%
    EPwm1Regs.AQCTLA.bit.ZRO = AQ_SET;             // Nível ALTO ao passar por 0
    EPwm1Regs.AQCTLA.bit.CAU = AQ_CLEAR;           // Nível BAIXO ao atingir 750 subindo
    EPwm1Regs.AQCTLA.bit.CAD = AQ_SET;             // Nível ALTO ao atingir 750 descendo
    EPwm1Regs.AQCTLA.bit.PRD = AQ_NO_ACTION;       // Sem ação no topo (2500)

    // Libera a contagem de todos os ePWMs simultaneamente
    CpuSysRegs.PCLKCR0.bit.TBCLKSYNC = 1;

    EDIS;
}
