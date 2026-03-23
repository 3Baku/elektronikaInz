import numpy as np
from numba import njit

@njit
def calculate_volumne(r, N, seed):
    np.random.seed(seed)
    cube_volume = (2*r)**3
    volume = cube_volume * count_hits(r, N)/N
    return volume
@njit
def count_hits(r, N):
    hits = 0
    for i in range(1,N):
        x = np.random.uniform(-r,r)
        y = np.random.uniform(-r,r)
        z = np.random.uniform(-r,r)
        if (x**2 + y**2 <= r*r and x**2 + z**2 <= r*r): hits +=1
    return hits
