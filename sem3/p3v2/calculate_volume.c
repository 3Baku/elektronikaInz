#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int count_hits(float r, int *hits, int N);
float randomFloat(float min, float max);
int calculate_volume(float *volume, float r, int N, int seed);

int main() {
    return 0;
}
float randomFloat(float min, float max){
    return (float)(rand()) / (float)(RAND_MAX) * (max - min) + min;
}
int calculate_volume(float *volume, float r, int N, int seed){
    srand(seed);
    float cube_volume = pow((2*r), 3);
    int hits = 0;
    count_hits(r, &hits, N);
    *volume = cube_volume * (float) hits/N;
    return 0;
}
int count_hits(float r, int *hits, int N){
    for(int i = 0; i < N; i++){
        float x = randomFloat(-r, r);
        float y = randomFloat(-r, r);
        float z = randomFloat(-r, r);
        if (((x*x + y*y) <= r*r) && ((x*x + z*z) <= r*r))
            (*hits)++;
    }
    return 0;
}