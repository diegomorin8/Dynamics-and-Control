#ifndef __c3_mIO_h__
#define __c3_mIO_h__

/* Include files */
#include "sf_runtime/sfc_sf.h"
#include "sf_runtime/sfc_mex.h"
#include "rtwtypes.h"
#include "multiword_types.h"

/* Type Definitions */
#ifndef typedef_SFc3_mIOInstanceStruct
#define typedef_SFc3_mIOInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  int32_T c3_sfEvent;
  boolean_T c3_isStable;
  boolean_T c3_doneDoubleBufferReInit;
  uint8_T c3_is_active_c3_mIO;
  real_T *c3_v;
  real_T *c3_Tf;
  real_T *c3_Ta;
  real_T *c3_Tc;
  real_T *c3_dv;
} SFc3_mIOInstanceStruct;

#endif                                 /*typedef_SFc3_mIOInstanceStruct*/

/* Named Constants */

/* Variable Declarations */
extern struct SfDebugInstanceStruct *sfGlobalDebugInstanceStruct;

/* Variable Definitions */

/* Function Declarations */
extern const mxArray *sf_c3_mIO_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c3_mIO_get_check_sum(mxArray *plhs[]);
extern void c3_mIO_method_dispatcher(SimStruct *S, int_T method, void *data);

#endif
