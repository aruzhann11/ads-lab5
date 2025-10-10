Проблема Б: Игра в камень
У нас есть набор камней, каждый из которых имеет положительный целочисленный вес.

С каждым ходом мы выбираем два самых тяжелых камня и разбиваем их друг о друга. Предположим, что у камней есть грузы 
 и 
 с 
. Если 
, оба камня полностью разрушены. Если 
, камень веса 
 полностью разрушается, и камень тяжести 
 имеет новый вес 
.

В конце концов, остается не более 1 камня на камне. Выведите вес этого камня (или 0, если камней не осталось).

Формат ввода
В первой строке записано целое число 
 (
) - количество камней.

Вторая строка содержит 
 Целых чисел 
 (
) - вес каждого камня.

Формат вывода
Выведите вес оставшегося камня, или 0, если никого не осталось.

#include <iostream>
using namespace std;

const int N = 100005;
long long heapArr[N];
int heapSize = 0;

void push(long long x) {
    heapArr[++heapSize] = x;
    int i = heapSize;
    while (i > 1 && heapArr[i] > heapArr[i / 2]) {
        long long tmp = heapArr[i];
        heapArr[i] = heapArr[i / 2];
        heapArr[i / 2] = tmp;
        i /= 2;
    }
}

long long pop() {
    long long maxVal = heapArr[1];
    heapArr[1] = heapArr[heapSize--];
    int i = 1;
    while (true) {
        int left = i * 2;
        int right = i * 2 + 1;
        int largest = i;

        if (left <= heapSize && heapArr[left] > heapArr[largest])
            largest = left;
        if (right <= heapSize && heapArr[right] > heapArr[largest])
            largest = right;

        if (largest == i) break;

        long long tmp = heapArr[i];
        heapArr[i] = heapArr[largest];
        heapArr[largest] = tmp;

        i = largest;
    }
    return maxVal;
}

int main() {
    int n;
    cin >> n;

    for (int i = 0; i < n; i++) {
        long long x;
        cin >> x;
        push(x);
    }

    while (heapSize > 1) {
        long long a = pop(); 
        long long b = pop(); 
        if (a != b) {
            push(a - b); 
        }
    }

    cout << (heapSize == 1 ? heapArr[1] : 0) << endl;
    return 0;
}
