#ifndef __c4_SimLab3_2_discretization_h__
#define __c4_SimLab3_2_discretization_h__

/* Include files */
#include "sf_runtime/sfc_sf.h"
#include "sf_runtime/sfc_mex.h"
#include "rtwtypes.h"
#include "multiword_types.h"

/* Type Definitions */
#ifndef typedef_SFc4_SimLab3_2_discretizationInstanceStruct
#define typedef_SFc4_SimLab3_2_discretizationInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  int32_T c4_sfEvent;
  boolean_T c4_isStable;
  boolean_T c4_doneDoubleBufferReInit;
  uint8_T c4_is_active_c4_SimLab3_2_discretization;
  real_T *c4_v;
  real_T *c4_Tf;
  real_T *c4_Ta;
} SFc4_SimLab3_2_discretizationInstanceStruct;

#endif                                 /*typedef_SFc4_SimLab3_2_discretizationInstanceStruct*/

/* Named Constants */

/* Variable Declarations */
extern struct SfDebugInstanceStruct *sfGlobalDebugInstanceStruct;

/* Variable Definitions */

/* Function Declarations */
extern const mxArray
  *sf_c4_SimLab3_2_discretization_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c4_SimLab3_2_discretization_get_check_sum(mxArray *plhs[]);
extern void c4_SimLab3_2_discretization_method_dispatcher(SimStruct *S, int_T
  method, void *data);

#endif
