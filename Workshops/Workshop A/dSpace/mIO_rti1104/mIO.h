/*
 * mIO.h
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
#ifndef RTW_HEADER_mIO_h_
#define RTW_HEADER_mIO_h_
#include <math.h>
#include <string.h>
#ifndef mIO_COMMON_INCLUDES_
# define mIO_COMMON_INCLUDES_
#include <brtenv.h>
#include <rtkernel.h>
#include <rti_assert.h>
#include <rtidefineddatatypes.h>
#include <def1104.h>
#include <slvdsp1104.h>
#include <rti_slv1104.h>
#include "rtwtypes.h"
#include "simstruc.h"
#include "fixedpoint.h"
#endif                                 /* mIO_COMMON_INCLUDES_ */

#include "mIO_types.h"

/* Shared type includes */
#include "multiword_types.h"
#include "rt_zcfcn.h"
#include "rt_defines.h"
#include "rt_nonfinite.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetBlkStateChangeFlag
# define rtmGetBlkStateChangeFlag(rtm) ((rtm)->ModelData.blkStateChange)
#endif

#ifndef rtmSetBlkStateChangeFlag
# define rtmSetBlkStateChangeFlag(rtm, val) ((rtm)->ModelData.blkStateChange = (val))
#endif

#ifndef rtmGetBlockIO
# define rtmGetBlockIO(rtm)            ((rtm)->ModelData.blockIO)
#endif

#ifndef rtmSetBlockIO
# define rtmSetBlockIO(rtm, val)       ((rtm)->ModelData.blockIO = (val))
#endif

#ifndef rtmGetChecksums
# define rtmGetChecksums(rtm)          ((rtm)->Sizes.checksums)
#endif

#ifndef rtmSetChecksums
# define rtmSetChecksums(rtm, val)     ((rtm)->Sizes.checksums = (val))
#endif

#ifndef rtmGetConstBlockIO
# define rtmGetConstBlockIO(rtm)       ((rtm)->ModelData.constBlockIO)
#endif

#ifndef rtmSetConstBlockIO
# define rtmSetConstBlockIO(rtm, val)  ((rtm)->ModelData.constBlockIO = (val))
#endif

#ifndef rtmGetContStateDisabled
# define rtmGetContStateDisabled(rtm)  ((rtm)->ModelData.contStateDisabled)
#endif

#ifndef rtmSetContStateDisabled
# define rtmSetContStateDisabled(rtm, val) ((rtm)->ModelData.contStateDisabled = (val))
#endif

#ifndef rtmGetContStates
# define rtmGetContStates(rtm)         ((rtm)->ModelData.contStates)
#endif

#ifndef rtmSetContStates
# define rtmSetContStates(rtm, val)    ((rtm)->ModelData.contStates = (val))
#endif

#ifndef rtmGetDataMapInfo
# define rtmGetDataMapInfo(rtm)        ()
#endif

#ifndef rtmSetDataMapInfo
# define rtmSetDataMapInfo(rtm, val)   ()
#endif

#ifndef rtmGetDefaultParam
# define rtmGetDefaultParam(rtm)       ((rtm)->ModelData.defaultParam)
#endif

#ifndef rtmSetDefaultParam
# define rtmSetDefaultParam(rtm, val)  ((rtm)->ModelData.defaultParam = (val))
#endif

#ifndef rtmGetDerivCacheNeedsReset
# define rtmGetDerivCacheNeedsReset(rtm) ((rtm)->ModelData.derivCacheNeedsReset)
#endif

#ifndef rtmSetDerivCacheNeedsReset
# define rtmSetDerivCacheNeedsReset(rtm, val) ((rtm)->ModelData.derivCacheNeedsReset = (val))
#endif

#ifndef rtmGetDirectFeedThrough
# define rtmGetDirectFeedThrough(rtm)  ((rtm)->Sizes.sysDirFeedThru)
#endif

#ifndef rtmSetDirectFeedThrough
# define rtmSetDirectFeedThrough(rtm, val) ((rtm)->Sizes.sysDirFeedThru = (val))
#endif

#ifndef rtmGetErrorStatusFlag
# define rtmGetErrorStatusFlag(rtm)    ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatusFlag
# define rtmSetErrorStatusFlag(rtm, val) ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetFinalTime
# define rtmGetFinalTime(rtm)          ((rtm)->Timing.tFinal)
#endif

#ifndef rtmSetFinalTime
# define rtmSetFinalTime(rtm, val)     ((rtm)->Timing.tFinal = (val))
#endif

#ifndef rtmGetFirstInitCondFlag
# define rtmGetFirstInitCondFlag(rtm)  ()
#endif

#ifndef rtmSetFirstInitCondFlag
# define rtmSetFirstInitCondFlag(rtm, val) ()
#endif

#ifndef rtmGetIntgData
# define rtmGetIntgData(rtm)           ((rtm)->ModelData.intgData)
#endif

#ifndef rtmSetIntgData
# define rtmSetIntgData(rtm, val)      ((rtm)->ModelData.intgData = (val))
#endif

#ifndef rtmGetMdlRefGlobalTID
# define rtmGetMdlRefGlobalTID(rtm)    ()
#endif

#ifndef rtmSetMdlRefGlobalTID
# define rtmSetMdlRefGlobalTID(rtm, val) ()
#endif

#ifndef rtmGetMdlRefTriggerTID
# define rtmGetMdlRefTriggerTID(rtm)   ()
#endif

#ifndef rtmSetMdlRefTriggerTID
# define rtmSetMdlRefTriggerTID(rtm, val) ()
#endif

#ifndef rtmGetModelMappingInfo
# define rtmGetModelMappingInfo(rtm)   ((rtm)->SpecialInfo.mappingInfo)
#endif

#ifndef rtmSetModelMappingInfo
# define rtmSetModelMappingInfo(rtm, val) ((rtm)->SpecialInfo.mappingInfo = (val))
#endif

#ifndef rtmGetModelName
# define rtmGetModelName(rtm)          ((rtm)->modelName)
#endif

#ifndef rtmSetModelName
# define rtmSetModelName(rtm, val)     ((rtm)->modelName = (val))
#endif

#ifndef rtmGetNonInlinedSFcns
# define rtmGetNonInlinedSFcns(rtm)    ()
#endif

#ifndef rtmSetNonInlinedSFcns
# define rtmSetNonInlinedSFcns(rtm, val) ()
#endif

#ifndef rtmGetNumBlockIO
# define rtmGetNumBlockIO(rtm)         ((rtm)->Sizes.numBlockIO)
#endif

#ifndef rtmSetNumBlockIO
# define rtmSetNumBlockIO(rtm, val)    ((rtm)->Sizes.numBlockIO = (val))
#endif

#ifndef rtmGetNumBlockParams
# define rtmGetNumBlockParams(rtm)     ((rtm)->Sizes.numBlockPrms)
#endif

#ifndef rtmSetNumBlockParams
# define rtmSetNumBlockParams(rtm, val) ((rtm)->Sizes.numBlockPrms = (val))
#endif

#ifndef rtmGetNumBlocks
# define rtmGetNumBlocks(rtm)          ((rtm)->Sizes.numBlocks)
#endif

#ifndef rtmSetNumBlocks
# define rtmSetNumBlocks(rtm, val)     ((rtm)->Sizes.numBlocks = (val))
#endif

#ifndef rtmGetNumContStates
# define rtmGetNumContStates(rtm)      ((rtm)->Sizes.numContStates)
#endif

#ifndef rtmSetNumContStates
# define rtmSetNumContStates(rtm, val) ((rtm)->Sizes.numContStates = (val))
#endif

#ifndef rtmGetNumDWork
# define rtmGetNumDWork(rtm)           ((rtm)->Sizes.numDwork)
#endif

#ifndef rtmSetNumDWork
# define rtmSetNumDWork(rtm, val)      ((rtm)->Sizes.numDwork = (val))
#endif

#ifndef rtmGetNumInputPorts
# define rtmGetNumInputPorts(rtm)      ((rtm)->Sizes.numIports)
#endif

#ifndef rtmSetNumInputPorts
# define rtmSetNumInputPorts(rtm, val) ((rtm)->Sizes.numIports = (val))
#endif

#ifndef rtmGetNumNonSampledZCs
# define rtmGetNumNonSampledZCs(rtm)   ((rtm)->Sizes.numNonSampZCs)
#endif

#ifndef rtmSetNumNonSampledZCs
# define rtmSetNumNonSampledZCs(rtm, val) ((rtm)->Sizes.numNonSampZCs = (val))
#endif

#ifndef rtmGetNumOutputPorts
# define rtmGetNumOutputPorts(rtm)     ((rtm)->Sizes.numOports)
#endif

#ifndef rtmSetNumOutputPorts
# define rtmSetNumOutputPorts(rtm, val) ((rtm)->Sizes.numOports = (val))
#endif

#ifndef rtmGetNumSFcnParams
# define rtmGetNumSFcnParams(rtm)      ((rtm)->Sizes.numSFcnPrms)
#endif

#ifndef rtmSetNumSFcnParams
# define rtmSetNumSFcnParams(rtm, val) ((rtm)->Sizes.numSFcnPrms = (val))
#endif

#ifndef rtmGetNumSFunctions
# define rtmGetNumSFunctions(rtm)      ((rtm)->Sizes.numSFcns)
#endif

#ifndef rtmSetNumSFunctions
# define rtmSetNumSFunctions(rtm, val) ((rtm)->Sizes.numSFcns = (val))
#endif

#ifndef rtmGetNumSampleTimes
# define rtmGetNumSampleTimes(rtm)     ((rtm)->Sizes.numSampTimes)
#endif

#ifndef rtmSetNumSampleTimes
# define rtmSetNumSampleTimes(rtm, val) ((rtm)->Sizes.numSampTimes = (val))
#endif

#ifndef rtmGetNumU
# define rtmGetNumU(rtm)               ((rtm)->Sizes.numU)
#endif

#ifndef rtmSetNumU
# define rtmSetNumU(rtm, val)          ((rtm)->Sizes.numU = (val))
#endif

#ifndef rtmGetNumY
# define rtmGetNumY(rtm)               ((rtm)->Sizes.numY)
#endif

#ifndef rtmSetNumY
# define rtmSetNumY(rtm, val)          ((rtm)->Sizes.numY = (val))
#endif

#ifndef rtmGetOdeF
# define rtmGetOdeF(rtm)               ((rtm)->ModelData.odeF)
#endif

#ifndef rtmSetOdeF
# define rtmSetOdeF(rtm, val)          ((rtm)->ModelData.odeF = (val))
#endif

#ifndef rtmGetOdeY
# define rtmGetOdeY(rtm)               ()
#endif

#ifndef rtmSetOdeY
# define rtmSetOdeY(rtm, val)          ()
#endif

#ifndef rtmGetOffsetTimeArray
# define rtmGetOffsetTimeArray(rtm)    ((rtm)->Timing.offsetTimesArray)
#endif

#ifndef rtmSetOffsetTimeArray
# define rtmSetOffsetTimeArray(rtm, val) ((rtm)->Timing.offsetTimesArray = (val))
#endif

#ifndef rtmGetOffsetTimePtr
# define rtmGetOffsetTimePtr(rtm)      ((rtm)->Timing.offsetTimes)
#endif

#ifndef rtmSetOffsetTimePtr
# define rtmSetOffsetTimePtr(rtm, val) ((rtm)->Timing.offsetTimes = (val))
#endif

#ifndef rtmGetOptions
# define rtmGetOptions(rtm)            ((rtm)->Sizes.options)
#endif

#ifndef rtmSetOptions
# define rtmSetOptions(rtm, val)       ((rtm)->Sizes.options = (val))
#endif

#ifndef rtmGetParamIsMalloced
# define rtmGetParamIsMalloced(rtm)    ()
#endif

#ifndef rtmSetParamIsMalloced
# define rtmSetParamIsMalloced(rtm, val) ()
#endif

#ifndef rtmGetPath
# define rtmGetPath(rtm)               ((rtm)->path)
#endif

#ifndef rtmSetPath
# define rtmSetPath(rtm, val)          ((rtm)->path = (val))
#endif

#ifndef rtmGetPerTaskSampleHits
# define rtmGetPerTaskSampleHits(rtm)  ()
#endif

#ifndef rtmSetPerTaskSampleHits
# define rtmSetPerTaskSampleHits(rtm, val) ()
#endif

#ifndef rtmGetPerTaskSampleHitsArray
# define rtmGetPerTaskSampleHitsArray(rtm) ((rtm)->Timing.perTaskSampleHitsArray)
#endif

#ifndef rtmSetPerTaskSampleHitsArray
# define rtmSetPerTaskSampleHitsArray(rtm, val) ((rtm)->Timing.perTaskSampleHitsArray = (val))
#endif

#ifndef rtmGetPerTaskSampleHitsPtr
# define rtmGetPerTaskSampleHitsPtr(rtm) ((rtm)->Timing.perTaskSampleHits)
#endif

#ifndef rtmSetPerTaskSampleHitsPtr
# define rtmSetPerTaskSampleHitsPtr(rtm, val) ((rtm)->Timing.perTaskSampleHits = (val))
#endif

#ifndef rtmGetPrevZCSigState
# define rtmGetPrevZCSigState(rtm)     ((rtm)->ModelData.prevZCSigState)
#endif

#ifndef rtmSetPrevZCSigState
# define rtmSetPrevZCSigState(rtm, val) ((rtm)->ModelData.prevZCSigState = (val))
#endif

#ifndef rtmGetRTWExtModeInfo
# define rtmGetRTWExtModeInfo(rtm)     ((rtm)->extModeInfo)
#endif

#ifndef rtmSetRTWExtModeInfo
# define rtmSetRTWExtModeInfo(rtm, val) ((rtm)->extModeInfo = (val))
#endif

#ifndef rtmGetRTWGeneratedSFcn
# define rtmGetRTWGeneratedSFcn(rtm)   ((rtm)->Sizes.rtwGenSfcn)
#endif

#ifndef rtmSetRTWGeneratedSFcn
# define rtmSetRTWGeneratedSFcn(rtm, val) ((rtm)->Sizes.rtwGenSfcn = (val))
#endif

#ifndef rtmGetRTWLogInfo
# define rtmGetRTWLogInfo(rtm)         ()
#endif

#ifndef rtmSetRTWLogInfo
# define rtmSetRTWLogInfo(rtm, val)    ()
#endif

#ifndef rtmGetRTWRTModelMethodsInfo
# define rtmGetRTWRTModelMethodsInfo(rtm) ()
#endif

#ifndef rtmSetRTWRTModelMethodsInfo
# define rtmSetRTWRTModelMethodsInfo(rtm, val) ()
#endif

#ifndef rtmGetRTWSfcnInfo
# define rtmGetRTWSfcnInfo(rtm)        ((rtm)->sfcnInfo)
#endif

#ifndef rtmSetRTWSfcnInfo
# define rtmSetRTWSfcnInfo(rtm, val)   ((rtm)->sfcnInfo = (val))
#endif

#ifndef rtmGetRTWSolverInfo
# define rtmGetRTWSolverInfo(rtm)      ((rtm)->solverInfo)
#endif

#ifndef rtmSetRTWSolverInfo
# define rtmSetRTWSolverInfo(rtm, val) ((rtm)->solverInfo = (val))
#endif

#ifndef rtmGetRTWSolverInfoPtr
# define rtmGetRTWSolverInfoPtr(rtm)   ((rtm)->solverInfoPtr)
#endif

#ifndef rtmSetRTWSolverInfoPtr
# define rtmSetRTWSolverInfoPtr(rtm, val) ((rtm)->solverInfoPtr = (val))
#endif

#ifndef rtmGetReservedForXPC
# define rtmGetReservedForXPC(rtm)     ((rtm)->SpecialInfo.xpcData)
#endif

#ifndef rtmSetReservedForXPC
# define rtmSetReservedForXPC(rtm, val) ((rtm)->SpecialInfo.xpcData = (val))
#endif

#ifndef rtmGetRootDWork
# define rtmGetRootDWork(rtm)          ((rtm)->ModelData.dwork)
#endif

#ifndef rtmSetRootDWork
# define rtmSetRootDWork(rtm, val)     ((rtm)->ModelData.dwork = (val))
#endif

#ifndef rtmGetSFunctions
# define rtmGetSFunctions(rtm)         ((rtm)->childSfunctions)
#endif

#ifndef rtmSetSFunctions
# define rtmSetSFunctions(rtm, val)    ((rtm)->childSfunctions = (val))
#endif

#ifndef rtmGetSampleHitArray
# define rtmGetSampleHitArray(rtm)     ((rtm)->Timing.sampleHitArray)
#endif

#ifndef rtmSetSampleHitArray
# define rtmSetSampleHitArray(rtm, val) ((rtm)->Timing.sampleHitArray = (val))
#endif

#ifndef rtmGetSampleHitPtr
# define rtmGetSampleHitPtr(rtm)       ((rtm)->Timing.sampleHits)
#endif

#ifndef rtmSetSampleHitPtr
# define rtmSetSampleHitPtr(rtm, val)  ((rtm)->Timing.sampleHits = (val))
#endif

#ifndef rtmGetSampleTimeArray
# define rtmGetSampleTimeArray(rtm)    ((rtm)->Timing.sampleTimesArray)
#endif

#ifndef rtmSetSampleTimeArray
# define rtmSetSampleTimeArray(rtm, val) ((rtm)->Timing.sampleTimesArray = (val))
#endif

#ifndef rtmGetSampleTimePtr
# define rtmGetSampleTimePtr(rtm)      ((rtm)->Timing.sampleTimes)
#endif

#ifndef rtmSetSampleTimePtr
# define rtmSetSampleTimePtr(rtm, val) ((rtm)->Timing.sampleTimes = (val))
#endif

#ifndef rtmGetSampleTimeTaskIDArray
# define rtmGetSampleTimeTaskIDArray(rtm) ((rtm)->Timing.sampleTimeTaskIDArray)
#endif

#ifndef rtmSetSampleTimeTaskIDArray
# define rtmSetSampleTimeTaskIDArray(rtm, val) ((rtm)->Timing.sampleTimeTaskIDArray = (val))
#endif

#ifndef rtmGetSampleTimeTaskIDPtr
# define rtmGetSampleTimeTaskIDPtr(rtm) ((rtm)->Timing.sampleTimeTaskIDPtr)
#endif

#ifndef rtmSetSampleTimeTaskIDPtr
# define rtmSetSampleTimeTaskIDPtr(rtm, val) ((rtm)->Timing.sampleTimeTaskIDPtr = (val))
#endif

#ifndef rtmGetSimMode
# define rtmGetSimMode(rtm)            ((rtm)->simMode)
#endif

#ifndef rtmSetSimMode
# define rtmSetSimMode(rtm, val)       ((rtm)->simMode = (val))
#endif

#ifndef rtmGetSimTimeStep
# define rtmGetSimTimeStep(rtm)        ((rtm)->Timing.simTimeStep)
#endif

#ifndef rtmSetSimTimeStep
# define rtmSetSimTimeStep(rtm, val)   ((rtm)->Timing.simTimeStep = (val))
#endif

#ifndef rtmGetStartTime
# define rtmGetStartTime(rtm)          ((rtm)->Timing.tStart)
#endif

#ifndef rtmSetStartTime
# define rtmSetStartTime(rtm, val)     ((rtm)->Timing.tStart = (val))
#endif

#ifndef rtmGetStepSize
# define rtmGetStepSize(rtm)           ((rtm)->Timing.stepSize)
#endif

#ifndef rtmSetStepSize
# define rtmSetStepSize(rtm, val)      ((rtm)->Timing.stepSize = (val))
#endif

#ifndef rtmGetStopRequestedFlag
# define rtmGetStopRequestedFlag(rtm)  ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequestedFlag
# define rtmSetStopRequestedFlag(rtm, val) ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetTaskCounters
# define rtmGetTaskCounters(rtm)       ()
#endif

#ifndef rtmSetTaskCounters
# define rtmSetTaskCounters(rtm, val)  ()
#endif

#ifndef rtmGetTaskTimeArray
# define rtmGetTaskTimeArray(rtm)      ((rtm)->Timing.tArray)
#endif

#ifndef rtmSetTaskTimeArray
# define rtmSetTaskTimeArray(rtm, val) ((rtm)->Timing.tArray = (val))
#endif

#ifndef rtmGetTimePtr
# define rtmGetTimePtr(rtm)            ((rtm)->Timing.t)
#endif

#ifndef rtmSetTimePtr
# define rtmSetTimePtr(rtm, val)       ((rtm)->Timing.t = (val))
#endif

#ifndef rtmGetTimingData
# define rtmGetTimingData(rtm)         ((rtm)->Timing.timingData)
#endif

#ifndef rtmSetTimingData
# define rtmSetTimingData(rtm, val)    ((rtm)->Timing.timingData = (val))
#endif

#ifndef rtmGetU
# define rtmGetU(rtm)                  ((rtm)->ModelData.inputs)
#endif

#ifndef rtmSetU
# define rtmSetU(rtm, val)             ((rtm)->ModelData.inputs = (val))
#endif

#ifndef rtmGetVarNextHitTimesListPtr
# define rtmGetVarNextHitTimesListPtr(rtm) ((rtm)->Timing.varNextHitTimesList)
#endif

#ifndef rtmSetVarNextHitTimesListPtr
# define rtmSetVarNextHitTimesListPtr(rtm, val) ((rtm)->Timing.varNextHitTimesList = (val))
#endif

#ifndef rtmGetY
# define rtmGetY(rtm)                  ((rtm)->ModelData.outputs)
#endif

#ifndef rtmSetY
# define rtmSetY(rtm, val)             ((rtm)->ModelData.outputs = (val))
#endif

#ifndef rtmGetZCCacheNeedsReset
# define rtmGetZCCacheNeedsReset(rtm)  ((rtm)->ModelData.zCCacheNeedsReset)
#endif

#ifndef rtmSetZCCacheNeedsReset
# define rtmSetZCCacheNeedsReset(rtm, val) ((rtm)->ModelData.zCCacheNeedsReset = (val))
#endif

#ifndef rtmGetZCSignalValues
# define rtmGetZCSignalValues(rtm)     ((rtm)->ModelData.zcSignalValues)
#endif

#ifndef rtmSetZCSignalValues
# define rtmSetZCSignalValues(rtm, val) ((rtm)->ModelData.zcSignalValues = (val))
#endif

#ifndef rtmGet_TimeOfLastOutput
# define rtmGet_TimeOfLastOutput(rtm)  ((rtm)->Timing.timeOfLastOutput)
#endif

#ifndef rtmSet_TimeOfLastOutput
# define rtmSet_TimeOfLastOutput(rtm, val) ((rtm)->Timing.timeOfLastOutput = (val))
#endif

#ifndef rtmGetdX
# define rtmGetdX(rtm)                 ((rtm)->ModelData.derivs)
#endif

#ifndef rtmSetdX
# define rtmSetdX(rtm, val)            ((rtm)->ModelData.derivs = (val))
#endif

#ifndef rtmGetChecksumVal
# define rtmGetChecksumVal(rtm, idx)   ((rtm)->Sizes.checksums[idx])
#endif

#ifndef rtmSetChecksumVal
# define rtmSetChecksumVal(rtm, idx, val) ((rtm)->Sizes.checksums[idx] = (val))
#endif

#ifndef rtmGetDWork
# define rtmGetDWork(rtm, idx)         ((rtm)->ModelData.dwork[idx])
#endif

#ifndef rtmSetDWork
# define rtmSetDWork(rtm, idx, val)    ((rtm)->ModelData.dwork[idx] = (val))
#endif

#ifndef rtmGetOffsetTime
# define rtmGetOffsetTime(rtm, idx)    ((rtm)->Timing.offsetTimes[idx])
#endif

#ifndef rtmSetOffsetTime
# define rtmSetOffsetTime(rtm, idx, val) ((rtm)->Timing.offsetTimes[idx] = (val))
#endif

#ifndef rtmGetSFunction
# define rtmGetSFunction(rtm, idx)     ((rtm)->childSfunctions[idx])
#endif

#ifndef rtmSetSFunction
# define rtmSetSFunction(rtm, idx, val) ((rtm)->childSfunctions[idx] = (val))
#endif

#ifndef rtmGetSampleTime
# define rtmGetSampleTime(rtm, idx)    ((rtm)->Timing.sampleTimes[idx])
#endif

#ifndef rtmSetSampleTime
# define rtmSetSampleTime(rtm, idx, val) ((rtm)->Timing.sampleTimes[idx] = (val))
#endif

#ifndef rtmGetSampleTimeTaskID
# define rtmGetSampleTimeTaskID(rtm, idx) ((rtm)->Timing.sampleTimeTaskIDPtr[idx])
#endif

#ifndef rtmSetSampleTimeTaskID
# define rtmSetSampleTimeTaskID(rtm, idx, val) ((rtm)->Timing.sampleTimeTaskIDPtr[idx] = (val))
#endif

#ifndef rtmGetVarNextHitTimeList
# define rtmGetVarNextHitTimeList(rtm, idx) ((rtm)->Timing.varNextHitTimesList[idx])
#endif

#ifndef rtmSetVarNextHitTimeList
# define rtmSetVarNextHitTimeList(rtm, idx, val) ((rtm)->Timing.varNextHitTimesList[idx] = (val))
#endif

#ifndef rtmIsContinuousTask
# define rtmIsContinuousTask(rtm, tid) ((tid) == 0)
#endif

#ifndef rtmGetErrorStatus
# define rtmGetErrorStatus(rtm)        ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
# define rtmSetErrorStatus(rtm, val)   ((rtm)->errorStatus = (val))
#endif

#ifndef rtmIsMajorTimeStep
# define rtmIsMajorTimeStep(rtm)       (((rtm)->Timing.simTimeStep) == MAJOR_TIME_STEP)
#endif

#ifndef rtmIsMinorTimeStep
# define rtmIsMinorTimeStep(rtm)       (((rtm)->Timing.simTimeStep) == MINOR_TIME_STEP)
#endif

#ifndef rtmIsSampleHit
# define rtmIsSampleHit(rtm, sti, tid) ((rtmIsMajorTimeStep((rtm)) && (rtm)->Timing.sampleHits[(rtm)->Timing.sampleTimeTaskIDPtr[sti]]))
#endif

#ifndef rtmGetStopRequested
# define rtmGetStopRequested(rtm)      ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
# define rtmSetStopRequested(rtm, val) ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
# define rtmGetStopRequestedPtr(rtm)   (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
# define rtmGetT(rtm)                  (rtmGetTPtr((rtm))[0])
#endif

#ifndef rtmSetT
# define rtmSetT(rtm, val)                                       /* Do Nothing */
#endif

#ifndef rtmGetTFinal
# define rtmGetTFinal(rtm)             ((rtm)->Timing.tFinal)
#endif

#ifndef rtmSetTFinal
# define rtmSetTFinal(rtm, val)        ((rtm)->Timing.tFinal = (val))
#endif

#ifndef rtmGetTPtr
# define rtmGetTPtr(rtm)               ((rtm)->Timing.t)
#endif

#ifndef rtmSetTPtr
# define rtmSetTPtr(rtm, val)          ((rtm)->Timing.t = (val))
#endif

#ifndef rtmGetTStart
# define rtmGetTStart(rtm)             ((rtm)->Timing.tStart)
#endif

#ifndef rtmSetTStart
# define rtmSetTStart(rtm, val)        ((rtm)->Timing.tStart = (val))
#endif

#ifndef rtmGetTaskTime
# define rtmGetTaskTime(rtm, sti)      (rtmGetTPtr((rtm))[(rtm)->Timing.sampleTimeTaskIDPtr[sti]])
#endif

#ifndef rtmSetTaskTime
# define rtmSetTaskTime(rtm, sti, val) (rtmGetTPtr((rtm))[sti] = (val))
#endif

#ifndef rtmGetTimeOfLastOutput
# define rtmGetTimeOfLastOutput(rtm)   ((rtm)->Timing.timeOfLastOutput)
#endif

#ifdef rtmGetRTWSolverInfo
#undef rtmGetRTWSolverInfo
#endif

#define rtmGetRTWSolverInfo(rtm)       &((rtm)->solverInfo)

/* Definition for use in the target main file */
#define mIO_rtModel                    RT_MODEL_mIO_T

/* Block signals (auto storage) */
typedef struct {
  real_T Integrator3;                  /* '<S1>/Integrator3' */
  real_T Gain10;                       /* '<S1>/Gain10' */
  real_T Integrator1;                  /* '<S2>/Integrator1' */
  real_T Gain7;                        /* '<S2>/Gain7' */
  real_T MultiportSwitch3;             /* '<Root>/Multiport Switch3' */
  real_T Integrator4;                  /* '<S1>/Integrator4' */
  real_T Gain9;                        /* '<S1>/Gain9' */
  real_T Integrator2;                  /* '<S2>/Integrator2' */
  real_T Gain6;                        /* '<S2>/Gain6' */
  real_T MultiportSwitch2;             /* '<Root>/Multiport Switch2' */
  real_T CtrlSine;                     /* '<Root>/Ctrl. Sine' */
  real_T CtrlSquare;                   /* '<Root>/Ctrl. Square' */
  real_T CtrlStep;                     /* '<Root>/Ctrl. Step' */
  real_T VelRefStep;                   /* '<Root>/Vel.Ref. Step' */
  real_T VelRefSine;                   /* '<Root>/Vel.Ref. Sine' */
  real_T VelRefSquare;                 /* '<Root>/Vel.Ref. Square' */
  real_T MultiportSwitch1;             /* '<Root>/Multiport Switch1' */
  real_T ZOH3;                         /* '<Root>/ZOH3' */
  real_T SFunction2;                   /* '<S15>/S-Function2' */
  real_T w1_scaling;                   /* '<S8>/w1_scaling' */
  real_T Sum2;                         /* '<Root>/Sum2' */
  real_T ProportionalGain1;            /* '<S5>/Proportional Gain1' */
  real_T DerivativeGain2;              /* '<S5>/Derivative Gain2' */
  real_T DiscreteTimeIntegrator1;      /* '<S5>/Discrete-Time Integrator1' */
  real_T Sum1;                         /* '<S5>/Sum1' */
  real_T FilterGain1;                  /* '<S5>/Filter Gain1' */
  real_T Add2;                         /* '<S5>/Add2' */
  real_T DiscreteTimeIntegrator2;      /* '<S5>/Discrete-Time Integrator2' */
  real_T Sum3;                         /* '<S5>/Sum3' */
  real_T Saturation;                   /* '<S5>/Saturation' */
  real_T Pos;                          /* '<Root>/Pos' */
  real_T ZOH1;                         /* '<Root>/ZOH1' */
  real_T SFunction1;                   /* '<S15>/S-Function1' */
  real_T fi1_scaling;                  /* '<S8>/fi1_scaling' */
  real_T Sum1_o;                       /* '<Root>/Sum1' */
  real_T ProportionalGain1_c;          /* '<S3>/Proportional Gain1' */
  real_T DerivativeGain2_p;            /* '<S3>/Derivative Gain2' */
  real_T DiscreteTimeIntegrator1_p;    /* '<S3>/Discrete-Time Integrator1' */
  real_T Sum1_e;                       /* '<S3>/Sum1' */
  real_T FilterGain1_i;                /* '<S3>/Filter Gain1' */
  real_T Add2_a;                       /* '<S3>/Add2' */
  real_T DiscreteTimeIntegrator2_h;    /* '<S3>/Discrete-Time Integrator2' */
  real_T Sum3_a;                       /* '<S3>/Sum3' */
  real_T Saturation_k;                 /* '<S3>/Saturation' */
  real_T ZOH2;                         /* '<Root>/ZOH2' */
  real_T Sum3_o;                       /* '<Root>/Sum3' */
  real_T ProportionalGain;             /* '<S4>/Proportional Gain' */
  real_T DiscreteTimeIntegrator1_pk;   /* '<S4>/Discrete-Time Integrator1' */
  real_T DerivativeGain;               /* '<S4>/Derivative Gain' */
  real_T DiscreteTimeIntegrator2_f;    /* '<S4>/Discrete-Time Integrator2' */
  real_T Sum;                          /* '<S4>/Sum' */
  real_T FilterGain;                   /* '<S4>/Filter Gain' */
  real_T Sum1_ec;                      /* '<S4>/Sum1' */
  real_T Saturation_a;                 /* '<S4>/Saturation' */
  real_T MultiportSwitch;              /* '<Root>/Multiport Switch' */
  real_T Gain;                         /* '<Root>/Gain' */
  real_T Saturation_n;                 /* '<S6>/Saturation' */
  real_T pwm_skalning;                 /* '<S6>/pwm_skalning' */
  real_T Sum_k;                        /* '<S6>/Sum' */
  real_T Gain3;                        /* '<S1>/Gain3' */
  real_T Gain2;                        /* '<S1>/Gain2' */
  real_T Add2_e;                       /* '<S1>/Add2' */
  real_T Add3;                         /* '<S1>/Add3' */
  real_T Gain5;                        /* '<S1>/Gain5' */
  real_T Gain2_i;                      /* '<S2>/Gain2' */
  real_T eps_dm;                       /* '<S2>/eps_dm' */
  real_T Friction;                     /* '<S2>/Friction' */
  real_T Gain4;                        /* '<S2>/Gain4' */
  real_T Sum2_g;                       /* '<S2>/Sum2' */
  real_T Sum1_a;                       /* '<S2>/Sum1' */
  real_T eps_Jeq;                      /* '<S2>/eps_Jeq' */
  real_T Divide;                       /* '<S2>/Divide' */
  real_T Sum2_b;                       /* '<S3>/Sum2' */
  real_T AntiWindup1;                  /* '<S3>/Anti-Windup1' */
  real_T AntiWindup2;                  /* '<S3>/Anti-Windup2' */
  real_T IntegralGain2;                /* '<S3>/Integral Gain2' */
  real_T Sum5;                         /* '<S3>/Sum5' */
  real_T Sum3_b;                       /* '<S4>/Sum3' */
  real_T AntiWindup;                   /* '<S4>/Anti-Windup' */
  real_T AntiWindup1_n;                /* '<S4>/Anti-Windup1' */
  real_T IntegralGain;                 /* '<S4>/Integral Gain' */
  real_T Sum4;                         /* '<S4>/Sum4' */
  real_T Sum2_o;                       /* '<S5>/Sum2' */
  real_T AntiWindup_e;                 /* '<S5>/Anti-Windup' */
  real_T AntiWindup1_k;                /* '<S5>/Anti-Windup1' */
  real_T IntegralGain2_g;              /* '<S5>/Integral Gain2' */
  real_T Sum4_f;                       /* '<S5>/Sum4' */
  real_T Tf;                           /* '<S1>/MATLAB Function' */
  boolean_T DataTypeConversion;        /* '<S6>/Data Type Conversion' */
} B_mIO_T;

/* Block states (auto storage) for system '<Root>' */
typedef struct {
  real_T DiscreteTimeIntegrator1_DSTATE;/* '<S5>/Discrete-Time Integrator1' */
  real_T DiscreteTimeIntegrator2_DSTATE;/* '<S5>/Discrete-Time Integrator2' */
  real_T DiscreteTimeIntegrator1_DSTAT_l;/* '<S3>/Discrete-Time Integrator1' */
  real_T DiscreteTimeIntegrator2_DSTAT_k;/* '<S3>/Discrete-Time Integrator2' */
  real_T DiscreteTimeIntegrator1_DSTAT_i;/* '<S4>/Discrete-Time Integrator1' */
  real_T DiscreteTimeIntegrator2_DSTAT_p;/* '<S4>/Discrete-Time Integrator2' */
  int_T SFunction1_IWORK[4];           /* '<S11>/S-Function1' */
  int_T SFunction2_IWORK[4];           /* '<S11>/S-Function2' */
  int_T SFunction3_IWORK[4];           /* '<S11>/S-Function3' */
  int_T SFunction4_IWORK[4];           /* '<S11>/S-Function4' */
} DW_mIO_T;

/* Continuous states (auto storage) */
typedef struct {
  real_T Integrator3_CSTATE;           /* '<S1>/Integrator3' */
  real_T Integrator1_CSTATE;           /* '<S2>/Integrator1' */
  real_T Integrator4_CSTATE;           /* '<S1>/Integrator4' */
  real_T Integrator2_CSTATE;           /* '<S2>/Integrator2' */
} X_mIO_T;

/* State derivatives (auto storage) */
typedef struct {
  real_T Integrator3_CSTATE;           /* '<S1>/Integrator3' */
  real_T Integrator1_CSTATE;           /* '<S2>/Integrator1' */
  real_T Integrator4_CSTATE;           /* '<S1>/Integrator4' */
  real_T Integrator2_CSTATE;           /* '<S2>/Integrator2' */
} XDot_mIO_T;

/* State disabled  */
typedef struct {
  boolean_T Integrator3_CSTATE;        /* '<S1>/Integrator3' */
  boolean_T Integrator1_CSTATE;        /* '<S2>/Integrator1' */
  boolean_T Integrator4_CSTATE;        /* '<S1>/Integrator4' */
  boolean_T Integrator2_CSTATE;        /* '<S2>/Integrator2' */
} XDis_mIO_T;

/* Zero-crossing (trigger) state */
typedef struct {
  ZCSigState DS1104ENC_SET_POS_C1_Trig_ZCE;/* '<S8>/DS1104ENC_SET_POS_C1' */
} PrevZCX_mIO_T;

#ifndef ODE1_INTG
#define ODE1_INTG

/* ODE1 Integration Data */
typedef struct {
  real_T *f[1];                        /* derivatives */
} ODE1_IntgData;

#endif

/* External outputs (root outports fed by signals with auto storage) */
typedef struct {
  real_T dph_sim;                      /* '<Root>/dph_sim' */
  real_T phi_sim;                      /* '<Root>/phi_sim' */
} ExtY_mIO_T;

/* Backward compatible GRT Identifiers */
#define rtB                            mIO_B
#define BlockIO                        B_mIO_T
#define rtX                            mIO_X
#define ContinuousStates               X_mIO_T
#define rtXdot                         mIO_XDot
#define StateDerivatives               XDot_mIO_T
#define tXdis                          mIO_XDis
#define StateDisabled                  XDis_mIO_T
#define rtY                            mIO_Y
#define ExternalOutputs                ExtY_mIO_T
#define rtP                            mIO_P
#define Parameters                     P_mIO_T
#define rtDWork                        mIO_DW
#define D_Work                         DW_mIO_T
#define rtPrevZCSigState               mIO_PrevZCX
#define PrevZCSigStates                PrevZCX_mIO_T

/* Parameters (auto storage) */
struct P_mIO_T_ {
  real_T Dpos;                         /* Variable: Dpos
                                        * Referenced by: '<S4>/Derivative Gain'
                                        */
  real_T Ipos;                         /* Variable: Ipos
                                        * Referenced by: '<S4>/Integral Gain'
                                        */
  real_T Jeq;                          /* Variable: Jeq
                                        * Referenced by: '<S2>/Jeq'
                                        */
  real_T Npos;                         /* Variable: Npos
                                        * Referenced by: '<S4>/Filter Gain'
                                        */
  real_T Ppos;                         /* Variable: Ppos
                                        * Referenced by: '<S4>/Proportional Gain'
                                        */
  real_T Tc;                           /* Variable: Tc
                                        * Referenced by: '<S1>/Constant'
                                        */
  real_T dm;                           /* Variable: dm
                                        * Referenced by: '<S2>/Friction'
                                        */
  real_T dv;                           /* Variable: dv
                                        * Referenced by: '<S1>/Constant1'
                                        */
  real_T eps_Jeq;                      /* Variable: eps_Jeq
                                        * Referenced by: '<S2>/eps_Jeq'
                                        */
  real_T eps_dm;                       /* Variable: eps_dm
                                        * Referenced by: '<S2>/eps_dm'
                                        */
  real_T Modelselector_Value;          /* Expression: 1
                                        * Referenced by: '<Root>/Model selector'
                                        */
  real_T Integrator3_IC;               /* Expression: 0
                                        * Referenced by: '<S1>/Integrator3'
                                        */
  real_T Gain10_Gain;                  /* Expression: 1/n
                                        * Referenced by: '<S1>/Gain10'
                                        */
  real_T Integrator1_IC;               /* Expression: 0
                                        * Referenced by: '<S2>/Integrator1'
                                        */
  real_T Gain7_Gain;                   /* Expression: 1/n
                                        * Referenced by: '<S2>/Gain7'
                                        */
  real_T Integrator4_IC;               /* Expression: 0
                                        * Referenced by: '<S1>/Integrator4'
                                        */
  real_T Gain9_Gain;                   /* Expression: 1/n
                                        * Referenced by: '<S1>/Gain9'
                                        */
  real_T Integrator2_IC;               /* Expression: 0
                                        * Referenced by: '<S2>/Integrator2'
                                        */
  real_T Gain6_Gain;                   /* Expression: 1/n
                                        * Referenced by: '<S2>/Gain6'
                                        */
  real_T CtrlSignalSelector_Value;     /* Expression: 4
                                        * Referenced by: '<Root>/Ctrl. Signal Selector'
                                        */
  real_T CtrlSine_Amplitude;           /* Expression: 24
                                        * Referenced by: '<Root>/Ctrl. Sine'
                                        */
  real_T CtrlSine_Frequency;           /* Expression: 2*pi*2/10
                                        * Referenced by: '<Root>/Ctrl. Sine'
                                        */
  real_T CtrlSquare_Amplitude;         /* Expression: 24
                                        * Referenced by: '<Root>/Ctrl. Square'
                                        */
  real_T CtrlSquare_Frequency;         /* Computed Parameter: CtrlSquare_Frequency
                                        * Referenced by: '<Root>/Ctrl. Square'
                                        */
  real_T CtrlStep_Time;                /* Expression: 0
                                        * Referenced by: '<Root>/Ctrl. Step'
                                        */
  real_T CtrlStep_Y0;                  /* Expression: 0
                                        * Referenced by: '<Root>/Ctrl. Step'
                                        */
  real_T CtrlStep_YFinal;              /* Expression: 24
                                        * Referenced by: '<Root>/Ctrl. Step'
                                        */
  real_T VelRefSignalSelector_Value;   /* Expression: 1
                                        * Referenced by: '<Root>/Vel.Ref. Signal Selector'
                                        */
  real_T VelRefStep_Time;              /* Expression: 0
                                        * Referenced by: '<Root>/Vel.Ref. Step'
                                        */
  real_T VelRefStep_Y0;                /* Expression: 0
                                        * Referenced by: '<Root>/Vel.Ref. Step'
                                        */
  real_T VelRefStep_YFinal;            /* Expression: 50
                                        * Referenced by: '<Root>/Vel.Ref. Step'
                                        */
  real_T VelRefSine_Amplitude;         /* Expression: 50
                                        * Referenced by: '<Root>/Vel.Ref. Sine'
                                        */
  real_T VelRefSine_Frequency;         /* Expression: 2*pi*2/10
                                        * Referenced by: '<Root>/Vel.Ref. Sine'
                                        */
  real_T VelRefSquare_Amplitude;       /* Expression: 50
                                        * Referenced by: '<Root>/Vel.Ref. Square'
                                        */
  real_T VelRefSquare_Frequency;       /* Computed Parameter: VelRefSquare_Frequency
                                        * Referenced by: '<Root>/Vel.Ref. Square'
                                        */
  real_T w1_scaling_Gain;              /* Expression: 2*pi/(1000)/Ts
                                        * Referenced by: '<S8>/w1_scaling'
                                        */
  real_T ProportionalGain1_Gain;       /* Expression: double(Psp_d)
                                        * Referenced by: '<S5>/Proportional Gain1'
                                        */
  real_T DerivativeGain2_Gain;         /* Expression: double(Dsp_d)
                                        * Referenced by: '<S5>/Derivative Gain2'
                                        */
  real_T DiscreteTimeIntegrator1_gainval;/* Computed Parameter: DiscreteTimeIntegrator1_gainval
                                          * Referenced by: '<S5>/Discrete-Time Integrator1'
                                          */
  real_T DiscreteTimeIntegrator1_IC;   /* Expression: 0
                                        * Referenced by: '<S5>/Discrete-Time Integrator1'
                                        */
  real_T FilterGain1_Gain;             /* Expression: double(Nsp_d)
                                        * Referenced by: '<S5>/Filter Gain1'
                                        */
  real_T DiscreteTimeIntegrator2_gainval;/* Computed Parameter: DiscreteTimeIntegrator2_gainval
                                          * Referenced by: '<S5>/Discrete-Time Integrator2'
                                          */
  real_T DiscreteTimeIntegrator2_IC;   /* Expression: 0
                                        * Referenced by: '<S5>/Discrete-Time Integrator2'
                                        */
  real_T Saturation_UpperSat;          /* Expression: 24
                                        * Referenced by: '<S5>/Saturation'
                                        */
  real_T Saturation_LowerSat;          /* Expression: -24
                                        * Referenced by: '<S5>/Saturation'
                                        */
  real_T Pos_Time;                     /* Expression: 0
                                        * Referenced by: '<Root>/Pos'
                                        */
  real_T Pos_Y0;                       /* Expression: 0
                                        * Referenced by: '<Root>/Pos'
                                        */
  real_T Pos_YFinal;                   /* Expression: 1
                                        * Referenced by: '<Root>/Pos'
                                        */
  real_T fi1_scaling_Gain;             /* Expression: 2*pi/(1000)
                                        * Referenced by: '<S8>/fi1_scaling'
                                        */
  real_T ProportionalGain1_Gain_c;     /* Expression: double(Ppos_d)
                                        * Referenced by: '<S3>/Proportional Gain1'
                                        */
  real_T DerivativeGain2_Gain_l;       /* Expression: double(Dpos_d)
                                        * Referenced by: '<S3>/Derivative Gain2'
                                        */
  real_T DiscreteTimeIntegrator1_gainv_h;/* Computed Parameter: DiscreteTimeIntegrator1_gainv_h
                                          * Referenced by: '<S3>/Discrete-Time Integrator1'
                                          */
  real_T DiscreteTimeIntegrator1_IC_a; /* Expression: 0
                                        * Referenced by: '<S3>/Discrete-Time Integrator1'
                                        */
  real_T FilterGain1_Gain_o;           /* Expression: double(Npos_d)
                                        * Referenced by: '<S3>/Filter Gain1'
                                        */
  real_T DiscreteTimeIntegrator2_gainv_d;/* Computed Parameter: DiscreteTimeIntegrator2_gainv_d
                                          * Referenced by: '<S3>/Discrete-Time Integrator2'
                                          */
  real_T DiscreteTimeIntegrator2_IC_o; /* Expression: 0
                                        * Referenced by: '<S3>/Discrete-Time Integrator2'
                                        */
  real_T Saturation_UpperSat_b;        /* Expression: 24
                                        * Referenced by: '<S3>/Saturation'
                                        */
  real_T Saturation_LowerSat_c;        /* Expression: -24
                                        * Referenced by: '<S3>/Saturation'
                                        */
  real_T DiscreteTimeIntegrator1_gainv_c;/* Computed Parameter: DiscreteTimeIntegrator1_gainv_c
                                          * Referenced by: '<S4>/Discrete-Time Integrator1'
                                          */
  real_T DiscreteTimeIntegrator1_IC_l; /* Expression: 0
                                        * Referenced by: '<S4>/Discrete-Time Integrator1'
                                        */
  real_T DiscreteTimeIntegrator2_gainv_k;/* Computed Parameter: DiscreteTimeIntegrator2_gainv_k
                                          * Referenced by: '<S4>/Discrete-Time Integrator2'
                                          */
  real_T DiscreteTimeIntegrator2_IC_d; /* Expression: 0
                                        * Referenced by: '<S4>/Discrete-Time Integrator2'
                                        */
  real_T Saturation_UpperSat_g;        /* Expression: 24
                                        * Referenced by: '<S4>/Saturation'
                                        */
  real_T Saturation_LowerSat_m;        /* Expression: -24
                                        * Referenced by: '<S4>/Saturation'
                                        */
  real_T Gain_Gain;                    /* Expression: -1
                                        * Referenced by: '<Root>/Gain'
                                        */
  real_T Saturation_UpperSat_bg;       /* Expression: 24
                                        * Referenced by: '<S6>/Saturation'
                                        */
  real_T Saturation_LowerSat_k;        /* Expression: -24
                                        * Referenced by: '<S6>/Saturation'
                                        */
  real_T pwm_skalning_Gain;            /* Expression: 1/48
                                        * Referenced by: '<S6>/pwm_skalning'
                                        */
  real_T pwm_offstet_Value;            /* Expression: 0.5
                                        * Referenced by: '<S6>/pwm_offstet'
                                        */
  real_T Enable1_Off0_On_Value;        /* Expression: 1
                                        * Referenced by: '<S6>/Enable[1_Off, 0_On]'
                                        */
  real_T Gain3_Gain;                   /* Expression: dm_final+ Km*Kemf/R
                                        * Referenced by: '<S1>/Gain3'
                                        */
  real_T Gain2_Gain;                   /* Expression: Km/R
                                        * Referenced by: '<S1>/Gain2'
                                        */
  real_T Gain5_Gain;                   /* Expression: 1/Jeq_final
                                        * Referenced by: '<S1>/Gain5'
                                        */
  real_T Gain2_Gain_g;                 /* Expression: Km/R
                                        * Referenced by: '<S2>/Gain2'
                                        */
  real_T Gain4_Gain;                   /* Expression: Km*Kemf/(R)
                                        * Referenced by: '<S2>/Gain4'
                                        */
  real_T AntiWindup1_Gain;             /* Expression: 29.6
                                        * Referenced by: '<S3>/Anti-Windup1'
                                        */
  real_T AntiWindup2_Gain;             /* Expression: 1
                                        * Referenced by: '<S3>/Anti-Windup2'
                                        */
  real_T IntegralGain2_Gain;           /* Expression: double(Ipos_d)
                                        * Referenced by: '<S3>/Integral Gain2'
                                        */
  real_T AntiWindup_Gain;              /* Expression: 29.6
                                        * Referenced by: '<S4>/Anti-Windup'
                                        */
  real_T AntiWindup1_Gain_j;           /* Expression: 1
                                        * Referenced by: '<S4>/Anti-Windup1'
                                        */
  real_T AntiWindup_Gain_o;            /* Expression: 29.6
                                        * Referenced by: '<S5>/Anti-Windup'
                                        */
  real_T AntiWindup1_Gain_f;           /* Expression: 1
                                        * Referenced by: '<S5>/Anti-Windup1'
                                        */
  real_T IntegralGain2_Gain_h;         /* Expression: double(Isp_d)
                                        * Referenced by: '<S5>/Integral Gain2'
                                        */
  real_T Resetenc_Value;               /* Expression: 0
                                        * Referenced by: '<S8>/Reset enc'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_mIO_T {
  const char_T *path;
  const char_T *modelName;
  struct SimStruct_tag * *childSfunctions;
  const char_T *errorStatus;
  SS_SimMode simMode;
  RTWExtModeInfo *extModeInfo;
  RTWSolverInfo solverInfo;
  RTWSolverInfo *solverInfoPtr;
  void *sfcnInfo;

  /*
   * ModelData:
   * The following substructure contains information regarding
   * the data used in the model.
   */
  struct {
    void *blockIO;
    const void *constBlockIO;
    void *defaultParam;
    ZCSigState *prevZCSigState;
    real_T *contStates;
    real_T *derivs;
    void *zcSignalValues;
    void *inputs;
    void *outputs;
    boolean_T *contStateDisabled;
    boolean_T zCCacheNeedsReset;
    boolean_T derivCacheNeedsReset;
    boolean_T blkStateChange;
    real_T odeF[1][4];
    ODE1_IntgData intgData;
    void *dwork;
  } ModelData;

  /*
   * Sizes:
   * The following substructure contains sizes information
   * for many of the model attributes such as inputs, outputs,
   * dwork, sample times, etc.
   */
  struct {
    uint32_T checksums[4];
    uint32_T options;
    int_T numContStates;
    int_T numU;
    int_T numY;
    int_T numSampTimes;
    int_T numBlocks;
    int_T numBlockIO;
    int_T numBlockPrms;
    int_T numDwork;
    int_T numSFcnPrms;
    int_T numSFcns;
    int_T numIports;
    int_T numOports;
    int_T numNonSampZCs;
    int_T sysDirFeedThru;
    int_T rtwGenSfcn;
  } Sizes;

  /*
   * SpecialInfo:
   * The following substructure contains special information
   * related to other components that are dependent on RTW.
   */
  struct {
    const void *mappingInfo;
    void *xpcData;
  } SpecialInfo;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    time_T stepSize;
    uint32_T clockTick0;
    uint32_T clockTickH0;
    time_T stepSize0;
    uint32_T clockTick1;
    uint32_T clockTickH1;
    time_T stepSize1;
    time_T tStart;
    time_T tFinal;
    time_T timeOfLastOutput;
    void *timingData;
    real_T *varNextHitTimesList;
    SimTimeStep simTimeStep;
    boolean_T stopRequestedFlag;
    time_T *sampleTimes;
    time_T *offsetTimes;
    int_T *sampleTimeTaskIDPtr;
    int_T *sampleHits;
    int_T *perTaskSampleHits;
    time_T *t;
    time_T sampleTimesArray[2];
    time_T offsetTimesArray[2];
    int_T sampleTimeTaskIDArray[2];
    int_T sampleHitArray[2];
    int_T perTaskSampleHitsArray[4];
    time_T tArray[2];
  } Timing;
};

/* Block parameters (auto storage) */
extern P_mIO_T mIO_P;

/* Block signals (auto storage) */
extern B_mIO_T mIO_B;

/* Continuous states (auto storage) */
extern X_mIO_T mIO_X;

/* Block states (auto storage) */
extern DW_mIO_T mIO_DW;

/* External outputs (root outports fed by signals with auto storage) */
extern ExtY_mIO_T mIO_Y;

/* External data declarations for dependent source files */

/* Zero-crossing (trigger) state */
extern PrevZCX_mIO_T mIO_PrevZCX;

/* Model entry point functions */
extern void mIO_initialize(void);
extern void mIO_output(void);
extern void mIO_update(void);
extern void mIO_terminate(void);

/*====================*
 * External functions *
 *====================*/
extern mIO_rtModel *mIO(void);
extern void MdlInitializeSizes(void);
extern void MdlInitializeSampleTimes(void);
extern void MdlInitialize(void);
extern void MdlStart(void);
extern void MdlOutputs(int_T tid);
extern void MdlUpdate(int_T tid);
extern void MdlTerminate(void);

/* Real-time Model object */
extern RT_MODEL_mIO_T *const mIO_M;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'mIO'
 * '<S1>'   : 'mIO/Model friction '
 * '<S2>'   : 'mIO/Motor Model'
 * '<S3>'   : 'mIO/PID_pos_discrete  '
 * '<S4>'   : 'mIO/PID_position_continuous '
 * '<S5>'   : 'mIO/PID_speed_discrete'
 * '<S6>'   : 'mIO/PWM'
 * '<S7>'   : 'mIO/RTI Data'
 * '<S8>'   : 'mIO/enc I//F'
 * '<S9>'   : 'mIO/Model friction /MATLAB Function'
 * '<S10>'  : 'mIO/PWM/DS1104BIT_OUT_C0'
 * '<S11>'  : 'mIO/PWM/DS1104SL_DSP_PWM'
 * '<S12>'  : 'mIO/RTI Data/RTI Data Store'
 * '<S13>'  : 'mIO/RTI Data/RTI Data Store/RTI Data Store'
 * '<S14>'  : 'mIO/RTI Data/RTI Data Store/RTI Data Store/RTI Data Store'
 * '<S15>'  : 'mIO/enc I//F/DS1104ENC_POS_C1'
 * '<S16>'  : 'mIO/enc I//F/DS1104ENC_SETUP'
 * '<S17>'  : 'mIO/enc I//F/DS1104ENC_SET_POS_C1'
 */
#endif                                 /* RTW_HEADER_mIO_h_ */
