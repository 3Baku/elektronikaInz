import mypyc_calculate_volume
import numba_calculate_volume
import calculate_volume

import matplotlib.pyplot as plt
import numpy as np
import time
import ctypes 


def measure_one_time(func, r : float, N: int, seed: int) -> float:
    start_time = time.time()
    func(r, N, seed)
    end_time = time.time()
    return end_time - start_time

def measure_times(ctypes_calculate_volume, N_min: int, N_max: int, num_of_N: int, r_min: float, r_max: float, num_of_r: int, seed: int) -> None:
    ctypes_volume = ctypes.c_float() 
    
    N_array = np.linspace(N_min, N_max, num_of_N).astype(int)
    r_array = np.linspace(r_min, r_max, num_of_r)
    times_ctypes = np.zeros((num_of_r, num_of_N))
    times_mypyc = np.zeros((num_of_r, num_of_N))
    times_python = np.zeros((num_of_r, num_of_N))
    times_numba = np.zeros((num_of_r, num_of_N))

    for i in range(0,num_of_r):
        r = r_array[i]
        for j in range(0,num_of_N):
            N = N_array[j]
            c_func_wrapper = lambda r_val, N_val, s_val: ctypes_calculate_volume.calculate_volume(ctypes.byref(ctypes_volume), r_val, N_val, s_val)
            times_ctypes[i][j] = measure_one_time(c_func_wrapper, r, int(N), seed)
            times_mypyc[i][j] = measure_one_time(mypyc_calculate_volume.calculate_volumne, r, N, seed)
            times_python[i][j] = measure_one_time(calculate_volume.calculate_volumne, r, N, seed)
            times_numba[i][j] = measure_one_time(numba_calculate_volume.calculate_volumne, r, N, seed)
            print(f"I have finished N number {j}")
    times_concatenated = [times_ctypes, times_mypyc, times_python, times_numba]
    return times_concatenated
   
def power_factor(times_concatenated):
    ctypes_power = times_concatenated[2]/times_concatenated[0]
    mypyc_power = times_concatenated[2]/times_concatenated[1]
    numba_power = times_concatenated[2]/times_concatenated[3]
    power_concatenated = [ctypes_power, mypyc_power,numba_power]
    return power_concatenated

def power_plots(N_array, power_concatenated, indeks_r):
    labels = ['Ctypes', 'Mypyc', 'Numba']
    
    plt.figure(figsize=(10, 6))
    
    for i, data in enumerate(power_concatenated):
        plt.semilogy(N_array, data[indeks_r], label=labels[i], marker='o')
        
    plt.xlabel('N')
    plt.ylabel('Współczynnik wzmocnienia')
    plt.title(f'Wzmocnienie względem Pythona (dla r[{indeks_r}])')
    plt.legend()
    plt.grid(True)
    plt.show()

    
def import_with_ctypes(shared_lib_path):
    lib = ctypes.CDLL(shared_lib_path)
    
    lib.calculate_volume.argtypes = [
        ctypes.POINTER(ctypes.c_float),
        ctypes.c_float,
        ctypes.c_int,
        ctypes.c_int
    ]
    lib.calculate_volume.restype = ctypes.c_int

    return lib


if __name__ == "__main__":
    seed = 10
    r_min, r_max, num_of_r = 1.0, 2.0, 2 #20_000_000.0, 20_000_000.0, 1#1.0, 2.0, 2
    N_min, N_max, num_of_N = 100_000, 1_000_000, 5

    ctypes_lib = import_with_ctypes("./ctypes_calculate_volume.dll")
    times_results = measure_times(ctypes_lib, N_min, N_max, num_of_N, r_min, r_max, num_of_r, seed)
    speedup_results = power_factor(times_results)

    N_array = np.linspace(N_min, N_max, num_of_N).astype(int)

    for i in range(num_of_r):
        power_plots(N_array, speedup_results, indeks_r=i)

    