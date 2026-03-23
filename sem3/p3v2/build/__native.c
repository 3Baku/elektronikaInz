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
static PyMethodDef module_methods[] = {
    {"calculate_volumne", (PyCFunction)CPyPy_calculate_volumne, METH_FASTCALL | METH_KEYWORDS, PyDoc_STR("calculate_volumne(r, N, seed)\n--\n\n") /* docstring */},
    {"count_hits", (PyCFunction)CPyPy_count_hits, METH_FASTCALL | METH_KEYWORDS, PyDoc_STR("count_hits(r, N)\n--\n\n") /* docstring */},
    {NULL, NULL, 0, NULL}
};

int CPyExec_mypyc_calculate_volume(PyObject *module)
{
    PyObject* modname = NULL;
    modname = PyObject_GetAttrString((PyObject *)CPyModule_mypyc_calculate_volume__internal, "__name__");
    CPyStatic_globals = PyModule_GetDict(CPyModule_mypyc_calculate_volume__internal);
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
    Py_CLEAR(CPyModule_mypyc_calculate_volume__internal);
    Py_CLEAR(modname);
    return -1;
}
static struct PyModuleDef module = {
    PyModuleDef_HEAD_INIT,
    "mypyc_calculate_volume",
    NULL, /* docstring */
    0,       /* size of per-interpreter state of the module */
    module_methods,
    NULL,
};

PyMODINIT_FUNC PyInit_mypyc_calculate_volume(void)
{
    if (CPyModule_mypyc_calculate_volume__internal) {
        Py_INCREF(CPyModule_mypyc_calculate_volume__internal);
        return CPyModule_mypyc_calculate_volume__internal;
    }
    CPyModule_mypyc_calculate_volume__internal = PyModule_Create(&module);
    if (unlikely(CPyModule_mypyc_calculate_volume__internal == NULL))
        goto fail;
    if (CPyExec_mypyc_calculate_volume(CPyModule_mypyc_calculate_volume__internal) != 0)
        goto fail;
    return CPyModule_mypyc_calculate_volume__internal;
    fail:
    return NULL;
}

double CPyDef_calculate_volumne(double cpy_r_r, CPyTagged cpy_r_N, CPyTagged cpy_r_seed) {
    PyObject *cpy_r_r0;
    PyObject *cpy_r_r1;
    PyObject *cpy_r_r2;
    PyObject *cpy_r_r3;
    PyObject **cpy_r_r5;
    PyObject *cpy_r_r6;
    double cpy_r_r7;
    PyObject *cpy_r_r8;
    PyObject *cpy_r_r9;
    PyObject *cpy_r_r10;
    double cpy_r_r11;
    char cpy_r_r12;
    CPyTagged cpy_r_r13;
    PyObject *cpy_r_r14;
    double cpy_r_r15;
    char cpy_r_r16;
    double cpy_r_r17;
    double cpy_r_r18;
    char cpy_r_r19;
    PyObject *cpy_r_r20;
    char cpy_r_r21;
    PyObject *cpy_r_r22;
    char cpy_r_r23;
    double cpy_r_r24;
    double cpy_r_r25;
    cpy_r_r0 = CPyModule_random;
    cpy_r_r1 = CPyStatics[3]; /* 'seed' */
    cpy_r_r2 = CPyObject_GetAttr(cpy_r_r0, cpy_r_r1);
    if (unlikely(cpy_r_r2 == NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "calculate_volumne", 4, CPyStatic_globals);
        goto CPyL14;
    }
    CPyTagged_INCREF(cpy_r_seed);
    cpy_r_r3 = CPyTagged_StealAsObject(cpy_r_seed);
    PyObject *cpy_r_r4[1] = {cpy_r_r3};
    cpy_r_r5 = (PyObject **)&cpy_r_r4;
    cpy_r_r6 = PyObject_Vectorcall(cpy_r_r2, cpy_r_r5, 1, 0);
    CPy_DECREF(cpy_r_r2);
    if (unlikely(cpy_r_r6 == NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "calculate_volumne", 4, CPyStatic_globals);
        goto CPyL15;
    } else
        goto CPyL16;
CPyL2: ;
    CPy_DECREF(cpy_r_r3);
    cpy_r_r7 = 2.0 * cpy_r_r;
    cpy_r_r8 = PyFloat_FromDouble(cpy_r_r7);
    cpy_r_r9 = PyFloat_FromDouble(3.0);
    cpy_r_r10 = CPyNumber_Power(cpy_r_r8, cpy_r_r9);
    CPy_DECREF(cpy_r_r8);
    CPy_DECREF(cpy_r_r9);
    if (unlikely(cpy_r_r10 == NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "calculate_volumne", 5, CPyStatic_globals);
        goto CPyL14;
    }
    cpy_r_r11 = PyFloat_AsDouble(cpy_r_r10);
    if (cpy_r_r11 == -1.0 && PyErr_Occurred()) {
        CPy_TypeError("float", cpy_r_r10); cpy_r_r11 = -113.0;
    }
    CPy_DECREF(cpy_r_r10);
    cpy_r_r12 = cpy_r_r11 == -113.0;
    if (unlikely(cpy_r_r12)) goto CPyL5;
CPyL4: ;
    cpy_r_r13 = CPyDef_count_hits(cpy_r_r, cpy_r_N);
    if (unlikely(cpy_r_r13 == CPY_INT_TAG)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "calculate_volumne", 6, CPyStatic_globals);
        goto CPyL14;
    } else
        goto CPyL6;
CPyL5: ;
    cpy_r_r14 = PyErr_Occurred();
    if (unlikely(cpy_r_r14 != NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "calculate_volumne", 5, CPyStatic_globals);
        goto CPyL14;
    } else
        goto CPyL4;
CPyL6: ;
    cpy_r_r15 = CPyFloat_FromTagged(cpy_r_r13);
    CPyTagged_DECREF(cpy_r_r13);
    cpy_r_r16 = cpy_r_r15 == -113.0;
    if (unlikely(cpy_r_r16)) goto CPyL8;
CPyL7: ;
    cpy_r_r17 = cpy_r_r11 * cpy_r_r15;
    cpy_r_r18 = CPyFloat_FromTagged(cpy_r_N);
    cpy_r_r19 = cpy_r_r18 == -113.0;
    if (unlikely(cpy_r_r19)) {
        goto CPyL10;
    } else
        goto CPyL9;
CPyL8: ;
    cpy_r_r20 = PyErr_Occurred();
    if (unlikely(cpy_r_r20 != NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "calculate_volumne", 6, CPyStatic_globals);
        goto CPyL14;
    } else
        goto CPyL7;
CPyL9: ;
    cpy_r_r21 = cpy_r_r18 == 0.0;
    if (unlikely(cpy_r_r21)) {
        goto CPyL11;
    } else
        goto CPyL13;
CPyL10: ;
    cpy_r_r22 = PyErr_Occurred();
    if (unlikely(cpy_r_r22 != NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "calculate_volumne", 6, CPyStatic_globals);
        goto CPyL14;
    } else
        goto CPyL9;
CPyL11: ;
    PyErr_SetString(PyExc_ZeroDivisionError, "float division by zero");
    cpy_r_r23 = 0;
    if (unlikely(!cpy_r_r23)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "calculate_volumne", 6, CPyStatic_globals);
        goto CPyL14;
    }
    CPy_Unreachable();
CPyL13: ;
    cpy_r_r24 = cpy_r_r17 / cpy_r_r18;
    return cpy_r_r24;
CPyL14: ;
    cpy_r_r25 = -113.0;
    return cpy_r_r25;
CPyL15: ;
    CPy_DecRef(cpy_r_r3);
    goto CPyL14;
CPyL16: ;
    CPy_DECREF(cpy_r_r6);
    goto CPyL2;
}

PyObject *CPyPy_calculate_volumne(PyObject *self, PyObject *const *args, size_t nargs, PyObject *kwnames) {
    static const char * const kwlist[] = {"r", "N", "seed", 0};
    static CPyArg_Parser parser = {"OOO:calculate_volumne", kwlist, 0};
    PyObject *obj_r;
    PyObject *obj_N;
    PyObject *obj_seed;
    if (!CPyArg_ParseStackAndKeywordsSimple(args, nargs, kwnames, &parser, &obj_r, &obj_N, &obj_seed)) {
        return NULL;
    }
    double arg_r;
    arg_r = PyFloat_AsDouble(obj_r);
    if (arg_r == -1.0 && PyErr_Occurred()) {
        CPy_TypeError("float", obj_r); goto fail;
    }
    CPyTagged arg_N;
    if (likely(PyLong_Check(obj_N)))
        arg_N = CPyTagged_BorrowFromObject(obj_N);
    else {
        CPy_TypeError("int", obj_N); goto fail;
    }
    CPyTagged arg_seed;
    if (likely(PyLong_Check(obj_seed)))
        arg_seed = CPyTagged_BorrowFromObject(obj_seed);
    else {
        CPy_TypeError("int", obj_seed); goto fail;
    }
    double retval = CPyDef_calculate_volumne(arg_r, arg_N, arg_seed);
    if (retval == -113.0 && PyErr_Occurred()) {
        return NULL;
    }
    PyObject *retbox = PyFloat_FromDouble(retval);
    return retbox;
fail: ;
    CPy_AddTraceback("mypyc_calculate_volume.py", "calculate_volumne", 3, CPyStatic_globals);
    return NULL;
}

CPyTagged CPyDef_count_hits(double cpy_r_r, CPyTagged cpy_r_N) {
    CPyTagged cpy_r_hits;
    CPyTagged cpy_r_r0;
    CPyTagged cpy_r_i;
    int64_t cpy_r_r1;
    char cpy_r_r2;
    int64_t cpy_r_r3;
    char cpy_r_r4;
    char cpy_r_r5;
    char cpy_r_r6;
    double cpy_r_r7;
    PyObject *cpy_r_r8;
    PyObject *cpy_r_r9;
    PyObject *cpy_r_r10;
    PyObject *cpy_r_r11;
    PyObject *cpy_r_r12;
    PyObject **cpy_r_r14;
    PyObject *cpy_r_r15;
    double cpy_r_r16;
    char cpy_r_r17;
    double cpy_r_r18;
    PyObject *cpy_r_r19;
    PyObject *cpy_r_r20;
    PyObject *cpy_r_r21;
    PyObject *cpy_r_r22;
    PyObject *cpy_r_r23;
    PyObject *cpy_r_r24;
    PyObject **cpy_r_r26;
    PyObject *cpy_r_r27;
    double cpy_r_r28;
    char cpy_r_r29;
    double cpy_r_r30;
    PyObject *cpy_r_r31;
    PyObject *cpy_r_r32;
    PyObject *cpy_r_r33;
    PyObject *cpy_r_r34;
    PyObject *cpy_r_r35;
    PyObject *cpy_r_r36;
    PyObject **cpy_r_r38;
    PyObject *cpy_r_r39;
    double cpy_r_r40;
    char cpy_r_r41;
    PyObject *cpy_r_r42;
    PyObject *cpy_r_r43;
    PyObject *cpy_r_r44;
    PyObject *cpy_r_r45;
    double cpy_r_r46;
    char cpy_r_r47;
    PyObject *cpy_r_r48;
    PyObject *cpy_r_r49;
    PyObject *cpy_r_r50;
    PyObject *cpy_r_r51;
    double cpy_r_r52;
    char cpy_r_r53;
    double cpy_r_r54;
    double cpy_r_r55;
    char cpy_r_r56;
    PyObject *cpy_r_r57;
    PyObject *cpy_r_r58;
    PyObject *cpy_r_r59;
    PyObject *cpy_r_r60;
    double cpy_r_r61;
    char cpy_r_r62;
    PyObject *cpy_r_r63;
    PyObject *cpy_r_r64;
    PyObject *cpy_r_r65;
    PyObject *cpy_r_r66;
    double cpy_r_r67;
    char cpy_r_r68;
    double cpy_r_r69;
    double cpy_r_r70;
    char cpy_r_r71;
    PyObject *cpy_r_r72;
    CPyTagged cpy_r_r73;
    CPyTagged cpy_r_r74;
    CPyTagged cpy_r_r75;
    cpy_r_hits = 0;
    cpy_r_r0 = 2;
    CPyTagged_INCREF(cpy_r_r0);
    cpy_r_i = cpy_r_r0;
    CPyTagged_DECREF(cpy_r_i);
CPyL1: ;
    cpy_r_r1 = cpy_r_r0 & 1;
    cpy_r_r2 = cpy_r_r1 != 0;
    if (cpy_r_r2) goto CPyL3;
    cpy_r_r3 = cpy_r_N & 1;
    cpy_r_r4 = cpy_r_r3 != 0;
    if (!cpy_r_r4) goto CPyL4;
CPyL3: ;
    cpy_r_r5 = CPyTagged_IsLt_(cpy_r_r0, cpy_r_N);
    if (cpy_r_r5) {
        goto CPyL5;
    } else
        goto CPyL35;
CPyL4: ;
    cpy_r_r6 = (Py_ssize_t)cpy_r_r0 < (Py_ssize_t)cpy_r_N;
    if (!cpy_r_r6) goto CPyL35;
CPyL5: ;
    cpy_r_r7 = -cpy_r_r;
    cpy_r_r8 = CPyModule_random;
    cpy_r_r9 = CPyStatics[4]; /* 'uniform' */
    cpy_r_r10 = CPyObject_GetAttr(cpy_r_r8, cpy_r_r9);
    if (unlikely(cpy_r_r10 == NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "count_hits", 12, CPyStatic_globals);
        goto CPyL36;
    }
    cpy_r_r11 = PyFloat_FromDouble(cpy_r_r7);
    cpy_r_r12 = PyFloat_FromDouble(cpy_r_r);
    PyObject *cpy_r_r13[2] = {cpy_r_r11, cpy_r_r12};
    cpy_r_r14 = (PyObject **)&cpy_r_r13;
    cpy_r_r15 = PyObject_Vectorcall(cpy_r_r10, cpy_r_r14, 2, 0);
    CPy_DECREF(cpy_r_r10);
    if (unlikely(cpy_r_r15 == NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "count_hits", 12, CPyStatic_globals);
        goto CPyL37;
    }
    CPy_DECREF(cpy_r_r11);
    CPy_DECREF(cpy_r_r12);
    cpy_r_r16 = PyFloat_AsDouble(cpy_r_r15);
    if (cpy_r_r16 == -1.0 && PyErr_Occurred()) {
        CPy_TypeError("float", cpy_r_r15); cpy_r_r16 = -113.0;
    }
    CPy_DECREF(cpy_r_r15);
    cpy_r_r17 = cpy_r_r16 == -113.0;
    if (unlikely(cpy_r_r17)) goto CPyL9;
CPyL8: ;
    cpy_r_r18 = -cpy_r_r;
    cpy_r_r19 = CPyModule_random;
    cpy_r_r20 = CPyStatics[4]; /* 'uniform' */
    cpy_r_r21 = CPyObject_GetAttr(cpy_r_r19, cpy_r_r20);
    if (unlikely(cpy_r_r21 == NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "count_hits", 13, CPyStatic_globals);
        goto CPyL36;
    } else
        goto CPyL10;
CPyL9: ;
    cpy_r_r22 = PyErr_Occurred();
    if (unlikely(cpy_r_r22 != NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "count_hits", 12, CPyStatic_globals);
        goto CPyL36;
    } else
        goto CPyL8;
CPyL10: ;
    cpy_r_r23 = PyFloat_FromDouble(cpy_r_r18);
    cpy_r_r24 = PyFloat_FromDouble(cpy_r_r);
    PyObject *cpy_r_r25[2] = {cpy_r_r23, cpy_r_r24};
    cpy_r_r26 = (PyObject **)&cpy_r_r25;
    cpy_r_r27 = PyObject_Vectorcall(cpy_r_r21, cpy_r_r26, 2, 0);
    CPy_DECREF(cpy_r_r21);
    if (unlikely(cpy_r_r27 == NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "count_hits", 13, CPyStatic_globals);
        goto CPyL38;
    }
    CPy_DECREF(cpy_r_r23);
    CPy_DECREF(cpy_r_r24);
    cpy_r_r28 = PyFloat_AsDouble(cpy_r_r27);
    if (cpy_r_r28 == -1.0 && PyErr_Occurred()) {
        CPy_TypeError("float", cpy_r_r27); cpy_r_r28 = -113.0;
    }
    CPy_DECREF(cpy_r_r27);
    cpy_r_r29 = cpy_r_r28 == -113.0;
    if (unlikely(cpy_r_r29)) goto CPyL13;
CPyL12: ;
    cpy_r_r30 = -cpy_r_r;
    cpy_r_r31 = CPyModule_random;
    cpy_r_r32 = CPyStatics[4]; /* 'uniform' */
    cpy_r_r33 = CPyObject_GetAttr(cpy_r_r31, cpy_r_r32);
    if (unlikely(cpy_r_r33 == NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "count_hits", 14, CPyStatic_globals);
        goto CPyL36;
    } else
        goto CPyL14;
CPyL13: ;
    cpy_r_r34 = PyErr_Occurred();
    if (unlikely(cpy_r_r34 != NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "count_hits", 13, CPyStatic_globals);
        goto CPyL36;
    } else
        goto CPyL12;
CPyL14: ;
    cpy_r_r35 = PyFloat_FromDouble(cpy_r_r30);
    cpy_r_r36 = PyFloat_FromDouble(cpy_r_r);
    PyObject *cpy_r_r37[2] = {cpy_r_r35, cpy_r_r36};
    cpy_r_r38 = (PyObject **)&cpy_r_r37;
    cpy_r_r39 = PyObject_Vectorcall(cpy_r_r33, cpy_r_r38, 2, 0);
    CPy_DECREF(cpy_r_r33);
    if (unlikely(cpy_r_r39 == NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "count_hits", 14, CPyStatic_globals);
        goto CPyL39;
    }
    CPy_DECREF(cpy_r_r35);
    CPy_DECREF(cpy_r_r36);
    cpy_r_r40 = PyFloat_AsDouble(cpy_r_r39);
    if (cpy_r_r40 == -1.0 && PyErr_Occurred()) {
        CPy_TypeError("float", cpy_r_r39); cpy_r_r40 = -113.0;
    }
    CPy_DECREF(cpy_r_r39);
    cpy_r_r41 = cpy_r_r40 == -113.0;
    if (unlikely(cpy_r_r41)) goto CPyL17;
CPyL16: ;
    cpy_r_r42 = PyFloat_FromDouble(cpy_r_r16);
    cpy_r_r43 = PyFloat_FromDouble(2.0);
    cpy_r_r44 = CPyNumber_Power(cpy_r_r42, cpy_r_r43);
    CPy_DECREF(cpy_r_r42);
    CPy_DECREF(cpy_r_r43);
    if (unlikely(cpy_r_r44 == NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "count_hits", 15, CPyStatic_globals);
        goto CPyL36;
    } else
        goto CPyL18;
CPyL17: ;
    cpy_r_r45 = PyErr_Occurred();
    if (unlikely(cpy_r_r45 != NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "count_hits", 14, CPyStatic_globals);
        goto CPyL36;
    } else
        goto CPyL16;
CPyL18: ;
    cpy_r_r46 = PyFloat_AsDouble(cpy_r_r44);
    if (cpy_r_r46 == -1.0 && PyErr_Occurred()) {
        CPy_TypeError("float", cpy_r_r44); cpy_r_r46 = -113.0;
    }
    CPy_DECREF(cpy_r_r44);
    cpy_r_r47 = cpy_r_r46 == -113.0;
    if (unlikely(cpy_r_r47)) goto CPyL20;
CPyL19: ;
    cpy_r_r48 = PyFloat_FromDouble(cpy_r_r28);
    cpy_r_r49 = PyFloat_FromDouble(2.0);
    cpy_r_r50 = CPyNumber_Power(cpy_r_r48, cpy_r_r49);
    CPy_DECREF(cpy_r_r48);
    CPy_DECREF(cpy_r_r49);
    if (unlikely(cpy_r_r50 == NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "count_hits", 15, CPyStatic_globals);
        goto CPyL36;
    } else
        goto CPyL21;
CPyL20: ;
    cpy_r_r51 = PyErr_Occurred();
    if (unlikely(cpy_r_r51 != NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "count_hits", 15, CPyStatic_globals);
        goto CPyL36;
    } else
        goto CPyL19;
CPyL21: ;
    cpy_r_r52 = PyFloat_AsDouble(cpy_r_r50);
    if (cpy_r_r52 == -1.0 && PyErr_Occurred()) {
        CPy_TypeError("float", cpy_r_r50); cpy_r_r52 = -113.0;
    }
    CPy_DECREF(cpy_r_r50);
    cpy_r_r53 = cpy_r_r52 == -113.0;
    if (unlikely(cpy_r_r53)) goto CPyL23;
CPyL22: ;
    cpy_r_r54 = cpy_r_r46 + cpy_r_r52;
    cpy_r_r55 = cpy_r_r * cpy_r_r;
    cpy_r_r56 = cpy_r_r54 <= cpy_r_r55;
    if (cpy_r_r56) {
        goto CPyL24;
    } else
        goto CPyL32;
CPyL23: ;
    cpy_r_r57 = PyErr_Occurred();
    if (unlikely(cpy_r_r57 != NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "count_hits", 15, CPyStatic_globals);
        goto CPyL36;
    } else
        goto CPyL22;
CPyL24: ;
    cpy_r_r58 = PyFloat_FromDouble(cpy_r_r16);
    cpy_r_r59 = PyFloat_FromDouble(2.0);
    cpy_r_r60 = CPyNumber_Power(cpy_r_r58, cpy_r_r59);
    CPy_DECREF(cpy_r_r58);
    CPy_DECREF(cpy_r_r59);
    if (unlikely(cpy_r_r60 == NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "count_hits", 15, CPyStatic_globals);
        goto CPyL36;
    }
    cpy_r_r61 = PyFloat_AsDouble(cpy_r_r60);
    if (cpy_r_r61 == -1.0 && PyErr_Occurred()) {
        CPy_TypeError("float", cpy_r_r60); cpy_r_r61 = -113.0;
    }
    CPy_DECREF(cpy_r_r60);
    cpy_r_r62 = cpy_r_r61 == -113.0;
    if (unlikely(cpy_r_r62)) goto CPyL27;
CPyL26: ;
    cpy_r_r63 = PyFloat_FromDouble(cpy_r_r40);
    cpy_r_r64 = PyFloat_FromDouble(2.0);
    cpy_r_r65 = CPyNumber_Power(cpy_r_r63, cpy_r_r64);
    CPy_DECREF(cpy_r_r63);
    CPy_DECREF(cpy_r_r64);
    if (unlikely(cpy_r_r65 == NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "count_hits", 15, CPyStatic_globals);
        goto CPyL36;
    } else
        goto CPyL28;
CPyL27: ;
    cpy_r_r66 = PyErr_Occurred();
    if (unlikely(cpy_r_r66 != NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "count_hits", 15, CPyStatic_globals);
        goto CPyL36;
    } else
        goto CPyL26;
CPyL28: ;
    cpy_r_r67 = PyFloat_AsDouble(cpy_r_r65);
    if (cpy_r_r67 == -1.0 && PyErr_Occurred()) {
        CPy_TypeError("float", cpy_r_r65); cpy_r_r67 = -113.0;
    }
    CPy_DECREF(cpy_r_r65);
    cpy_r_r68 = cpy_r_r67 == -113.0;
    if (unlikely(cpy_r_r68)) goto CPyL30;
CPyL29: ;
    cpy_r_r69 = cpy_r_r61 + cpy_r_r67;
    cpy_r_r70 = cpy_r_r * cpy_r_r;
    cpy_r_r71 = cpy_r_r69 <= cpy_r_r70;
    if (cpy_r_r71) {
        goto CPyL31;
    } else
        goto CPyL32;
CPyL30: ;
    cpy_r_r72 = PyErr_Occurred();
    if (unlikely(cpy_r_r72 != NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "count_hits", 15, CPyStatic_globals);
        goto CPyL36;
    } else
        goto CPyL29;
CPyL31: ;
    cpy_r_r73 = CPyTagged_Add(cpy_r_hits, 2);
    CPyTagged_DECREF(cpy_r_hits);
    cpy_r_hits = cpy_r_r73;
CPyL32: ;
    cpy_r_r74 = CPyTagged_Add(cpy_r_r0, 2);
    CPyTagged_DECREF(cpy_r_r0);
    CPyTagged_INCREF(cpy_r_r74);
    cpy_r_r0 = cpy_r_r74;
    cpy_r_i = cpy_r_r74;
    CPyTagged_DECREF(cpy_r_i);
    goto CPyL1;
CPyL33: ;
    return cpy_r_hits;
CPyL34: ;
    cpy_r_r75 = CPY_INT_TAG;
    return cpy_r_r75;
CPyL35: ;
    CPyTagged_DECREF(cpy_r_r0);
    goto CPyL33;
CPyL36: ;
    CPyTagged_DecRef(cpy_r_hits);
    CPyTagged_DecRef(cpy_r_r0);
    goto CPyL34;
CPyL37: ;
    CPyTagged_DecRef(cpy_r_hits);
    CPyTagged_DecRef(cpy_r_r0);
    CPy_DecRef(cpy_r_r11);
    CPy_DecRef(cpy_r_r12);
    goto CPyL34;
CPyL38: ;
    CPyTagged_DecRef(cpy_r_hits);
    CPyTagged_DecRef(cpy_r_r0);
    CPy_DecRef(cpy_r_r23);
    CPy_DecRef(cpy_r_r24);
    goto CPyL34;
CPyL39: ;
    CPyTagged_DecRef(cpy_r_hits);
    CPyTagged_DecRef(cpy_r_r0);
    CPy_DecRef(cpy_r_r35);
    CPy_DecRef(cpy_r_r36);
    goto CPyL34;
}

PyObject *CPyPy_count_hits(PyObject *self, PyObject *const *args, size_t nargs, PyObject *kwnames) {
    static const char * const kwlist[] = {"r", "N", 0};
    static CPyArg_Parser parser = {"OO:count_hits", kwlist, 0};
    PyObject *obj_r;
    PyObject *obj_N;
    if (!CPyArg_ParseStackAndKeywordsSimple(args, nargs, kwnames, &parser, &obj_r, &obj_N)) {
        return NULL;
    }
    double arg_r;
    arg_r = PyFloat_AsDouble(obj_r);
    if (arg_r == -1.0 && PyErr_Occurred()) {
        CPy_TypeError("float", obj_r); goto fail;
    }
    CPyTagged arg_N;
    if (likely(PyLong_Check(obj_N)))
        arg_N = CPyTagged_BorrowFromObject(obj_N);
    else {
        CPy_TypeError("int", obj_N); goto fail;
    }
    CPyTagged retval = CPyDef_count_hits(arg_r, arg_N);
    if (retval == CPY_INT_TAG) {
        return NULL;
    }
    PyObject *retbox = CPyTagged_StealAsObject(retval);
    return retbox;
fail: ;
    CPy_AddTraceback("mypyc_calculate_volume.py", "count_hits", 9, CPyStatic_globals);
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
    cpy_r_r3 = CPyStatics[5]; /* 'builtins' */
    cpy_r_r4 = PyImport_Import(cpy_r_r3);
    if (unlikely(cpy_r_r4 == NULL)) {
        CPy_AddTraceback("mypyc_calculate_volume.py", "<module>", -1, CPyStatic_globals);
        goto CPyL5;
    }
    CPyModule_builtins = cpy_r_r4;
    CPy_INCREF(CPyModule_builtins);
    CPy_DECREF(cpy_r_r4);
CPyL3: ;
    cpy_r_r5 = (PyObject **)&CPyModule_random;
    PyObject **cpy_r_r6[1] = {cpy_r_r5};
    cpy_r_r7 = (void *)&cpy_r_r6;
    int64_t cpy_r_r8[1] = {1};
    cpy_r_r9 = (void *)&cpy_r_r8;
    cpy_r_r10 = CPyStatics[10]; /* (('random', 'random', 'random'),) */
    cpy_r_r11 = CPyStatic_globals;
    cpy_r_r12 = CPyStatics[7]; /* 'mypyc_calculate_volume.py' */
    cpy_r_r13 = CPyStatics[8]; /* '<module>' */
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
    CPyModule_mypyc_calculate_volume = Py_None;
    CPyModule_builtins = Py_None;
    CPyModule_random = Py_None;
    if (CPyStatics_Initialize(CPyStatics, CPyLit_Str, CPyLit_Bytes, CPyLit_Int, CPyLit_Float, CPyLit_Complex, CPyLit_Tuple, CPyLit_FrozenSet) < 0) {
        return -1;
    }
    is_initialized = 1;
    return 0;
}

PyObject *CPyStatics[11];
const char * const CPyLit_Str[] = {
    "\006\004seed\auniform\bbuiltins\006random\031mypyc_calculate_volume.py\b<module>",
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
const int CPyLit_Tuple[] = {2, 3, 6, 6, 6, 1, 9};
const int CPyLit_FrozenSet[] = {0};
CPyModule *CPyModule_mypyc_calculate_volume__internal = NULL;
CPyModule *CPyModule_mypyc_calculate_volume;
PyObject *CPyStatic_globals;
CPyModule *CPyModule_builtins;
CPyModule *CPyModule_random;
double CPyDef_calculate_volumne(double cpy_r_r, CPyTagged cpy_r_N, CPyTagged cpy_r_seed);
PyObject *CPyPy_calculate_volumne(PyObject *self, PyObject *const *args, size_t nargs, PyObject *kwnames);
CPyTagged CPyDef_count_hits(double cpy_r_r, CPyTagged cpy_r_N);
PyObject *CPyPy_count_hits(PyObject *self, PyObject *const *args, size_t nargs, PyObject *kwnames);
char CPyDef___top_level__(void);
