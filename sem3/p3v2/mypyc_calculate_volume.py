import random

def calculate_volumne(r: float, N: int, seed: int) -> float:
    random.seed(seed)
    cube_volume : float = (2*r)**3
    volume : float = cube_volume * count_hits(r, N)/N
    return volume

def count_hits(r:float, N: int) -> int:
    hits : int = 0
    for i in range(1,N):
        x : float = random.uniform(-r,r)
        y : float = random.uniform(-r,r)
        z : float = random.uniform(-r,r)
        if (x**2 + y**2 <= r*r and x**2 + z**2 <= r*r): hits +=1
    return hits
