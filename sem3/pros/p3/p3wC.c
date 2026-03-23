#include <stdlib.h>
#include <math.h>

__declspec(dllexport) double calculate_steinmetz_c(int n, double r) {
    int hits = 0;
    double x, y, z;
    double r_sq = r * r;

    for (int i = 0; i < n; i++) {
        x = ((double)rand() / RAND_MAX) * 2.0 * r - r;
        y = ((double)rand() / RAND_MAX) * 2.0 * r - r;
        z = ((double)rand() / RAND_MAX) * 2.0 * r - r;

        if ((x * x + y * y <= r_sq) && (x * x + z * z <= r_sq)) {
            hits++;
        }
    }
    return pow(2.0 * r, 3.0) * ((double)hits / n);
}