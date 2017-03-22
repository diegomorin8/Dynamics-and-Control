/*
 * mIO.c
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
#include "mIO_trc_ptr.h"
#include "mIO.h"
#include "mIO_private.h"

/* Block signals (auto storage) */
B_mIO_T mIO_B;

/* Continuous states */
X_mIO_T mIO_X;

/* Block states (auto storage) */
DW_mIO_T mIO_DW;

/* Previous zero-crossings (trigger) states */
PrevZCX_mIO_T mIO_PrevZCX;

/* External outputs (root outports fed by signals with auto storage) */
ExtY_mIO_T mIO_Y;

/* Real-time model */
RT_MODEL_mIO_T mIO_M_;
RT_MODEL_mIO_T *const mIO_M = &mIO_M_;

/*
 * This function updates continuous states using the ODE1 fixed-step
 * solver algorithm
 */
static void rt_ertODEUpdateContinuousStates(RTWSolverInfo *si )
{
  time_T tnew = rtsiGetSolverStopTime(si);
  time_T h = rtsiGetStepSize(si);
  real_T *x = rtsiGetContStates(si);
  ODE1_IntgData *id = (ODE1_IntgData *)rtsiGetSolverData(si);
  real_T *f0 = id->f[0];
  int_T i;
  int_T nXc = 2;
  rtsiSetSimTimeStep(si,MINOR_TIME_STEP);
  rtsiSetdX(si, f0);
  mIO_derivatives();
  rtsiSetT(si, tnew);
  for (i = 0; i < nXc; i++) {
    *x += h * f0[i];
    x++;
  }

  rtsiSetSimTimeStep(si,MAJOR_TIME_STEP);
}

/* Model output function */
void mIO_output(void)
{
  real_T temp;
  ZCEventType zcEvent;
  real_T u1;
  real_T u2;
  if (rtmIsMajorTimeStep(mIO_M)) {
    /* set solver stop time */
    if (!(mIO_M->Timing.clockTick0+1)) {
      rtsiSetSolverStopTime(&mIO_M->solverInfo, ((mIO_M->Timing.clockTickH0 + 1)
        * mIO_M->Timing.stepSize0 * 4294967296.0));
    } else {
      rtsiSetSolverStopTime(&mIO_M->solverInfo, ((mIO_M->Timing.clockTick0 + 1) *
        mIO_M->Timing.stepSize0 + mIO_M->Timing.clockTickH0 *
        mIO_M->Timing.stepSize0 * 4294967296.0));
    }
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(mIO_M)) {
    mIO_M->Timing.t[0] = rtsiGetT(&mIO_M->solverInfo);
  }

  /* Integrator: '<S1>/Integrator1' */
  mIO_B.Integrator1 = mIO_X.Integrator1_CSTATE;

  /* Gain: '<S1>/Gain7' */
  mIO_B.Gain7 = mIO_P.Gain7_Gain * mIO_B.Integrator1;

  /* Outport: '<Root>/dph_sim' */
  mIO_Y.dph_sim = mIO_B.Gain7;

  /* Integrator: '<S1>/Integrator2' */
  mIO_B.Integrator2 = mIO_X.Integrator2_CSTATE;

  /* Gain: '<S1>/Gain6' */
  mIO_B.Gain6 = mIO_P.Gain6_Gain * mIO_B.Integrator2;

  /* Outport: '<Root>/phi_sim' */
  mIO_Y.phi_sim = mIO_B.Gain6;

  /* SignalGenerator: '<Root>/Ctrl. Sine' */
  mIO_B.CtrlSine = sin(mIO_P.CtrlSine_Frequency * mIO_M->Timing.t[0]) *
    mIO_P.CtrlSine_Amplitude;

  /* SignalGenerator: '<Root>/Ctrl. Square' */
  temp = mIO_P.CtrlSquare_Frequency * mIO_M->Timing.t[0];
  if (temp - floor(temp) >= 0.5) {
    mIO_B.CtrlSquare = mIO_P.CtrlSquare_Amplitude;
  } else {
    mIO_B.CtrlSquare = -mIO_P.CtrlSquare_Amplitude;
  }

  /* End of SignalGenerator: '<Root>/Ctrl. Square' */

  /* Step: '<Root>/Ctrl. Step' */
  temp = mIO_M->Timing.t[0];
  if (temp < mIO_P.CtrlStep_Time) {
    mIO_B.CtrlStep = mIO_P.CtrlStep_Y0;
  } else {
    mIO_B.CtrlStep = mIO_P.CtrlStep_YFinal;
  }

  /* End of Step: '<Root>/Ctrl. Step' */

  /* Step: '<Root>/Vel.Ref. Step' */
  temp = mIO_M->Timing.t[0];
  if (temp < mIO_P.VelRefStep_Time) {
    mIO_B.VelRefStep = mIO_P.VelRefStep_Y0;
  } else {
    mIO_B.VelRefStep = mIO_P.VelRefStep_YFinal;
  }

  /* End of Step: '<Root>/Vel.Ref. Step' */

  /* SignalGenerator: '<Root>/Vel.Ref. Sine' */
  mIO_B.VelRefSine = sin(mIO_P.VelRefSine_Frequency * mIO_M->Timing.t[0]) *
    mIO_P.VelRefSine_Amplitude;

  /* SignalGenerator: '<Root>/Vel.Ref. Square' */
  temp = mIO_P.VelRefSquare_Frequency * mIO_M->Timing.t[0];
  if (temp - floor(temp) >= 0.5) {
    mIO_B.VelRefSquare = mIO_P.VelRefSquare_Amplitude;
  } else {
    mIO_B.VelRefSquare = -mIO_P.VelRefSquare_Amplitude;
  }

  /* End of SignalGenerator: '<Root>/Vel.Ref. Square' */

  /* MultiPortSwitch: '<Root>/Multiport Switch1' incorporates:
   *  Constant: '<Root>/Vel.Ref. Signal Selector'
   */
  switch ((int32_T)mIO_P.VelRefSignalSelector_Value) {
   case 1:
    mIO_B.MultiportSwitch1 = mIO_B.VelRefStep;
    break;

   case 2:
    mIO_B.MultiportSwitch1 = mIO_B.VelRefSine;
    break;

   default:
    mIO_B.MultiportSwitch1 = mIO_B.VelRefSquare;
    break;
  }

  /* End of MultiPortSwitch: '<Root>/Multiport Switch1' */
  if (rtmIsMajorTimeStep(mIO_M)) {
    /* ZeroOrderHold: '<Root>/ZOH3' */
    mIO_B.ZOH3 = mIO_B.MultiportSwitch1;

    /* S-Function (rti_commonblock): '<S13>/S-Function2' */
    /* This comment workarounds a code generation problem */

    /* Gain: '<S7>/w1_scaling' */
    mIO_B.w1_scaling = mIO_P.w1_scaling_Gain * mIO_B.SFunction2;

    /* Sum: '<Root>/Sum2' */
    mIO_B.Sum2 = mIO_B.ZOH3 - mIO_B.w1_scaling;

    /* Gain: '<S4>/Proportional Gain1' */
    mIO_B.ProportionalGain1 = mIO_P.ProportionalGain1_Gain * mIO_B.Sum2;

    /* Gain: '<S4>/Derivative Gain2' */
    mIO_B.DerivativeGain2 = mIO_P.DerivativeGain2_Gain * mIO_B.Sum2;

    /* DiscreteIntegrator: '<S4>/Discrete-Time Integrator1' */
    mIO_B.DiscreteTimeIntegrator1 = mIO_DW.DiscreteTimeIntegrator1_DSTATE;

    /* Sum: '<S4>/Sum1' */
    mIO_B.Sum1 = mIO_B.DerivativeGain2 - mIO_B.DiscreteTimeIntegrator1;

    /* Gain: '<S4>/Filter Gain1' */
    mIO_B.FilterGain1 = mIO_P.FilterGain1_Gain * mIO_B.Sum1;

    /* Sum: '<S4>/Add2' */
    mIO_B.Add2 = mIO_B.ProportionalGain1 + mIO_B.FilterGain1;

    /* DiscreteIntegrator: '<S4>/Discrete-Time Integrator2' */
    mIO_B.DiscreteTimeIntegrator2 = mIO_DW.DiscreteTimeIntegrator2_DSTATE;

    /* Sum: '<S4>/Sum3' */
    mIO_B.Sum3 = mIO_B.Add2 + mIO_B.DiscreteTimeIntegrator2;

    /* Saturate: '<S4>/Saturation' */
    temp = mIO_B.Sum3;
    u1 = mIO_P.Saturation_LowerSat;
    u2 = mIO_P.Saturation_UpperSat;
    if (temp > u2) {
      mIO_B.Saturation = u2;
    } else if (temp < u1) {
      mIO_B.Saturation = u1;
    } else {
      mIO_B.Saturation = temp;
    }

    /* End of Saturate: '<S4>/Saturation' */
  }

  /* Step: '<Root>/Pos' */
  temp = mIO_M->Timing.t[0];
  if (temp < mIO_P.Pos_Time) {
    mIO_B.Pos = mIO_P.Pos_Y0;
  } else {
    mIO_B.Pos = mIO_P.Pos_YFinal;
  }

  /* End of Step: '<Root>/Pos' */
  if (rtmIsMajorTimeStep(mIO_M)) {
    /* ZeroOrderHold: '<Root>/ZOH1' */
    mIO_B.ZOH1 = mIO_B.Pos;

    /* S-Function (rti_commonblock): '<S13>/S-Function1' */
    /* This comment workarounds a code generation problem */

    /* Gain: '<S7>/fi1_scaling' */
    mIO_B.fi1_scaling = mIO_P.fi1_scaling_Gain * mIO_B.SFunction1;

    /* Sum: '<Root>/Sum1' */
    mIO_B.Sum1_o = mIO_B.ZOH1 - mIO_B.fi1_scaling;

    /* Gain: '<S2>/Proportional Gain1' */
    mIO_B.ProportionalGain1_c = mIO_P.ProportionalGain1_Gain_c * mIO_B.Sum1_o;

    /* Gain: '<S2>/Derivative Gain2' */
    mIO_B.DerivativeGain2_p = mIO_P.DerivativeGain2_Gain_l * mIO_B.Sum1_o;

    /* DiscreteIntegrator: '<S2>/Discrete-Time Integrator1' */
    mIO_B.DiscreteTimeIntegrator1_p = mIO_DW.DiscreteTimeIntegrator1_DSTAT_l;

    /* Sum: '<S2>/Sum1' */
    mIO_B.Sum1_e = mIO_B.DerivativeGain2_p - mIO_B.DiscreteTimeIntegrator1_p;

    /* Gain: '<S2>/Filter Gain1' */
    mIO_B.FilterGain1_i = mIO_P.FilterGain1_Gain_o * mIO_B.Sum1_e;

    /* Sum: '<S2>/Add2' */
    mIO_B.Add2_a = mIO_B.ProportionalGain1_c + mIO_B.FilterGain1_i;

    /* DiscreteIntegrator: '<S2>/Discrete-Time Integrator2' */
    mIO_B.DiscreteTimeIntegrator2_h = mIO_DW.DiscreteTimeIntegrator2_DSTAT_k;

    /* Sum: '<S2>/Sum3' */
    mIO_B.Sum3_a = mIO_B.Add2_a + mIO_B.DiscreteTimeIntegrator2_h;

    /* Saturate: '<S2>/Saturation' */
    temp = mIO_B.Sum3_a;
    u1 = mIO_P.Saturation_LowerSat_c;
    u2 = mIO_P.Saturation_UpperSat_b;
    if (temp > u2) {
      mIO_B.Saturation_k = u2;
    } else if (temp < u1) {
      mIO_B.Saturation_k = u1;
    } else {
      mIO_B.Saturation_k = temp;
    }

    /* End of Saturate: '<S2>/Saturation' */

    /* ZeroOrderHold: '<Root>/ZOH2' */
    mIO_B.ZOH2 = mIO_B.Pos;

    /* Sum: '<Root>/Sum3' */
    mIO_B.Sum3_o = mIO_B.ZOH2 - mIO_B.fi1_scaling;

    /* Gain: '<S3>/Proportional Gain' */
    mIO_B.ProportionalGain = mIO_P.Ppos * mIO_B.Sum3_o;

    /* DiscreteIntegrator: '<S3>/Discrete-Time Integrator1' */
    mIO_B.DiscreteTimeIntegrator1_pk = mIO_DW.DiscreteTimeIntegrator1_DSTAT_i;

    /* Gain: '<S3>/Derivative Gain' */
    mIO_B.DerivativeGain = mIO_P.Dpos * mIO_B.Sum3_o;

    /* DiscreteIntegrator: '<S3>/Discrete-Time Integrator2' */
    mIO_B.DiscreteTimeIntegrator2_f = mIO_DW.DiscreteTimeIntegrator2_DSTAT_p;

    /* Sum: '<S3>/Sum' */
    mIO_B.Sum = mIO_B.DerivativeGain - mIO_B.DiscreteTimeIntegrator2_f;

    /* Gain: '<S3>/Filter Gain' */
    mIO_B.FilterGain = mIO_P.Npos * mIO_B.Sum;

    /* Sum: '<S3>/Sum1' */
    mIO_B.Sum1_ec = (mIO_B.ProportionalGain + mIO_B.DiscreteTimeIntegrator1_pk)
      + mIO_B.FilterGain;

    /* Saturate: '<S3>/Saturation' */
    temp = mIO_B.Sum1_ec;
    u1 = mIO_P.Saturation_LowerSat_m;
    u2 = mIO_P.Saturation_UpperSat_g;
    if (temp > u2) {
      mIO_B.Saturation_a = u2;
    } else if (temp < u1) {
      mIO_B.Saturation_a = u1;
    } else {
      mIO_B.Saturation_a = temp;
    }

    /* End of Saturate: '<S3>/Saturation' */
  }

  /* MultiPortSwitch: '<Root>/Multiport Switch' incorporates:
   *  Constant: '<Root>/Ctrl. Signal Selector'
   */
  switch ((int32_T)mIO_P.CtrlSignalSelector_Value) {
   case 1:
    mIO_B.MultiportSwitch = mIO_B.CtrlSine;
    break;

   case 2:
    mIO_B.MultiportSwitch = mIO_B.CtrlSquare;
    break;

   case 3:
    mIO_B.MultiportSwitch = mIO_B.CtrlStep;
    break;

   case 4:
    mIO_B.MultiportSwitch = mIO_B.Saturation;
    break;

   case 5:
    mIO_B.MultiportSwitch = mIO_B.Saturation_k;
    break;

   default:
    mIO_B.MultiportSwitch = mIO_B.Saturation_a;
    break;
  }

  /* End of MultiPortSwitch: '<Root>/Multiport Switch' */

  /* Gain: '<Root>/Gain' */
  mIO_B.Gain = mIO_P.Gain_Gain * mIO_B.MultiportSwitch;

  /* Saturate: '<S5>/Saturation' */
  temp = mIO_B.Gain;
  u1 = mIO_P.Saturation_LowerSat_k;
  u2 = mIO_P.Saturation_UpperSat_bg;
  if (temp > u2) {
    mIO_B.Saturation_n = u2;
  } else if (temp < u1) {
    mIO_B.Saturation_n = u1;
  } else {
    mIO_B.Saturation_n = temp;
  }

  /* End of Saturate: '<S5>/Saturation' */

  /* Gain: '<S5>/pwm_skalning' */
  mIO_B.pwm_skalning = mIO_P.pwm_skalning_Gain * mIO_B.Saturation_n;

  /* Sum: '<S5>/Sum' incorporates:
   *  Constant: '<S5>/pwm_offstet'
   */
  mIO_B.Sum_k = mIO_B.pwm_skalning + mIO_P.pwm_offstet_Value;
  if (rtmIsMajorTimeStep(mIO_M)) {
    /* S-Function (rti_commonblock): '<S9>/S-Function1' */
    /* This comment workarounds a code generation problem */

    /* dSPACE I/O Board DS1104 #1 Unit:PWM Group:PWM */
    ds1104_slave_dsp_pwm_duty_write(0, rti_slv1104_fcn_index[6], mIO_B.Sum_k);

    /* S-Function (rti_commonblock): '<S9>/S-Function2' */
    /* This comment workarounds a code generation problem */

    /* S-Function (rti_commonblock): '<S9>/S-Function3' */
    /* This comment workarounds a code generation problem */

    /* S-Function (rti_commonblock): '<S9>/S-Function4' */
    /* This comment workarounds a code generation problem */

    /* DataTypeConversion: '<S5>/Data Type Conversion' incorporates:
     *  Constant: '<S5>/Enable[1_Off, 0_On]'
     */
    mIO_B.DataTypeConversion = (mIO_P.Enable1_Off0_On_Value != 0.0);

    /* S-Function (rti_commonblock): '<S8>/S-Function1' */
    /* This comment workarounds a code generation problem */

    /* dSPACE I/O Board DS1104 #1 Unit:BIT_IO Group:BIT_OUT */
    if (mIO_B.DataTypeConversion > 0) {
      ds1104_bit_io_set(DS1104_DIO0);
    } else {
      ds1104_bit_io_clear(DS1104_DIO0);
    }
  }

  /* Gain: '<S1>/Gain2' */
  mIO_B.Gain2 = mIO_P.Gain2_Gain * mIO_B.MultiportSwitch;

  /* Gain: '<S1>/eps_dm' */
  mIO_B.eps_dm = mIO_P.eps_dm * mIO_B.Integrator1;

  /* Gain: '<S1>/Friction' */
  mIO_B.Friction = mIO_P.dm * mIO_B.eps_dm;

  /* Gain: '<S1>/Gain4' */
  mIO_B.Gain4 = mIO_P.Gain4_Gain * mIO_B.Integrator1;

  /* Sum: '<S1>/Sum2' */
  mIO_B.Sum2_g = mIO_B.Friction + mIO_B.Gain4;

  /* Sum: '<S1>/Sum1' */
  mIO_B.Sum1_a = mIO_B.Gain2 - mIO_B.Sum2_g;
  if (rtmIsMajorTimeStep(mIO_M)) {
    /* Gain: '<S1>/eps_Jeq' incorporates:
     *  Constant: '<S1>/Jeq'
     */
    mIO_B.eps_Jeq = mIO_P.eps_Jeq * mIO_P.Jeq;
  }

  /* Product: '<S1>/Divide' */
  mIO_B.Divide = mIO_B.Sum1_a / mIO_B.eps_Jeq;
  if (rtmIsMajorTimeStep(mIO_M)) {
    /* Sum: '<S2>/Sum2' */
    mIO_B.Sum2_b = mIO_B.Sum3_a - mIO_B.Saturation_k;

    /* Gain: '<S2>/Anti-Windup1' */
    mIO_B.AntiWindup1 = mIO_P.AntiWindup1_Gain * mIO_B.Sum2_b;

    /* Gain: '<S2>/Anti-Windup2' */
    mIO_B.AntiWindup2 = mIO_P.AntiWindup2_Gain * mIO_B.AntiWindup1;

    /* Gain: '<S2>/Integral Gain2' */
    mIO_B.IntegralGain2 = mIO_P.IntegralGain2_Gain * mIO_B.Sum1_o;

    /* Sum: '<S2>/Sum5' */
    mIO_B.Sum5 = mIO_B.IntegralGain2 - mIO_B.AntiWindup2;

    /* Sum: '<S3>/Sum3' */
    mIO_B.Sum3_b = mIO_B.Sum1_ec - mIO_B.Saturation_a;

    /* Gain: '<S3>/Anti-Windup' */
    mIO_B.AntiWindup = mIO_P.AntiWindup_Gain * mIO_B.Sum3_b;

    /* Gain: '<S3>/Anti-Windup1' */
    mIO_B.AntiWindup1_n = mIO_P.AntiWindup1_Gain_j * mIO_B.AntiWindup;

    /* Gain: '<S3>/Integral Gain' */
    mIO_B.IntegralGain = mIO_P.Ipos * mIO_B.Sum3_o;

    /* Sum: '<S3>/Sum4' */
    mIO_B.Sum4 = mIO_B.IntegralGain - mIO_B.AntiWindup1_n;

    /* Sum: '<S4>/Sum2' */
    mIO_B.Sum2_o = mIO_B.Sum3 - mIO_B.Saturation;

    /* Gain: '<S4>/Anti-Windup' */
    mIO_B.AntiWindup_e = mIO_P.AntiWindup_Gain_o * mIO_B.Sum2_o;

    /* Gain: '<S4>/Anti-Windup1' */
    mIO_B.AntiWindup1_k = mIO_P.AntiWindup1_Gain_f * mIO_B.AntiWindup_e;

    /* Gain: '<S4>/Integral Gain2' */
    mIO_B.IntegralGain2_g = mIO_P.IntegralGain2_Gain_h * mIO_B.Sum2;

    /* Sum: '<S4>/Sum4' */
    mIO_B.Sum4_f = mIO_B.IntegralGain2_g - mIO_B.AntiWindup1_k;

    /* Outputs for Triggered SubSystem: '<S7>/DS1104ENC_SET_POS_C1' incorporates:
     *  TriggerPort: '<S15>/Trigger'
     */
    if (rtmIsMajorTimeStep(mIO_M)) {
      /* Constant: '<S7>/Reset enc' */
      zcEvent = rt_ZCFcn(RISING_ZERO_CROSSING,
                         &mIO_PrevZCX.DS1104ENC_SET_POS_C1_Trig_ZCE,
                         (mIO_P.Resetenc_Value));
      if (zcEvent != NO_ZCEVENT) {
        /* S-Function (rti_commonblock): '<S15>/S-Function1' */
        /* This comment workarounds a code generation problem */

        /* dSPACE I/O Board DS1104 Unit:ENC_SET */
        ds1104_inc_position_write(1, 0, DS1104_INC_LINE_SUBDIV_4);
      }
    }

    /* End of Outputs for SubSystem: '<S7>/DS1104ENC_SET_POS_C1' */

    /* S-Function (rti_commonblock): '<S14>/S-Function1' */
    /* This comment workarounds a code generation problem */

    /* S-Function (rti_commonblock): '<S14>/S-Function2' */
    /* This comment workarounds a code generation problem */
  }
}

/* Model update function */
void mIO_update(void)
{
  if (rtmIsMajorTimeStep(mIO_M)) {
    /* Update for DiscreteIntegrator: '<S4>/Discrete-Time Integrator1' */
    mIO_DW.DiscreteTimeIntegrator1_DSTATE +=
      mIO_P.DiscreteTimeIntegrator1_gainval * mIO_B.FilterGain1;

    /* Update for DiscreteIntegrator: '<S4>/Discrete-Time Integrator2' */
    mIO_DW.DiscreteTimeIntegrator2_DSTATE +=
      mIO_P.DiscreteTimeIntegrator2_gainval * mIO_B.Sum4_f;

    /* Update for DiscreteIntegrator: '<S2>/Discrete-Time Integrator1' */
    mIO_DW.DiscreteTimeIntegrator1_DSTAT_l +=
      mIO_P.DiscreteTimeIntegrator1_gainv_h * mIO_B.FilterGain1_i;

    /* Update for DiscreteIntegrator: '<S2>/Discrete-Time Integrator2' */
    mIO_DW.DiscreteTimeIntegrator2_DSTAT_k +=
      mIO_P.DiscreteTimeIntegrator2_gainv_d * mIO_B.Sum5;

    /* Update for DiscreteIntegrator: '<S3>/Discrete-Time Integrator1' */
    mIO_DW.DiscreteTimeIntegrator1_DSTAT_i +=
      mIO_P.DiscreteTimeIntegrator1_gainv_c * mIO_B.Sum4;

    /* Update for DiscreteIntegrator: '<S3>/Discrete-Time Integrator2' */
    mIO_DW.DiscreteTimeIntegrator2_DSTAT_p +=
      mIO_P.DiscreteTimeIntegrator2_gainv_k * mIO_B.FilterGain;
  }

  if (rtmIsMajorTimeStep(mIO_M)) {
    rt_ertODEUpdateContinuousStates(&mIO_M->solverInfo);
  }

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++mIO_M->Timing.clockTick0)) {
    ++mIO_M->Timing.clockTickH0;
  }

  mIO_M->Timing.t[0] = rtsiGetSolverStopTime(&mIO_M->solverInfo);

  {
    /* Update absolute timer for sample time: [0.025s, 0.0s] */
    /* The "clockTick1" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick1"
     * and "Timing.stepSize1". Size of "clockTick1" ensures timer will not
     * overflow during the application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick1 and the high bits
     * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
     */
    if (!(++mIO_M->Timing.clockTick1)) {
      ++mIO_M->Timing.clockTickH1;
    }

    mIO_M->Timing.t[1] = mIO_M->Timing.clockTick1 * mIO_M->Timing.stepSize1 +
      mIO_M->Timing.clockTickH1 * mIO_M->Timing.stepSize1 * 4294967296.0;
  }
}

/* Derivatives for root system: '<Root>' */
void mIO_derivatives(void)
{
  XDot_mIO_T *_rtXdot;
  _rtXdot = ((XDot_mIO_T *) mIO_M->ModelData.derivs);

  /* Derivatives for Integrator: '<S1>/Integrator1' */
  _rtXdot->Integrator1_CSTATE = mIO_B.Divide;

  /* Derivatives for Integrator: '<S1>/Integrator2' */
  _rtXdot->Integrator2_CSTATE = mIO_B.Integrator1;
}

/* Model initialize function */
void mIO_initialize(void)
{
  /* Start for S-Function (rti_commonblock): '<S9>/S-Function1' */

  /* dSPACE I/O Board DS1104 #1 Unit:PWM Group:PWM */
  mIO_DW.SFunction1_IWORK[0] = 0;
  mIO_PrevZCX.DS1104ENC_SET_POS_C1_Trig_ZCE = UNINITIALIZED_ZCSIG;

  /* InitializeConditions for Integrator: '<S1>/Integrator1' */
  mIO_X.Integrator1_CSTATE = mIO_P.Integrator1_IC;

  /* InitializeConditions for Integrator: '<S1>/Integrator2' */
  mIO_X.Integrator2_CSTATE = mIO_P.Integrator2_IC;

  /* InitializeConditions for DiscreteIntegrator: '<S4>/Discrete-Time Integrator1' */
  mIO_DW.DiscreteTimeIntegrator1_DSTATE = mIO_P.DiscreteTimeIntegrator1_IC;

  /* InitializeConditions for DiscreteIntegrator: '<S4>/Discrete-Time Integrator2' */
  mIO_DW.DiscreteTimeIntegrator2_DSTATE = mIO_P.DiscreteTimeIntegrator2_IC;

  /* InitializeConditions for DiscreteIntegrator: '<S2>/Discrete-Time Integrator1' */
  mIO_DW.DiscreteTimeIntegrator1_DSTAT_l = mIO_P.DiscreteTimeIntegrator1_IC_a;

  /* InitializeConditions for DiscreteIntegrator: '<S2>/Discrete-Time Integrator2' */
  mIO_DW.DiscreteTimeIntegrator2_DSTAT_k = mIO_P.DiscreteTimeIntegrator2_IC_o;

  /* InitializeConditions for DiscreteIntegrator: '<S3>/Discrete-Time Integrator1' */
  mIO_DW.DiscreteTimeIntegrator1_DSTAT_i = mIO_P.DiscreteTimeIntegrator1_IC_l;

  /* InitializeConditions for DiscreteIntegrator: '<S3>/Discrete-Time Integrator2' */
  mIO_DW.DiscreteTimeIntegrator2_DSTAT_p = mIO_P.DiscreteTimeIntegrator2_IC_d;
}

/* Model terminate function */
void mIO_terminate(void)
{
  /* (no terminate code required) */
}

/*========================================================================*
 * Start of Classic call interface                                        *
 *========================================================================*/

/* Solver interface called by GRT_Main */
#ifndef USE_GENERATED_SOLVER

void rt_ODECreateIntegrationData(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

void rt_ODEDestroyIntegrationData(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

void rt_ODEUpdateContinuousStates(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

#endif

void MdlOutputs(int_T tid)
{
  mIO_output();
  UNUSED_PARAMETER(tid);
}

void MdlUpdate(int_T tid)
{
  mIO_update();
  UNUSED_PARAMETER(tid);
}

void MdlInitializeSizes(void)
{
}

void MdlInitializeSampleTimes(void)
{
}

void MdlInitialize(void)
{
}

void MdlStart(void)
{
  mIO_initialize();
}

void MdlTerminate(void)
{
  mIO_terminate();
}

/* Registration function */
RT_MODEL_mIO_T *mIO(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)mIO_M, 0,
                sizeof(RT_MODEL_mIO_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&mIO_M->solverInfo, &mIO_M->Timing.simTimeStep);
    rtsiSetTPtr(&mIO_M->solverInfo, &rtmGetTPtr(mIO_M));
    rtsiSetStepSizePtr(&mIO_M->solverInfo, &mIO_M->Timing.stepSize0);
    rtsiSetdXPtr(&mIO_M->solverInfo, &mIO_M->ModelData.derivs);
    rtsiSetContStatesPtr(&mIO_M->solverInfo, (real_T **)
                         &mIO_M->ModelData.contStates);
    rtsiSetNumContStatesPtr(&mIO_M->solverInfo, &mIO_M->Sizes.numContStates);
    rtsiSetErrorStatusPtr(&mIO_M->solverInfo, (&rtmGetErrorStatus(mIO_M)));
    rtsiSetRTModelPtr(&mIO_M->solverInfo, mIO_M);
  }

  rtsiSetSimTimeStep(&mIO_M->solverInfo, MAJOR_TIME_STEP);
  mIO_M->ModelData.intgData.f[0] = mIO_M->ModelData.odeF[0];
  mIO_M->ModelData.contStates = ((real_T *) &mIO_X);
  rtsiSetSolverData(&mIO_M->solverInfo, (void *)&mIO_M->ModelData.intgData);
  rtsiSetSolverName(&mIO_M->solverInfo,"ode1");

  /* Initialize timing info */
  {
    int_T *mdlTsMap = mIO_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    mdlTsMap[1] = 1;
    mIO_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    mIO_M->Timing.sampleTimes = (&mIO_M->Timing.sampleTimesArray[0]);
    mIO_M->Timing.offsetTimes = (&mIO_M->Timing.offsetTimesArray[0]);

    /* task periods */
    mIO_M->Timing.sampleTimes[0] = (0.0);
    mIO_M->Timing.sampleTimes[1] = (0.025);

    /* task offsets */
    mIO_M->Timing.offsetTimes[0] = (0.0);
    mIO_M->Timing.offsetTimes[1] = (0.0);
  }

  rtmSetTPtr(mIO_M, &mIO_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = mIO_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    mdlSampleHits[1] = 1;
    mIO_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(mIO_M, -1);
  mIO_M->Timing.stepSize0 = 0.025;
  mIO_M->Timing.stepSize1 = 0.025;
  mIO_M->solverInfoPtr = (&mIO_M->solverInfo);
  mIO_M->Timing.stepSize = (0.025);
  rtsiSetFixedStepSize(&mIO_M->solverInfo, 0.025);
  rtsiSetSolverMode(&mIO_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  mIO_M->ModelData.blockIO = ((void *) &mIO_B);
  (void) memset(((void *) &mIO_B), 0,
                sizeof(B_mIO_T));

  {
    mIO_B.Integrator1 = 0.0;
    mIO_B.Gain7 = 0.0;
    mIO_B.Integrator2 = 0.0;
    mIO_B.Gain6 = 0.0;
    mIO_B.CtrlSine = 0.0;
    mIO_B.CtrlSquare = 0.0;
    mIO_B.CtrlStep = 0.0;
    mIO_B.VelRefStep = 0.0;
    mIO_B.VelRefSine = 0.0;
    mIO_B.VelRefSquare = 0.0;
    mIO_B.MultiportSwitch1 = 0.0;
    mIO_B.ZOH3 = 0.0;
    mIO_B.SFunction2 = 0.0;
    mIO_B.w1_scaling = 0.0;
    mIO_B.Sum2 = 0.0;
    mIO_B.ProportionalGain1 = 0.0;
    mIO_B.DerivativeGain2 = 0.0;
    mIO_B.DiscreteTimeIntegrator1 = 0.0;
    mIO_B.Sum1 = 0.0;
    mIO_B.FilterGain1 = 0.0;
    mIO_B.Add2 = 0.0;
    mIO_B.DiscreteTimeIntegrator2 = 0.0;
    mIO_B.Sum3 = 0.0;
    mIO_B.Saturation = 0.0;
    mIO_B.Pos = 0.0;
    mIO_B.ZOH1 = 0.0;
    mIO_B.SFunction1 = 0.0;
    mIO_B.fi1_scaling = 0.0;
    mIO_B.Sum1_o = 0.0;
    mIO_B.ProportionalGain1_c = 0.0;
    mIO_B.DerivativeGain2_p = 0.0;
    mIO_B.DiscreteTimeIntegrator1_p = 0.0;
    mIO_B.Sum1_e = 0.0;
    mIO_B.FilterGain1_i = 0.0;
    mIO_B.Add2_a = 0.0;
    mIO_B.DiscreteTimeIntegrator2_h = 0.0;
    mIO_B.Sum3_a = 0.0;
    mIO_B.Saturation_k = 0.0;
    mIO_B.ZOH2 = 0.0;
    mIO_B.Sum3_o = 0.0;
    mIO_B.ProportionalGain = 0.0;
    mIO_B.DiscreteTimeIntegrator1_pk = 0.0;
    mIO_B.DerivativeGain = 0.0;
    mIO_B.DiscreteTimeIntegrator2_f = 0.0;
    mIO_B.Sum = 0.0;
    mIO_B.FilterGain = 0.0;
    mIO_B.Sum1_ec = 0.0;
    mIO_B.Saturation_a = 0.0;
    mIO_B.MultiportSwitch = 0.0;
    mIO_B.Gain = 0.0;
    mIO_B.Saturation_n = 0.0;
    mIO_B.pwm_skalning = 0.0;
    mIO_B.Sum_k = 0.0;
    mIO_B.Gain2 = 0.0;
    mIO_B.eps_dm = 0.0;
    mIO_B.Friction = 0.0;
    mIO_B.Gain4 = 0.0;
    mIO_B.Sum2_g = 0.0;
    mIO_B.Sum1_a = 0.0;
    mIO_B.eps_Jeq = 0.0;
    mIO_B.Divide = 0.0;
    mIO_B.Sum2_b = 0.0;
    mIO_B.AntiWindup1 = 0.0;
    mIO_B.AntiWindup2 = 0.0;
    mIO_B.IntegralGain2 = 0.0;
    mIO_B.Sum5 = 0.0;
    mIO_B.Sum3_b = 0.0;
    mIO_B.AntiWindup = 0.0;
    mIO_B.AntiWindup1_n = 0.0;
    mIO_B.IntegralGain = 0.0;
    mIO_B.Sum4 = 0.0;
    mIO_B.Sum2_o = 0.0;
    mIO_B.AntiWindup_e = 0.0;
    mIO_B.AntiWindup1_k = 0.0;
    mIO_B.IntegralGain2_g = 0.0;
    mIO_B.Sum4_f = 0.0;
  }

  /* parameters */
  mIO_M->ModelData.defaultParam = ((real_T *)&mIO_P);

  /* states (continuous) */
  {
    real_T *x = (real_T *) &mIO_X;
    mIO_M->ModelData.contStates = (x);
    (void) memset((void *)&mIO_X, 0,
                  sizeof(X_mIO_T));
  }

  /* states (dwork) */
  mIO_M->ModelData.dwork = ((void *) &mIO_DW);
  (void) memset((void *)&mIO_DW, 0,
                sizeof(DW_mIO_T));
  mIO_DW.DiscreteTimeIntegrator1_DSTATE = 0.0;
  mIO_DW.DiscreteTimeIntegrator2_DSTATE = 0.0;
  mIO_DW.DiscreteTimeIntegrator1_DSTAT_l = 0.0;
  mIO_DW.DiscreteTimeIntegrator2_DSTAT_k = 0.0;
  mIO_DW.DiscreteTimeIntegrator1_DSTAT_i = 0.0;
  mIO_DW.DiscreteTimeIntegrator2_DSTAT_p = 0.0;

  /* external outputs */
  mIO_M->ModelData.outputs = (&mIO_Y);
  mIO_Y.dph_sim = 0.0;
  mIO_Y.phi_sim = 0.0;

  {
    /* user code (registration function declaration) */
    /*Call the macro that initializes the global TRC pointers
       inside the model initialization/registration function. */
    RTI_INIT_TRC_POINTERS();
  }

  /* Initialize Sizes */
  mIO_M->Sizes.numContStates = (2);    /* Number of continuous states */
  mIO_M->Sizes.numY = (2);             /* Number of model outputs */
  mIO_M->Sizes.numU = (0);             /* Number of model inputs */
  mIO_M->Sizes.sysDirFeedThru = (0);   /* The model is not direct feedthrough */
  mIO_M->Sizes.numSampTimes = (2);     /* Number of sample times */
  mIO_M->Sizes.numBlocks = (94);       /* Number of blocks */
  mIO_M->Sizes.numBlockIO = (77);      /* Number of block outputs */
  mIO_M->Sizes.numBlockPrms = (74);    /* Sum of parameter "widths" */
  return mIO_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
