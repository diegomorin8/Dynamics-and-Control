/*
 * mIO.c
 *
 * Code generation for model "mIO".
 *
 * Model version              : 1.48
 * Simulink Coder version : 8.7 (R2014b) 08-Sep-2014
 * C source code generated on : Wed Mar 08 15:10:40 2017
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
  int_T nXc = 4;
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

real_T rt_roundd_snf(real_T u)
{
  real_T y;
  if (fabs(u) < 4.503599627370496E+15) {
    if (u >= 0.5) {
      y = floor(u + 0.5);
    } else if (u > -0.5) {
      y = u * 0.0;
    } else {
      y = ceil(u - 0.5);
    }
  } else {
    y = u;
  }

  return y;
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

  /* Integrator: '<S2>/Integrator1' */
  mIO_B.Integrator1 = mIO_X.Integrator1_CSTATE;

  /* Gain: '<S2>/Gain7' */
  mIO_B.Gain7 = mIO_P.Gain7_Gain * mIO_B.Integrator1;

  /* Outport: '<Root>/dph_sim' */
  mIO_Y.dph_sim = mIO_B.Gain7;

  /* Integrator: '<S2>/Integrator2' */
  mIO_B.Integrator2 = mIO_X.Integrator2_CSTATE;

  /* Gain: '<S2>/Gain6' */
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

    /* S-Function (rti_commonblock): '<S14>/S-Function2' */
    /* This comment workarounds a code generation problem */

    /* Gain: '<S8>/w1_scaling' */
    mIO_B.w1_scaling = mIO_P.w1_scaling_Gain * mIO_B.SFunction2;

    /* Sum: '<Root>/Sum2' */
    mIO_B.Sum2 = mIO_B.ZOH3 - mIO_B.w1_scaling;

    /* Gain: '<S5>/Proportional Gain1' */
    mIO_B.ProportionalGain1 = mIO_P.ProportionalGain1_Gain * mIO_B.Sum2;

    /* Gain: '<S5>/Derivative Gain2' */
    mIO_B.DerivativeGain2 = mIO_P.DerivativeGain2_Gain * mIO_B.Sum2;

    /* DiscreteIntegrator: '<S5>/Discrete-Time Integrator1' */
    mIO_B.DiscreteTimeIntegrator1 = mIO_DW.DiscreteTimeIntegrator1_DSTATE;

    /* Sum: '<S5>/Sum1' */
    mIO_B.Sum1 = mIO_B.DerivativeGain2 - mIO_B.DiscreteTimeIntegrator1;

    /* Gain: '<S5>/Filter Gain1' */
    mIO_B.FilterGain1 = mIO_P.FilterGain1_Gain * mIO_B.Sum1;

    /* Sum: '<S5>/Add2' */
    mIO_B.Add2 = mIO_B.ProportionalGain1 + mIO_B.FilterGain1;

    /* DiscreteIntegrator: '<S5>/Discrete-Time Integrator2' */
    mIO_B.DiscreteTimeIntegrator2 = mIO_DW.DiscreteTimeIntegrator2_DSTATE;

    /* Sum: '<S5>/Sum3' */
    mIO_B.Sum3 = mIO_B.Add2 + mIO_B.DiscreteTimeIntegrator2;

    /* Saturate: '<S5>/Saturation' */
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

    /* End of Saturate: '<S5>/Saturation' */

    /* Quantizer: '<Root>/Quantizer3' */
    temp = mIO_B.Saturation;
    mIO_B.Quantizer3 = rt_roundd_snf(temp / mIO_P.Pulses) * mIO_P.Pulses;
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

    /* S-Function (rti_commonblock): '<S14>/S-Function1' */
    /* This comment workarounds a code generation problem */

    /* Gain: '<S8>/fi1_scaling' */
    mIO_B.fi1_scaling = mIO_P.fi1_scaling_Gain * mIO_B.SFunction1;

    /* Sum: '<Root>/Sum1' */
    mIO_B.Sum1_o = mIO_B.ZOH1 - mIO_B.fi1_scaling;

    /* Gain: '<S3>/Proportional Gain1' */
    mIO_B.ProportionalGain1_c = mIO_P.ProportionalGain1_Gain_c * mIO_B.Sum1_o;

    /* Gain: '<S3>/Derivative Gain2' */
    mIO_B.DerivativeGain2_p = mIO_P.DerivativeGain2_Gain_l * mIO_B.Sum1_o;

    /* DiscreteIntegrator: '<S3>/Discrete-Time Integrator1' */
    mIO_B.DiscreteTimeIntegrator1_p = mIO_DW.DiscreteTimeIntegrator1_DSTAT_l;

    /* Sum: '<S3>/Sum1' */
    mIO_B.Sum1_e = mIO_B.DerivativeGain2_p - mIO_B.DiscreteTimeIntegrator1_p;

    /* Gain: '<S3>/Filter Gain1' */
    mIO_B.FilterGain1_i = mIO_P.FilterGain1_Gain_o * mIO_B.Sum1_e;

    /* Sum: '<S3>/Add2' */
    mIO_B.Add2_a = mIO_B.ProportionalGain1_c + mIO_B.FilterGain1_i;

    /* DiscreteIntegrator: '<S3>/Discrete-Time Integrator2' */
    mIO_B.DiscreteTimeIntegrator2_h = mIO_DW.DiscreteTimeIntegrator2_DSTAT_k;

    /* Sum: '<S3>/Sum3' */
    mIO_B.Sum3_a = mIO_B.Add2_a + mIO_B.DiscreteTimeIntegrator2_h;

    /* Saturate: '<S3>/Saturation' */
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

    /* End of Saturate: '<S3>/Saturation' */

    /* Quantizer: '<Root>/Quantizer1' */
    temp = mIO_B.Saturation_k;
    mIO_B.Quantizer1 = rt_roundd_snf(temp / mIO_P.Pulses) * mIO_P.Pulses;

    /* ZeroOrderHold: '<Root>/ZOH2' */
    mIO_B.ZOH2 = mIO_B.Pos;

    /* Quantizer: '<Root>/Quantizer' */
    temp = mIO_B.fi1_scaling;
    mIO_B.Quantizer = rt_roundd_snf(temp / mIO_P.Pulses) * mIO_P.Pulses;

    /* ZeroOrderHold: '<Root>/ZOH' */
    mIO_B.ZOH = mIO_B.Quantizer;

    /* SampleTimeMath: '<S1>/TSamp'
     *
     * About '<S1>/TSamp':
     *  y = u * K where K = 1 / ( w * Ts )
     */
    mIO_B.TSamp = mIO_B.ZOH * mIO_P.TSamp_WtEt;

    /* UnitDelay: '<S1>/UD' */
    mIO_B.Uk1 = mIO_DW.UD_DSTATE;

    /* Sum: '<S1>/Diff' */
    mIO_B.Diff = mIO_B.TSamp - mIO_B.Uk1;

    /* Sum: '<Root>/Sum3' */
    mIO_B.Sum3_o = mIO_B.ZOH2 - mIO_B.Diff;

    /* Gain: '<S4>/Proportional Gain' */
    mIO_B.ProportionalGain = mIO_P.Ppos * mIO_B.Sum3_o;
  }

  /* Integrator: '<S4>/Integrator' */
  mIO_B.Integrator = mIO_X.Integrator_CSTATE;
  if (rtmIsMajorTimeStep(mIO_M)) {
    /* Gain: '<S4>/Derivative Gain' */
    mIO_B.DerivativeGain = mIO_P.Dpos * mIO_B.Sum3_o;
  }

  /* Integrator: '<S4>/Integrator1' */
  mIO_B.Integrator1_l = mIO_X.Integrator1_CSTATE_n;

  /* Sum: '<S4>/Sum' */
  mIO_B.Sum = mIO_B.DerivativeGain - mIO_B.Integrator1_l;

  /* Gain: '<S4>/Filter Gain' */
  mIO_B.FilterGain = mIO_P.Npos * mIO_B.Sum;

  /* Sum: '<S4>/Sum1' */
  mIO_B.Sum1_ec = (mIO_B.ProportionalGain + mIO_B.Integrator) + mIO_B.FilterGain;

  /* Saturate: '<S4>/Saturation' */
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

  /* End of Saturate: '<S4>/Saturation' */
  if (rtmIsMajorTimeStep(mIO_M)) {
    /* Quantizer: '<Root>/Quantizer2' */
    temp = mIO_B.Saturation_a;
    mIO_B.Quantizer2 = rt_roundd_snf(temp / mIO_P.Pulses) * mIO_P.Pulses;
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
    mIO_B.MultiportSwitch = mIO_B.Quantizer3;
    break;

   case 5:
    mIO_B.MultiportSwitch = mIO_B.Quantizer1;
    break;

   default:
    mIO_B.MultiportSwitch = mIO_B.Quantizer2;
    break;
  }

  /* End of MultiPortSwitch: '<Root>/Multiport Switch' */

  /* Gain: '<Root>/Gain' */
  mIO_B.Gain = mIO_P.Gain_Gain * mIO_B.MultiportSwitch;

  /* Saturate: '<S6>/Saturation' */
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

  /* End of Saturate: '<S6>/Saturation' */

  /* Gain: '<S6>/pwm_skalning' */
  mIO_B.pwm_skalning = mIO_P.pwm_skalning_Gain * mIO_B.Saturation_n;

  /* Sum: '<S6>/Sum' incorporates:
   *  Constant: '<S6>/pwm_offstet'
   */
  mIO_B.Sum_k = mIO_B.pwm_skalning + mIO_P.pwm_offstet_Value;
  if (rtmIsMajorTimeStep(mIO_M)) {
    /* S-Function (rti_commonblock): '<S10>/S-Function1' */
    /* This comment workarounds a code generation problem */

    /* dSPACE I/O Board DS1104 #1 Unit:PWM Group:PWM */
    ds1104_slave_dsp_pwm_duty_write(0, rti_slv1104_fcn_index[6], mIO_B.Sum_k);

    /* S-Function (rti_commonblock): '<S10>/S-Function2' */
    /* This comment workarounds a code generation problem */

    /* S-Function (rti_commonblock): '<S10>/S-Function3' */
    /* This comment workarounds a code generation problem */

    /* S-Function (rti_commonblock): '<S10>/S-Function4' */
    /* This comment workarounds a code generation problem */

    /* DataTypeConversion: '<S6>/Data Type Conversion' incorporates:
     *  Constant: '<S6>/Enable[1_Off, 0_On]'
     */
    mIO_B.DataTypeConversion = (mIO_P.Enable1_Off0_On_Value != 0.0);

    /* S-Function (rti_commonblock): '<S9>/S-Function1' */
    /* This comment workarounds a code generation problem */

    /* dSPACE I/O Board DS1104 #1 Unit:BIT_IO Group:BIT_OUT */
    if (mIO_B.DataTypeConversion > 0) {
      ds1104_bit_io_set(DS1104_DIO0);
    } else {
      ds1104_bit_io_clear(DS1104_DIO0);
    }
  }

  /* Gain: '<S2>/Gain2' */
  mIO_B.Gain2 = mIO_P.Gain2_Gain * mIO_B.MultiportSwitch;

  /* Gain: '<S2>/eps_dm' */
  mIO_B.eps_dm = mIO_P.eps_dm * mIO_B.Integrator1;

  /* Gain: '<S2>/Friction' */
  mIO_B.Friction = mIO_P.dm * mIO_B.eps_dm;

  /* Gain: '<S2>/Gain4' */
  mIO_B.Gain4 = mIO_P.Gain4_Gain * mIO_B.Integrator1;

  /* Sum: '<S2>/Sum2' */
  mIO_B.Sum2_g = mIO_B.Friction + mIO_B.Gain4;

  /* Sum: '<S2>/Sum1' */
  mIO_B.Sum1_a = mIO_B.Gain2 - mIO_B.Sum2_g;
  if (rtmIsMajorTimeStep(mIO_M)) {
    /* Gain: '<S2>/eps_Jeq' incorporates:
     *  Constant: '<S2>/Jeq'
     */
    mIO_B.eps_Jeq = mIO_P.eps_Jeq * mIO_P.Jeq;
  }

  /* Product: '<S2>/Divide' */
  mIO_B.Divide = mIO_B.Sum1_a / mIO_B.eps_Jeq;
  if (rtmIsMajorTimeStep(mIO_M)) {
    /* Gain: '<S3>/Integral Gain2' */
    mIO_B.IntegralGain2 = mIO_P.IntegralGain2_Gain * mIO_B.Sum1_o;

    /* Gain: '<S4>/Integral Gain' */
    mIO_B.IntegralGain = mIO_P.Ipos * mIO_B.Sum3_o;

    /* Sum: '<S5>/Sum2' */
    mIO_B.Sum2_o = mIO_B.Sum3 - mIO_B.Saturation;

    /* Gain: '<S5>/Anti-Windup' */
    mIO_B.AntiWindup = mIO_P.AntiWindup_Gain * mIO_B.Sum2_o;

    /* Gain: '<S5>/Anti-Windup1' */
    mIO_B.AntiWindup1 = mIO_P.AntiWindup1_Gain * mIO_B.AntiWindup;

    /* Gain: '<S5>/Integral Gain2' */
    mIO_B.IntegralGain2_g = mIO_P.IntegralGain2_Gain_h * mIO_B.Sum2;

    /* Sum: '<S5>/Sum4' */
    mIO_B.Sum4 = mIO_B.IntegralGain2_g - mIO_B.AntiWindup1;

    /* Outputs for Triggered SubSystem: '<S8>/DS1104ENC_SET_POS_C1' incorporates:
     *  TriggerPort: '<S16>/Trigger'
     */
    if (rtmIsMajorTimeStep(mIO_M)) {
      /* Constant: '<S8>/Reset enc' */
      zcEvent = rt_ZCFcn(RISING_ZERO_CROSSING,
                         &mIO_PrevZCX.DS1104ENC_SET_POS_C1_Trig_ZCE,
                         (mIO_P.Resetenc_Value));
      if (zcEvent != NO_ZCEVENT) {
        /* S-Function (rti_commonblock): '<S16>/S-Function1' */
        /* This comment workarounds a code generation problem */

        /* dSPACE I/O Board DS1104 Unit:ENC_SET */
        ds1104_inc_position_write(1, 0, DS1104_INC_LINE_SUBDIV_4);
      }
    }

    /* End of Outputs for SubSystem: '<S8>/DS1104ENC_SET_POS_C1' */

    /* S-Function (rti_commonblock): '<S15>/S-Function1' */
    /* This comment workarounds a code generation problem */

    /* S-Function (rti_commonblock): '<S15>/S-Function2' */
    /* This comment workarounds a code generation problem */
  }
}

/* Model update function */
void mIO_update(void)
{
  if (rtmIsMajorTimeStep(mIO_M)) {
    /* Update for DiscreteIntegrator: '<S5>/Discrete-Time Integrator1' */
    mIO_DW.DiscreteTimeIntegrator1_DSTATE +=
      mIO_P.DiscreteTimeIntegrator1_gainval * mIO_B.FilterGain1;

    /* Update for DiscreteIntegrator: '<S5>/Discrete-Time Integrator2' */
    mIO_DW.DiscreteTimeIntegrator2_DSTATE +=
      mIO_P.DiscreteTimeIntegrator2_gainval * mIO_B.Sum4;

    /* Update for DiscreteIntegrator: '<S3>/Discrete-Time Integrator1' */
    mIO_DW.DiscreteTimeIntegrator1_DSTAT_l +=
      mIO_P.DiscreteTimeIntegrator1_gainv_h * mIO_B.FilterGain1_i;

    /* Update for DiscreteIntegrator: '<S3>/Discrete-Time Integrator2' */
    mIO_DW.DiscreteTimeIntegrator2_DSTAT_k +=
      mIO_P.DiscreteTimeIntegrator2_gainv_d * mIO_B.IntegralGain2;

    /* Update for UnitDelay: '<S1>/UD' */
    mIO_DW.UD_DSTATE = mIO_B.TSamp;
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
    /* Update absolute timer for sample time: [0.01s, 0.0s] */
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

  /* Derivatives for Integrator: '<S2>/Integrator1' */
  _rtXdot->Integrator1_CSTATE = mIO_B.Divide;

  /* Derivatives for Integrator: '<S2>/Integrator2' */
  _rtXdot->Integrator2_CSTATE = mIO_B.Integrator1;

  /* Derivatives for Integrator: '<S4>/Integrator' */
  _rtXdot->Integrator_CSTATE = mIO_B.IntegralGain;

  /* Derivatives for Integrator: '<S4>/Integrator1' */
  _rtXdot->Integrator1_CSTATE_n = mIO_B.FilterGain;
}

/* Model initialize function */
void mIO_initialize(void)
{
  /* Start for S-Function (rti_commonblock): '<S10>/S-Function1' */

  /* dSPACE I/O Board DS1104 #1 Unit:PWM Group:PWM */
  mIO_DW.SFunction1_IWORK[0] = 0;
  mIO_PrevZCX.DS1104ENC_SET_POS_C1_Trig_ZCE = UNINITIALIZED_ZCSIG;

  /* InitializeConditions for Integrator: '<S2>/Integrator1' */
  mIO_X.Integrator1_CSTATE = mIO_P.Integrator1_IC;

  /* InitializeConditions for Integrator: '<S2>/Integrator2' */
  mIO_X.Integrator2_CSTATE = mIO_P.Integrator2_IC;

  /* InitializeConditions for DiscreteIntegrator: '<S5>/Discrete-Time Integrator1' */
  mIO_DW.DiscreteTimeIntegrator1_DSTATE = mIO_P.DiscreteTimeIntegrator1_IC;

  /* InitializeConditions for DiscreteIntegrator: '<S5>/Discrete-Time Integrator2' */
  mIO_DW.DiscreteTimeIntegrator2_DSTATE = mIO_P.DiscreteTimeIntegrator2_IC;

  /* InitializeConditions for DiscreteIntegrator: '<S3>/Discrete-Time Integrator1' */
  mIO_DW.DiscreteTimeIntegrator1_DSTAT_l = mIO_P.DiscreteTimeIntegrator1_IC_a;

  /* InitializeConditions for DiscreteIntegrator: '<S3>/Discrete-Time Integrator2' */
  mIO_DW.DiscreteTimeIntegrator2_DSTAT_k = mIO_P.DiscreteTimeIntegrator2_IC_o;

  /* InitializeConditions for UnitDelay: '<S1>/UD' */
  mIO_DW.UD_DSTATE = mIO_P.UD_InitialCondition;

  /* InitializeConditions for Integrator: '<S4>/Integrator' */
  mIO_X.Integrator_CSTATE = mIO_P.Integrator_IC;

  /* InitializeConditions for Integrator: '<S4>/Integrator1' */
  mIO_X.Integrator1_CSTATE_n = mIO_P.Integrator1_IC_p;
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
    mIO_M->Timing.sampleTimes[1] = (0.01);

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
  mIO_M->Timing.stepSize0 = 0.01;
  mIO_M->Timing.stepSize1 = 0.01;
  mIO_M->solverInfoPtr = (&mIO_M->solverInfo);
  mIO_M->Timing.stepSize = (0.01);
  rtsiSetFixedStepSize(&mIO_M->solverInfo, 0.01);
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
    mIO_B.Quantizer3 = 0.0;
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
    mIO_B.Quantizer1 = 0.0;
    mIO_B.ZOH2 = 0.0;
    mIO_B.Quantizer = 0.0;
    mIO_B.ZOH = 0.0;
    mIO_B.TSamp = 0.0;
    mIO_B.Uk1 = 0.0;
    mIO_B.Diff = 0.0;
    mIO_B.Sum3_o = 0.0;
    mIO_B.ProportionalGain = 0.0;
    mIO_B.Integrator = 0.0;
    mIO_B.DerivativeGain = 0.0;
    mIO_B.Integrator1_l = 0.0;
    mIO_B.Sum = 0.0;
    mIO_B.FilterGain = 0.0;
    mIO_B.Sum1_ec = 0.0;
    mIO_B.Saturation_a = 0.0;
    mIO_B.Quantizer2 = 0.0;
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
    mIO_B.IntegralGain2 = 0.0;
    mIO_B.IntegralGain = 0.0;
    mIO_B.Sum2_o = 0.0;
    mIO_B.AntiWindup = 0.0;
    mIO_B.AntiWindup1 = 0.0;
    mIO_B.IntegralGain2_g = 0.0;
    mIO_B.Sum4 = 0.0;
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
  mIO_DW.UD_DSTATE = 0.0;

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
  mIO_M->Sizes.numContStates = (4);    /* Number of continuous states */
  mIO_M->Sizes.numY = (2);             /* Number of model outputs */
  mIO_M->Sizes.numU = (0);             /* Number of model inputs */
  mIO_M->Sizes.sysDirFeedThru = (0);   /* The model is not direct feedthrough */
  mIO_M->Sizes.numSampTimes = (2);     /* Number of sample times */
  mIO_M->Sizes.numBlocks = (95);       /* Number of blocks */
  mIO_M->Sizes.numBlockIO = (77);      /* Number of block outputs */
  mIO_M->Sizes.numBlockPrms = (71);    /* Sum of parameter "widths" */
  return mIO_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
