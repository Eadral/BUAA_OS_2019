
int fibo(int n) {
    int a = 0;
    int b = 1;
    int next = 1;
    while (n--) {
        next = a + b;
        a = b;
        b = next;
    }
    return a;
}
