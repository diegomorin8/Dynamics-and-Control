  /*********************** dSPACE target specific file *************************

   Header file mIO_trc_ptr.h:

   Declaration of function that initializes the global TRC pointers

   RTI1104 7.3 (02-Nov-2014)
   Fri Mar 10 12:26:03 2017

   (c) Copyright 2008, dSPACE GmbH. All rights reserved.

  *****************************************************************************/
  #ifndef RTI_HEADER_mIO_trc_ptr_h_
  #define RTI_HEADER_mIO_trc_ptr_h_
  /* Include the model header file. */
  #include "mIO.h"
  #include "mIO_private.h"

  #ifdef EXTERN_C
  #undef EXTERN_C
  #endif

  #ifdef __cplusplus
  #define EXTERN_C                       extern "C"
  #else
  #define EXTERN_C                       extern
  #endif

  /*
   *  Declare the global TRC pointers
   */
              EXTERN_C volatile  real_T *p_0_mIO_real_T_0;
              EXTERN_C volatile  boolean_T *p_0_mIO_boolean_T_1;
              EXTERN_C volatile  real_T *p_1_mIO_real_T_0;
              EXTERN_C volatile  real_T *p_2_mIO_real_T_0;
              EXTERN_C volatile  int_T *p_2_mIO_int_T_1;
              EXTERN_C volatile  real_T *p_3_mIO_real_T_0;
              EXTERN_C volatile  real_T *p_5_mIO_real_T_0;

   #define RTI_INIT_TRC_POINTERS() \
              p_0_mIO_real_T_0 = &mIO_B.Integrator1;\
              p_0_mIO_boolean_T_1 = &mIO_B.DataTypeConversion;\
              p_1_mIO_real_T_0 = &mIO_P.Dpos;\
              p_2_mIO_real_T_0 = &mIO_DW.DiscreteTimeIntegrator1_DSTATE;\
              p_2_mIO_int_T_1 = &mIO_DW.SFunction1_IWORK[0];\
              p_3_mIO_real_T_0 = &mIO_X.Integrator1_CSTATE;\
              p_5_mIO_real_T_0 = &mIO_Y.dph_sim;\

   #endif                       /* RTI_HEADER_mIO_trc_ptr_h_ */
