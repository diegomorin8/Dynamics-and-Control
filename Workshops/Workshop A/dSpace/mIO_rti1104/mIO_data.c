/*
 * mIO_data.c
 *
 * Code generation for model "mIO".
 *
 * Model version              : 1.59
 * Simulink Coder version : 8.7 (R2014b) 08-Sep-2014
 * C source code generated on : Wed Mar 22 15:31:21 2017
 *
 * Target selection: rti1104.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Generic->Custom
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */
#include "mIO.h"
#include "mIO_private.h"

/* Block parameters (auto storage) */
P_mIO_T mIO_P = {
  0.69298710539558894,                 /* Variable: Dpos
                                        * Referenced by: '<S3>/Derivative Gain'
                                        */
  71.243457676007736,                  /* Variable: Ipos
                                        * Referenced by: '<S3>/Integral Gain'
                                        */
  2.2047600000000002E-5,               /* Variable: Jeq
                                        * Referenced by: '<S1>/Jeq'
                                        */
  55.955910050527827,                  /* Variable: Npos
                                        * Referenced by: '<S3>/Filter Gain'
                                        */
  11.159131917944556,                  /* Variable: Ppos
                                        * Referenced by: '<S3>/Proportional Gain'
                                        */
  1.3528E-5,                           /* Variable: dm
                                        * Referenced by: '<S1>/Friction'
                                        */
  0.6,                                 /* Variable: eps_Jeq
                                        * Referenced by: '<S1>/eps_Jeq'
                                        */
  3.56,                                /* Variable: eps_dm
                                        * Referenced by: '<S1>/eps_dm'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<S1>/Integrator1'
                                        */
  1.0,                                 /* Expression: 1/n
                                        * Referenced by: '<S1>/Gain7'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<S1>/Integrator2'
                                        */
  1.0,                                 /* Expression: 1/n
                                        * Referenced by: '<S1>/Gain6'
                                        */
  4.0,                                 /* Expression: 4
                                        * Referenced by: '<Root>/Ctrl. Signal Selector'
                                        */
  24.0,                                /* Expression: 24
                                        * Referenced by: '<Root>/Ctrl. Sine'
                                        */
  1.2566370614359172,                  /* Expression: 2*pi*2/10
                                        * Referenced by: '<Root>/Ctrl. Sine'
                                        */
  24.0,                                /* Expression: 24
                                        * Referenced by: '<Root>/Ctrl. Square'
                                        */
  0.2,                                 /* Computed Parameter: CtrlSquare_Frequency
                                        * Referenced by: '<Root>/Ctrl. Square'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/Ctrl. Step'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/Ctrl. Step'
                                        */
  24.0,                                /* Expression: 24
                                        * Referenced by: '<Root>/Ctrl. Step'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<Root>/Vel.Ref. Signal Selector'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/Vel.Ref. Step'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/Vel.Ref. Step'
                                        */
  50.0,                                /* Expression: 50
                                        * Referenced by: '<Root>/Vel.Ref. Step'
                                        */
  50.0,                                /* Expression: 50
                                        * Referenced by: '<Root>/Vel.Ref. Sine'
                                        */
  1.2566370614359172,                  /* Expression: 2*pi*2/10
                                        * Referenced by: '<Root>/Vel.Ref. Sine'
                                        */
  50.0,                                /* Expression: 50
                                        * Referenced by: '<Root>/Vel.Ref. Square'
                                        */
  0.031830988618379068,                /* Computed Parameter: VelRefSquare_Frequency
                                        * Referenced by: '<Root>/Vel.Ref. Square'
                                        */
  0.25132741228718347,                 /* Expression: 2*pi/(1000)/Ts
                                        * Referenced by: '<S7>/w1_scaling'
                                        */
  1.6642176915080158,                  /* Expression: double(Psp_d)
                                        * Referenced by: '<S4>/Proportional Gain1'
                                        */
  0.0,                                 /* Expression: double(Dsp_d)
                                        * Referenced by: '<S4>/Derivative Gain2'
                                        */
  0.025,                               /* Computed Parameter: DiscreteTimeIntegrator1_gainval
                                        * Referenced by: '<S4>/Discrete-Time Integrator1'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<S4>/Discrete-Time Integrator1'
                                        */
  1.0,                                 /* Expression: double(Nsp_d)
                                        * Referenced by: '<S4>/Filter Gain1'
                                        */
  0.025,                               /* Computed Parameter: DiscreteTimeIntegrator2_gainval
                                        * Referenced by: '<S4>/Discrete-Time Integrator2'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<S4>/Discrete-Time Integrator2'
                                        */
  24.0,                                /* Expression: 24
                                        * Referenced by: '<S4>/Saturation'
                                        */
  -24.0,                               /* Expression: -24
                                        * Referenced by: '<S4>/Saturation'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/Pos'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/Pos'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<Root>/Pos'
                                        */
  0.0062831853071795866,               /* Expression: 2*pi/(1000)
                                        * Referenced by: '<S7>/fi1_scaling'
                                        */
  13.47226362483117,                   /* Expression: double(Ppos_d)
                                        * Referenced by: '<S2>/Proportional Gain1'
                                        */
  0.82164511861841516,                 /* Expression: double(Dpos_d)
                                        * Referenced by: '<S2>/Derivative Gain2'
                                        */
  0.025,                               /* Computed Parameter: DiscreteTimeIntegrator1_gainv_h
                                        * Referenced by: '<S2>/Discrete-Time Integrator1'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<S2>/Discrete-Time Integrator1'
                                        */
  50.673018936390143,                  /* Expression: double(Npos_d)
                                        * Referenced by: '<S2>/Filter Gain1'
                                        */
  0.025,                               /* Computed Parameter: DiscreteTimeIntegrator2_gainv_d
                                        * Referenced by: '<S2>/Discrete-Time Integrator2'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<S2>/Discrete-Time Integrator2'
                                        */
  24.0,                                /* Expression: 24
                                        * Referenced by: '<S2>/Saturation'
                                        */
  -24.0,                               /* Expression: -24
                                        * Referenced by: '<S2>/Saturation'
                                        */
  0.025,                               /* Computed Parameter: DiscreteTimeIntegrator1_gainv_c
                                        * Referenced by: '<S3>/Discrete-Time Integrator1'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<S3>/Discrete-Time Integrator1'
                                        */
  0.025,                               /* Computed Parameter: DiscreteTimeIntegrator2_gainv_k
                                        * Referenced by: '<S3>/Discrete-Time Integrator2'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<S3>/Discrete-Time Integrator2'
                                        */
  24.0,                                /* Expression: 24
                                        * Referenced by: '<S3>/Saturation'
                                        */
  -24.0,                               /* Expression: -24
                                        * Referenced by: '<S3>/Saturation'
                                        */
  -1.0,                                /* Expression: -1
                                        * Referenced by: '<Root>/Gain'
                                        */
  24.0,                                /* Expression: 24
                                        * Referenced by: '<S5>/Saturation'
                                        */
  -24.0,                               /* Expression: -24
                                        * Referenced by: '<S5>/Saturation'
                                        */
  0.020833333333333332,                /* Expression: 1/48
                                        * Referenced by: '<S5>/pwm_skalning'
                                        */
  0.5,                                 /* Expression: 0.5
                                        * Referenced by: '<S5>/pwm_offstet'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<S5>/Enable[1_Off, 0_On]'
                                        */
  0.00062232142857142857,              /* Expression: Km/R
                                        * Referenced by: '<S1>/Gain2'
                                        */
  4.3377605058023088E-5,               /* Expression: Km*Kemf/(R)
                                        * Referenced by: '<S1>/Gain4'
                                        */
  29.6,                                /* Expression: 29.6
                                        * Referenced by: '<S2>/Anti-Windup1'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<S2>/Anti-Windup2'
                                        */
  75.26891776856948,                   /* Expression: double(Ipos_d)
                                        * Referenced by: '<S2>/Integral Gain2'
                                        */
  29.6,                                /* Expression: 29.6
                                        * Referenced by: '<S3>/Anti-Windup'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<S3>/Anti-Windup1'
                                        */
  29.6,                                /* Expression: 29.6
                                        * Referenced by: '<S4>/Anti-Windup'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<S4>/Anti-Windup1'
                                        */
  20.022631724515755,                  /* Expression: double(Isp_d)
                                        * Referenced by: '<S4>/Integral Gain2'
                                        */
  0.0                                  /* Expression: 0
                                        * Referenced by: '<S7>/Reset enc'
                                        */
};
