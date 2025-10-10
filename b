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

class Heap {
private:
    int* arr;
    int heapSize;
    int arrSize;

    int left(int i) { return 2 * i + 1; }
    int right(int i) { return 2 * i + 2; }
    int parent(int i) { return (i - 1) / 2; }

public:
    Heap(int* newArr, int heapSize, int arrSize) {
        this->heapSize = heapSize;
        this->arrSize = arrSize;
        arr = new int[arrSize];
        for (int i = 0; i < arrSize; i++) arr[i] = newArr[i];
    }

    ~Heap() { delete[] arr; }

    void heapify(int i) {
        int largest = i;
        int l = left(i);
        int r = right(i);
        if (l < heapSize && arr[l] > arr[largest]) largest = l;
        if (r < heapSize && arr[r] > arr[largest]) largest = r;
        if (largest != i) {
            swap(arr[i], arr[largest]);
            heapify(largest);
        }
    }

    void buildHeap() {
        for (int i = (heapSize - 2) / 2; i >= 0; i--) heapify(i);
    }

    int extractMax() {
        if (heapSize <= 0) return 0;
        int root = arr[0];
        arr[0] = arr[heapSize - 1];
        heapSize--;
        heapify(0);
        return root;
    }

    void insertInHeap(int val) {
        heapSize++;
        arr[heapSize - 1] = val;
        int i = heapSize - 1;
        while (i != 0 && arr[parent(i)] < arr[i]) {
            swap(arr[i], arr[parent(i)]);
            i = parent(i);
        }
    }

    int size() { return heapSize; }
};

int main() {
    int N;
    cin >> N;              
    int* arr = new int[N];  
    for (int i = 0; i < N; i++) cin >> arr[i];

    Heap h(arr, N, N);
    h.buildHeap();

    while (h.size() > 1) {
        int a = h.extractMax();
        int b = h.extractMax();
        if (a != b) h.insertInHeap(a - b);  
    }

    cout << h.extractMax();  
    delete[] arr;
}
