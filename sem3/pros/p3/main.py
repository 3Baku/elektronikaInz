import random
import time
import ctypes
import os
import matplotlib.pyplot as plt
from numba import jit

try:
    import steinmetz_mypyc
except ImportError:
    print("Brak modułu Mypyc. Upewnij się, że skompilowałeś go komendą: mypyc steinmetz_mypyc.py")
    steinmetz_mypyc = None

def steinmetz_python(n, r):
    hits = 0
    r_sq = r**2
    for _ in range(n):
        x = random.uniform(-r, r)
        y = random.uniform(-r, r)
        z = random.uniform(-r, r)
        if (x**2 + y**2 <= r_sq) and (x**2 + z**2 <= r_sq):
            hits += 1
    return (2*r)**3 * (hits / n)

@jit(nopython=True)
def steinmetz_numba(n, r):
    hits = 0
    r_sq = r**2
    for _ in range(n):
        x = random.uniform(-r, r)
        y = random.uniform(-r, r)
        z = random.uniform(-r, r)
        if (x**2 + y**2 <= r_sq) and (x**2 + z**2 <= r_sq):
            hits += 1
    return (2*r)**3 * (hits / n)

def load_c_lib():
    dll_path = os.path.abspath("libsteinmetz.dll")
    if not os.path.exists(dll_path):
        return None
    try:
        lib = ctypes.CDLL(dll_path)
        lib.calculate_steinmetz_c.argtypes = [ctypes.c_int, ctypes.c_double]
        lib.calculate_steinmetz_c.restype = ctypes.c_double
        return lib.calculate_steinmetz_c
    except Exception as e:
        print(f"Błąd ładowania DLL: {e}")
        return None

def measure_time(func, n, r):
    start = time.time()
    func(n, r)
    end = time.time()
    return end - start

def run_tests():
    c_func = load_c_lib()
    if not c_func:
        print("UWAGA: Nie znaleziono 'libsteinmetz.dll'. Wyniki Ctypes będą pominięte.")
    
    n_values = range(5000000, 10000001, 1000000)
    r_values = [1.0, 2.0]
    
    for r in r_values:
        print(f"\n--- Testy dla promienia r = {r} ---")
        acc_c = []
        acc_numba = []
        acc_mypyc = []
        
        print(f"{'N':<10} {'Python[s]':<10} {'C[s]':<10} {'Numba[s]':<10} {'Mypyc[s]':<10}")
        
        for n in n_values:
            # 1. Python (Baza)
            t_py = measure_time(steinmetz_python, n, r)
            
            # 2. Ctypes (C)
            if c_func:
                t_c = measure_time(c_func, n, r)
                acc_c.append(t_py / t_c)
            else:
                t_c = 0.0
                acc_c.append(0)

            # 3. Numba
            t_num = measure_time(steinmetz_numba, n, r)
            acc_numba.append(t_py / t_num)
            
            # 4. Mypyc
            if steinmetz_mypyc:
                t_mypyc = measure_time(steinmetz_mypyc.calculate_steinmetz_mypyc, n, r)
                acc_mypyc.append(t_py / t_mypyc)
            else:    
                t_mypyc = 0.0
                acc_mypyc.append(0)

            print(f"{n:<10} {t_py:<10.4f} {t_c:<10.4f} {t_num:<10.4f} {t_mypyc:<10.4f}")

        plt.figure(figsize=(10, 6))
        if c_func:
            plt.plot(list(n_values), acc_c, label='C (Ctypes)', marker='o')
        plt.plot(list(n_values), acc_numba, label='Numba', marker='x')
        if steinmetz_mypyc:
            plt.plot(list(n_values), acc_mypyc, label='Mypyc', marker='s')
            
        plt.xlabel('Liczba iteracji N')
        plt.ylabel('Przyspieszenie (t_py / t_opt)')
        plt.title(f'Współczynnik przyspieszenia P dla r={r}')
        plt.legend()
        plt.grid(True)
        plt.savefig(f'wykres_windows_r_{r}.png')
        print(f"Wykres zapisano: wykres_windows_r_{r}.png")

if __name__ == '__main__':
    run_tests()