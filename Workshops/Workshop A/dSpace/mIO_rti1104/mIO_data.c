/*
 * mIO_data.c
 *
 * Code generation for model "mIO".
 *
 * Model version              : 1.65
 * Simulink Coder version : 8.7 (R2014b) 08-Sep-2014
 * C source code generated on : Mon Mar 27 14:18:35 2017
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
  1.2084895068991373,                  /* Variable: Dpos
                                        * Referenced by: '<S4>/Derivative Gain'
                                        */
  116.04889221076273,                  /* Variable: Ipos
                                        * Referenced by: '<S4>/Integral Gain'
                                        */
  3.6746000000000004E-5,               /* Variable: Jeq
                                        * Referenced by: '<S2>/Jeq'
                                        */
  57.253059945446516,                  /* Variable: Npos
                                        * Referenced by: '<S4>/Filter Gain'
                                        */
  18.22416434418658,                   /* Variable: Ppos
                                        * Referenced by: '<S4>/Proportional Gain'
                                        */
  0.0013,                              /* Variable: Tc
                                        * Referenced by: '<S1>/Constant'
                                        */
  3.8E-6,                              /* Variable: dm
                                        * Referenced by: '<S2>/Friction'
                                        */
  0.01,                                /* Variable: dv
                                        * Referenced by: '<S1>/Constant1'
                                        */
  0.6,                                 /* Variable: eps_Jeq
                                        * Referenced by: '<S2>/eps_Jeq'
                                        */
  3.56,                                /* Variable: eps_dm
                                        * Referenced by: '<S2>/eps_dm'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<Root>/Model selector'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<S1>/Integrator3'
                                        */
  1.0,                                 /* Expression: 1/n
                                        * Referenced by: '<S1>/Gain10'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<S2>/Integrator1'
                                        */
  1.0,                                 /* Expression: 1/n
                                        * Referenced by: '<S2>/Gain7'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<S1>/Integrator4'
                                        */
  1.0,                                 /* Expression: 1/n
                                        * Referenced by: '<S1>/Gain9'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<S2>/Integrator2'
                                        */
  1.0,                                 /* Expression: 1/n
                                        * Referenced by: '<S2>/Gain6'
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
                                        * Referenced by: '<S8>/w1_scaling'
                                        */
  2.5505404941722571,                  /* Expression: double(Psp_d)
                                        * Referenced by: '<S5>/Proportional Gain1'
                                        */
  0.0,                                 /* Expression: double(Dsp_d)
                                        * Referenced by: '<S5>/Derivative Gain2'
                                        */
  0.025,                               /* Computed Parameter: DiscreteTimeIntegrator1_gainval
                                        * Referenced by: '<S5>/Discrete-Time Integrator1'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<S5>/Discrete-Time Integrator1'
                                        */
  1.0,                                 /* Expression: double(Nsp_d)
                                        * Referenced by: '<S5>/Filter Gain1'
                                        */
  0.025,                               /* Computed Parameter: DiscreteTimeIntegrator2_gainval
                                        * Referenced by: '<S5>/Discrete-Time Integrator2'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<S5>/Discrete-Time Integrator2'
                                        */
  24.0,                                /* Expression: 24
                                        * Referenced by: '<S5>/Saturation'
                                        */
  -24.0,                               /* Expression: -24
                                        * Referenced by: '<S5>/Saturation'
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
                                        * Referenced by: '<S8>/fi1_scaling'
                                        */
  21.895131274500976,                  /* Expression: double(Ppos_d)
                                        * Referenced by: '<S3>/Proportional Gain1'
                                        */
  1.4112967525678775,                  /* Expression: double(Dpos_d)
                                        * Referenced by: '<S3>/Derivative Gain2'
                                        */
  0.025,                               /* Computed Parameter: DiscreteTimeIntegrator1_gainv_h
                                        * Referenced by: '<S3>/Discrete-Time Integrator1'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<S3>/Discrete-Time Integrator1'
                                        */
  51.21584250080452,                   /* Expression: double(Npos_d)
                                        * Referenced by: '<S3>/Filter Gain1'
                                        */
  0.025,                               /* Computed Parameter: DiscreteTimeIntegrator2_gainv_d
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
  0.025,                               /* Computed Parameter: DiscreteTimeIntegrator1_gainv_c
                                        * Referenced by: '<S4>/Discrete-Time Integrator1'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<S4>/Discrete-Time Integrator1'
                                        */
  0.025,                               /* Computed Parameter: DiscreteTimeIntegrator2_gainv_k
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
  -1.0,                                /* Expression: -1
                                        * Referenced by: '<Root>/Gain'
                                        */
  24.0,                                /* Expression: 24
                                        * Referenced by: '<S6>/Saturation'
                                        */
  -24.0,                               /* Expression: -24
                                        * Referenced by: '<S6>/Saturation'
                                        */
  0.020833333333333332,                /* Expression: 1/48
                                        * Referenced by: '<S6>/pwm_skalning'
                                        */
  0.5,                                 /* Expression: 0.5
                                        * Referenced by: '<S6>/pwm_offstet'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<S6>/Enable[1_Off, 0_On]'
                                        */
  5.6905605058023092E-5,               /* Expression: dm_final+ Km*Kemf/R
                                        * Referenced by: '<S1>/Gain3'
                                        */
  0.00062232142857142857,              /* Expression: Km/R
                                        * Referenced by: '<S1>/Gain2'
                                        */
  45356.410675084815,                  /* Expression: 1/Jeq_final
                                        * Referenced by: '<S1>/Gain5'
                                        */
  0.00062232142857142857,              /* Expression: Km/R
                                        * Referenced by: '<S2>/Gain2'
                                        */
  4.3377605058023088E-5,               /* Expression: Km*Kemf/(R)
                                        * Referenced by: '<S2>/Gain4'
                                        */
  29.6,                                /* Expression: 29.6
                                        * Referenced by: '<S3>/Anti-Windup1'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<S3>/Anti-Windup2'
                                        */
  122.13826981894687,                  /* Expression: double(Ipos_d)
                                        * Referenced by: '<S3>/Integral Gain2'
                                        */
  29.6,                                /* Expression: 29.6
                                        * Referenced by: '<S4>/Anti-Windup'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<S4>/Anti-Windup1'
                                        */
  29.6,                                /* Expression: 29.6
                                        * Referenced by: '<S5>/Anti-Windup'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<S5>/Anti-Windup1'
                                        */
  26.553478128254657,                  /* Expression: double(Isp_d)
                                        * Referenced by: '<S5>/Integral Gain2'
                                        */
  0.0                                  /* Expression: 0
                                        * Referenced by: '<S8>/Reset enc'
                                        */
};
