#ifndef MYPYC_LIBRT_INTERNAL_H
#define MYPYC_LIBRT_INTERNAL_H
#include <Python.h>
#include <CPy.h>
#include "__native.h"

int CPyGlobalsInit(void);

extern PyObject *CPyStatics[11];
extern const char * const CPyLit_Str[];
extern const char * const CPyLit_Bytes[];
extern const char * const CPyLit_Int[];
extern const double CPyLit_Float[];
extern const double CPyLit_Complex[];
extern const int CPyLit_Tuple[];
extern const int CPyLit_FrozenSet[];
extern CPyModule *CPyModule_mypyc_calculate_volume__internal;
extern CPyModule *CPyModule_mypyc_calculate_volume;
extern PyObject *CPyStatic_globals;
extern CPyModule *CPyModule_builtins;
extern CPyModule *CPyModule_random;
extern double CPyDef_calculate_volumne(double cpy_r_r, CPyTagged cpy_r_N, CPyTagged cpy_r_seed);
extern PyObject *CPyPy_calculate_volumne(PyObject *self, PyObject *const *args, size_t nargs, PyObject *kwnames);
extern CPyTagged CPyDef_count_hits(double cpy_r_r, CPyTagged cpy_r_N);
extern PyObject *CPyPy_count_hits(PyObject *self, PyObject *const *args, size_t nargs, PyObject *kwnames);
extern char CPyDef___top_level__(void);
#endif
