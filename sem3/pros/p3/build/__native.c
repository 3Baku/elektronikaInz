#include "init.c"
#include "getargs.c"
#include "getargsfast.c"
#include "int_ops.c"
#include "float_ops.c"
#include "str_ops.c"
#include "bytes_ops.c"
#include "list_ops.c"
#include "dict_ops.c"
#include "set_ops.c"
#include "tuple_ops.c"
#include "exc_ops.c"
#include "misc_ops.c"
#include "generic_ops.c"
#include "pythonsupport.c"
#include "__native.h"
#include "__native_internal.h"
static int _exec(PyObject *module)
{
    PyObject* modname = NULL;
    modname = PyObject_GetAttrString((PyObject *)CPyModule_steinmetz_mypyc_internal, "__name__");
    CPyStatic_globals = PyModule_GetDict(CPyModule_steinmetz_mypyc_internal);
    if (unlikely(CPyStatic_globals == NULL))
        goto fail;
    if (CPyGlobalsInit() < 0)
        goto fail;
    char result = CPyDef___top_level__();
    if (result == 2)
        goto fail;
    Py_DECREF(modname);
    return 0;
    fail:
    Py_CLEAR(CPyModule_steinmetz_mypyc_internal);
    Py_CLEAR(modname);
    return -1;
}
static PyMethodDef module_methods[] = {
    {"calculate_steinmetz_mypyc", (PyCFunction)CPyPy_calculate_steinmetz_mypyc, METH_FASTCALL | METH_KEYWORDS, NULL /* docstring */},
    {NULL, NULL, 0, NULL}
};

static struct PyModuleDef module = {
    PyModuleDef_HEAD_INIT,
    "steinmetz_mypyc",
    NULL, /* docstring */
    0,       /* size of per-interpreter state of the module */
    module_methods,
    NULL,
};

PyMODINIT_FUNC PyInit_steinmetz_mypyc(void)
{
    if (CPyModule_steinmetz_mypyc_internal) {
        Py_INCREF(CPyModule_steinmetz_mypyc_internal);
        return CPyModule_steinmetz_mypyc_internal;
    }
    CPyModule_steinmetz_mypyc_internal = PyModule_Create(&module);
    if (unlikely(CPyModule_steinmetz_mypyc_internal == NULL))
        goto fail;
    if (_exec(CPyModule_steinmetz_mypyc_internal) != 0)
        goto fail;
    return CPyModule_steinmetz_mypyc_internal;
    fail:
    return NULL;
}

double CPyDef_calculate_steinmetz_mypyc(CPyTagged cpy_r_n, double cpy_r_r) {
    CPyTagged cpy_r_hits;
    double cpy_r_r0;
    CPyTagged cpy_r_r1;
    PyObject *cpy_r_r2;
    PyObject *cpy_r__;
    int64_t cpy_r_r3;
    char cpy_r_r4;
    int64_t cpy_r_r5;
    char cpy_r_r6;
    char cpy_r_r7;
    char cpy_r_r8;
    double cpy_r_r9;
    PyObject *cpy_r_r10;
    PyObject *cpy_r_r11;
    PyObject *cpy_r_r12;
    PyObject *cpy_r_r13;
    PyObject *cpy_r_r14;
    PyObject **cpy_r_r16;
    PyObject *cpy_r_r17;
    double cpy_r_r18;
    char cpy_r_r19;
    double cpy_r_r20;
    PyObject *cpy_r_r21;
    PyObject *cpy_r_r22;
    PyObject *cpy_r_r23;
    PyObject *cpy_r_r24;
    PyObject *cpy_r_r25;
    PyObject *cpy_r_r26;
    PyObject **cpy_r_r28;
    PyObject *cpy_r_r29;
    double cpy_r_r30;
    char cpy_r_r31;
    double cpy_r_r32;
    PyObject *cpy_r_r33;
    PyObject *cpy_r_r34;
    PyObject *cpy_r_r35;
    PyObject *cpy_r_r36;
    PyObject *cpy_r_r37;
    PyObject *cpy_r_r38;
    PyObject **cpy_r_r40;
    PyObject *cpy_r_r41;
    double cpy_r_r42;
    char cpy_r_r43;
    double cpy_r_r44;
    double cpy_r_r45;
    double cpy_r_r46;
    char cpy_r_r47;
    PyObject *cpy_r_r48;
    double cpy_r_r49;
    double cpy_r_r50;
    double cpy_r_r51;
    char cpy_r_r52;
    CPyTagged cpy_r_r53;
    CPyTagged cpy_r_r54;
    PyObject *cpy_r_r55;
    double cpy_r_r56;
    PyObject *cpy_r_r57;
    PyObject *cpy_r_r58;
    PyObject *cpy_r_r59;
    double cpy_r_r60;
    char cpy_r_r61;
    double cpy_r_r62;
    char cpy_r_r63;
    PyObject *cpy_r_r64;
    double cpy_r_r65;
    PyObject *cpy_r_r66;
    double cpy_r_r67;
    cpy_r_hits = 0;
    cpy_r_r0 = cpy_r_r * cpy_r_r;
    cpy_r_r1 = 0;
    CPyTagged_INCREF(cpy_r_r1);
    cpy_r_r2 = CPyTagged_StealAsObject(cpy_r_r1);
    cpy_r__ = cpy_r_r2;
    CPy_DECREF(cpy_r__);
CPyL1: ;
    cpy_r_r3 = cpy_r_r1 & 1;
    cpy_r_r4 = cpy_r_r3 != 0;
    if (cpy_r_r4) goto CPyL3;
    cpy_r_r5 = cpy_r_n & 1;
    cpy_r_r6 = cpy_r_r5 != 0;
    if (!cpy_r_r6) goto CPyL4;
CPyL3: ;
    cpy_r_r7 = CPyTagged_IsLt_(cpy_r_r1, cpy_r_n);
    if (cpy_r_r7) {
        goto CPyL5;
    } else
        goto CPyL28;
CPyL4: ;
    cpy_r_r8 = (Py_ssize_t)cpy_r_r1 < (Py_ssize_t)cpy_r_n;
    if (!cpy_r_r8) goto CPyL28;
CPyL5: ;
    cpy_r_r9 = -cpy_r_r;
    cpy_r_r10 = CPyModule_random;
    cpy_r_r11 = CPyStatics[3]; /* 'uniform' */
    cpy_r_r12 = CPyObject_GetAttr(cpy_r_r10, cpy_r_r11);
    if (unlikely(cpy_r_r12 == NULL)) {
        CPy_AddTraceback("steinmetz_mypyc.py", "calculate_steinmetz_mypyc", 12, CPyStatic_globals);
        goto CPyL29;
    }
    cpy_r_r13 = PyFloat_FromDouble(cpy_r_r9);
    cpy_r_r14 = PyFloat_FromDouble(cpy_r_r);
    PyObject *cpy_r_r15[2] = {cpy_r_r13, cpy_r_r14};
    cpy_r_r16 = (PyObject **)&cpy_r_r15;
    cpy_r_r17 = PyObject_Vectorcall(cpy_r_r12, cpy_r_r16, 2, 0);
    CPy_DECREF(cpy_r_r12);
    if (unlikely(cpy_r_r17 == NULL)) {
        CPy_AddTraceback("steinmetz_mypyc.py", "calculate_steinmetz_mypyc", 12, CPyStatic_globals);
        goto CPyL30;
    }
    CPy_DECREF(cpy_r_r13);
    CPy_DECREF(cpy_r_r14);
    cpy_r_r18 = PyFloat_AsDouble(cpy_r_r17);
    if (cpy_r_r18 == -1.0 && PyErr_Occurred()) {
        CPy_TypeError("float", cpy_r_r17); cpy_r_r18 = -113.0;
    }
    CPy_DECREF(cpy_r_r17);
    cpy_r_r19 = cpy_r_r18 == -113.0;
    if (unlikely(cpy_r_r19)) goto CPyL9;
CPyL8: ;
    cpy_r_r20 = -cpy_r_r;
    cpy_r_r21 = CPyModule_random;
    cpy_r_r22 = CPyStatics[3]; /* 'uniform' */
    cpy_r_r23 = CPyObject_GetAttr(cpy_r_r21, cpy_r_r22);
    if (unlikely(cpy_r_r23 == NULL)) {
        CPy_AddTraceback("steinmetz_mypyc.py", "calculate_steinmetz_mypyc", 13, CPyStatic_globals);
        goto CPyL29;
    } else
        goto CPyL10;
CPyL9: ;
    cpy_r_r24 = PyErr_Occurred();
    if (unlikely(cpy_r_r24 != NULL)) {
        CPy_AddTraceback("steinmetz_mypyc.py", "calculate_steinmetz_mypyc", 12, CPyStatic_globals);
        goto CPyL29;
    } else
        goto CPyL8;
CPyL10: ;
    cpy_r_r25 = PyFloat_FromDouble(cpy_r_r20);
    cpy_r_r26 = PyFloat_FromDouble(cpy_r_r);
    PyObject *cpy_r_r27[2] = {cpy_r_r25, cpy_r_r26};
    cpy_r_r28 = (PyObject **)&cpy_r_r27;
    cpy_r_r29 = PyObject_Vectorcall(cpy_r_r23, cpy_r_r28, 2, 0);
    CPy_DECREF(cpy_r_r23);
    if (unlikely(cpy_r_r29 == NULL)) {
        CPy_AddTraceback("steinmetz_mypyc.py", "calculate_steinmetz_mypyc", 13, CPyStatic_globals);
        goto CPyL31;
    }
    CPy_DECREF(cpy_r_r25);
    CPy_DECREF(cpy_r_r26);
    cpy_r_r30 = PyFloat_AsDouble(cpy_r_r29);
    if (cpy_r_r30 == -1.0 && PyErr_Occurred()) {
        CPy_TypeError("float", cpy_r_r29); cpy_r_r30 = -113.0;
    }
    CPy_DECREF(cpy_r_r29);
    cpy_r_r31 = cpy_r_r30 == -113.0;
    if (unlikely(cpy_r_r31)) goto CPyL13;
CPyL12: ;
    cpy_r_r32 = -cpy_r_r;
    cpy_r_r33 = CPyModule_random;
    cpy_r_r34 = CPyStatics[3]; /* 'uniform' */
    cpy_r_r35 = CPyObject_GetAttr(cpy_r_r33, cpy_r_r34);
    if (unlikely(cpy_r_r35 == NULL)) {
        CPy_AddTraceback("steinmetz_mypyc.py", "calculate_steinmetz_mypyc", 14, CPyStatic_globals);
        goto CPyL29;
    } else
        goto CPyL14;
CPyL13: ;
    cpy_r_r36 = PyErr_Occurred();
    if (unlikely(cpy_r_r36 != NULL)) {
        CPy_AddTraceback("steinmetz_mypyc.py", "calculate_steinmetz_mypyc", 13, CPyStatic_globals);
        goto CPyL29;
    } else
        goto CPyL12;
CPyL14: ;
    cpy_r_r37 = PyFloat_FromDouble(cpy_r_r32);
    cpy_r_r38 = PyFloat_FromDouble(cpy_r_r);
    PyObject *cpy_r_r39[2] = {cpy_r_r37, cpy_r_r38};
    cpy_r_r40 = (PyObject **)&cpy_r_r39;
    cpy_r_r41 = PyObject_Vectorcall(cpy_r_r35, cpy_r_r40, 2, 0);
    CPy_DECREF(cpy_r_r35);
    if (unlikely(cpy_r_r41 == NULL)) {
        CPy_AddTraceback("steinmetz_mypyc.py", "calculate_steinmetz_mypyc", 14, CPyStatic_globals);
        goto CPyL32;
    }
    CPy_DECREF(cpy_r_r37);
    CPy_DECREF(cpy_r_r38);
    cpy_r_r42 = PyFloat_AsDouble(cpy_r_r41);
    if (cpy_r_r42 == -1.0 && PyErr_Occurred()) {
        CPy_TypeError("float", cpy_r_r41); cpy_r_r42 = -113.0;
    }
    CPy_DECREF(cpy_r_r41);
    cpy_r_r43 = cpy_r_r42 == -113.0;
    if (unlikely(cpy_r_r43)) goto CPyL17;
CPyL16: ;
    cpy_r_r44 = cpy_r_r18 * cpy_r_r18;
    cpy_r_r45 = cpy_r_r30 * cpy_r_r30;
    cpy_r_r46 = cpy_r_r44 + cpy_r_r45;
    cpy_r_r47 = cpy_r_r46 <= cpy_r_r0;
    if (cpy_r_r47) {
        goto CPyL18;
    } else
        goto CPyL20;
CPyL17: ;
    cpy_r_r48 = PyErr_Occurred();
    if (unlikely(cpy_r_r48 != NULL)) {
        CPy_AddTraceback("steinmetz_mypyc.py", "calculate_steinmetz_mypyc", 14, CPyStatic_globals);
        goto CPyL29;
    } else
        goto CPyL16;
CPyL18: ;
    cpy_r_r49 = cpy_r_r18 * cpy_r_r18;
    cpy_r_r50 = cpy_r_r42 * cpy_r_r42;
    cpy_r_r51 = cpy_r_r49 + cpy_r_r50;
    cpy_r_r52 = cpy_r_r51 <= cpy_r_r0;
    if (!cpy_r_r52) goto CPyL20;
    cpy_r_r53 = CPyTagged_Add(cpy_r_hits, 2);
    CPyTagged_DECREF(cpy_r_hits);
    cpy_r_hits = cpy_r_r53;
CPyL20: ;
    cpy_r_r54 = CPyTagged_Add(cpy_r_r1, 2);
    CPyTagged_DECREF(cpy_r_r1);
    CPyTagged_INCREF(cpy_r_r54);
    cpy_r_r1 = cpy_r_r54;
    cpy_r_r55 = CPyTagged_StealAsObject(cpy_r_r54);
    cpy_r__ = cpy_r_r55;
    CPy_DECREF(cpy_r__);
    goto CPyL1;
CPyL21: ;
    cpy_r_r56 = 2.0 * cpy_r_r;
    cpy_r_r57 = PyFloat_FromDouble(cpy_r_r56);
    cpy_r_r58 = PyFloat_FromDouble(3.0);
    cpy_r_r59 = CPyNumber_Power(cpy_r_r57, cpy_r_r58);
    CPy_DECREF(cpy_r_r57);
    CPy_DECREF(cpy_r_r58);
    if (unlikely(cpy_r_r59 == NULL)) {
        CPy_AddTraceback("steinmetz_mypyc.py", "calculate_steinmetz_mypyc", 19, CPyStatic_globals);
        goto CPyL33;
    }
    cpy_r_r60 = PyFloat_AsDouble(cpy_r_r59);
    if (cpy_r_r60 == -1.0 && PyErr_Occurred()) {
        CPy_TypeError("float", cpy_r_r59); cpy_r_r60 = -113.0;
    }
    CPy_DECREF(cpy_r_r59);
    cpy_r_r61 = cpy_r_r60 == -113.0;
    if (unlikely(cpy_r_r61)) goto CPyL24;
CPyL23: ;
    cpy_r_r62 = CPyTagged_TrueDivide(cpy_r_hits, cpy_r_n);
    CPyTagged_DECREF(cpy_r_hits);
    cpy_r_r63 = cpy_r_r62 == -113.0;
    if (unlikely(cpy_r_r63)) {
        goto CPyL26;
    } else
        goto CPyL25;
CPyL24: ;
    cpy_r_r64 = PyErr_Occurred();
    if (unlikely(cpy_r_r64 != NULL)) {
        CPy_AddTraceback("steinmetz_mypyc.py", "calculate_steinmetz_mypyc", 19, CPyStatic_globals);
        goto CPyL33;
    } else
        goto CPyL23;
CPyL25: ;
    cpy_r_r65 = cpy_r_r60 * cpy_r_r62;
    return cpy_r_r65;
CPyL26: ;
    cpy_r_r66 = PyErr_Occurred();
    if (unlikely(cpy_r_r66 != NULL)) {
        CPy_AddTraceback("steinmetz_mypyc.py", "calculate_steinmetz_mypyc", 19, CPyStatic_globals);
    } else
        goto CPyL25;
CPyL27: ;
    cpy_r_r67 = -113.0;
    return cpy_r_r67;
CPyL28: ;
    CPyTagged_DECREF(cpy_r_r1);
    goto CPyL21;
CPyL29: ;
    CPyTagged_DecRef(cpy_r_hits);
    CPyTagged_DecRef(cpy_r_r1);
    goto CPyL27;
CPyL30: ;
    CPyTagged_DecRef(cpy_r_hits);
    CPyTagged_DecRef(cpy_r_r1);
    CPy_DecRef(cpy_r_r13);
    CPy_DecRef(cpy_r_r14);
    goto CPyL27;
CPyL31: ;
    CPyTagged_DecRef(cpy_r_hits);
    CPyTagged_DecRef(cpy_r_r1);
    CPy_DecRef(cpy_r_r25);
    CPy_DecRef(cpy_r_r26);
    goto CPyL27;
CPyL32: ;
    CPyTagged_DecRef(cpy_r_hits);
    CPyTagged_DecRef(cpy_r_r1);
    CPy_DecRef(cpy_r_r37);
    CPy_DecRef(cpy_r_r38);
    goto CPyL27;
CPyL33: ;
    CPyTagged_DecRef(cpy_r_hits);
    goto CPyL27;
}

PyObject *CPyPy_calculate_steinmetz_mypyc(PyObject *self, PyObject *const *args, size_t nargs, PyObject *kwnames) {
    static const char * const kwlist[] = {"n", "r", 0};
    static CPyArg_Parser parser = {"OO:calculate_steinmetz_mypyc", kwlist, 0};
    PyObject *obj_n;
    PyObject *obj_r;
    if (!CPyArg_ParseStackAndKeywordsSimple(args, nargs, kwnames, &parser, &obj_n, &obj_r)) {
        return NULL;
    }
    CPyTagged arg_n;
    if (likely(PyLong_Check(obj_n)))
        arg_n = CPyTagged_BorrowFromObject(obj_n);
    else {
        CPy_TypeError("int", obj_n); goto fail;
    }
    double arg_r;
    arg_r = PyFloat_AsDouble(obj_r);
    if (arg_r == -1.0 && PyErr_Occurred()) {
        CPy_TypeError("float", obj_r); goto fail;
    }
    double retval = CPyDef_calculate_steinmetz_mypyc(arg_n, arg_r);
    if (retval == -113.0 && PyErr_Occurred()) {
        return NULL;
    }
    PyObject *retbox = PyFloat_FromDouble(retval);
    return retbox;
fail: ;
    CPy_AddTraceback("steinmetz_mypyc.py", "calculate_steinmetz_mypyc", 4, CPyStatic_globals);
    return NULL;
}

char CPyDef___top_level__(void) {
    PyObject *cpy_r_r0;
    PyObject *cpy_r_r1;
    char cpy_r_r2;
    PyObject *cpy_r_r3;
    PyObject *cpy_r_r4;
    PyObject **cpy_r_r5;
    void *cpy_r_r7;
    void *cpy_r_r9;
    PyObject *cpy_r_r10;
    PyObject *cpy_r_r11;
    PyObject *cpy_r_r12;
    PyObject *cpy_r_r13;
    char cpy_r_r14;
    char cpy_r_r15;
    cpy_r_r0 = CPyModule_builtins;
    cpy_r_r1 = (PyObject *)&_Py_NoneStruct;
    cpy_r_r2 = cpy_r_r0 != cpy_r_r1;
    if (cpy_r_r2) goto CPyL3;
    cpy_r_r3 = CPyStatics[4]; /* 'builtins' */
    cpy_r_r4 = PyImport_Import(cpy_r_r3);
    if (unlikely(cpy_r_r4 == NULL)) {
        CPy_AddTraceback("steinmetz_mypyc.py", "<module>", -1, CPyStatic_globals);
        goto CPyL5;
    }
    CPyModule_builtins = cpy_r_r4;
    CPy_INCREF(CPyModule_builtins);
    CPy_DECREF(cpy_r_r4);
CPyL3: ;
    cpy_r_r5 = (PyObject **)&CPyModule_random;
    PyObject **cpy_r_r6[1] = {cpy_r_r5};
    cpy_r_r7 = (void *)&cpy_r_r6;
    int64_t cpy_r_r8[1] = {2};
    cpy_r_r9 = (void *)&cpy_r_r8;
    cpy_r_r10 = CPyStatics[9]; /* (('random', 'random', 'random'),) */
    cpy_r_r11 = CPyStatic_globals;
    cpy_r_r12 = CPyStatics[6]; /* 'steinmetz_mypyc.py' */
    cpy_r_r13 = CPyStatics[7]; /* '<module>' */
    cpy_r_r14 = CPyImport_ImportMany(cpy_r_r10, cpy_r_r7, cpy_r_r11, cpy_r_r12, cpy_r_r13, cpy_r_r9);
    if (!cpy_r_r14) goto CPyL5;
    return 1;
CPyL5: ;
    cpy_r_r15 = 2;
    return cpy_r_r15;
}

int CPyGlobalsInit(void)
{
    static int is_initialized = 0;
    if (is_initialized) return 0;
    
    CPy_Init();
    CPyModule_steinmetz_mypyc = Py_None;
    CPyModule_builtins = Py_None;
    CPyModule_random = Py_None;
    if (CPyStatics_Initialize(CPyStatics, CPyLit_Str, CPyLit_Bytes, CPyLit_Int, CPyLit_Float, CPyLit_Complex, CPyLit_Tuple, CPyLit_FrozenSet) < 0) {
        return -1;
    }
    is_initialized = 1;
    return 0;
}

PyObject *CPyStatics[10];
const char * const CPyLit_Str[] = {
    "\005\auniform\bbuiltins\006random\022steinmetz_mypyc.py\b<module>",
    "",
};
const char * const CPyLit_Bytes[] = {
    "",
};
const char * const CPyLit_Int[] = {
    "",
};
const double CPyLit_Float[] = {0};
const double CPyLit_Complex[] = {0};
const int CPyLit_Tuple[] = {2, 3, 5, 5, 5, 1, 8};
const int CPyLit_FrozenSet[] = {0};
CPyModule *CPyModule_steinmetz_mypyc_internal = NULL;
CPyModule *CPyModule_steinmetz_mypyc;
PyObject *CPyStatic_globals;
CPyModule *CPyModule_builtins;
CPyModule *CPyModule_random;
double CPyDef_calculate_steinmetz_mypyc(CPyTagged cpy_r_n, double cpy_r_r);
PyObject *CPyPy_calculate_steinmetz_mypyc(PyObject *self, PyObject *const *args, size_t nargs, PyObject *kwnames);
char CPyDef___top_level__(void);
