#include<stdio.h>

int fibo(int n){
    int a = 0;
    int b = 1;
    int nxt;
    int i;
    for (i = 0; i < n; i++) {
        nxt = a + b;
        printf("%d ", b);
        a = b;
        b = nxt;
    }
}

int main(){
    int var;
    scanf("%d", &var);
    
    fibo(var);

    return 0;
}
