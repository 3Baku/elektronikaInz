
import random

def calculate_steinmetz_mypyc(n: int, r: float) -> float:
    hits: int = 0
    r_sq: float = r * r
    x: float
    y: float
    z: float
    
    for _ in range(n):
        x = random.uniform(-r, r)
        y = random.uniform(-r, r)
        z = random.uniform(-r, r)
        
        if (x*x + y*y <= r_sq) and (x*x + z*z <= r_sq):
            hits += 1
            
    return (2.0*r)**3 * (hits / n)