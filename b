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

class MaxHeap {
private:
    int heapSize;
    int arrSize;
    long long* arr;

    int parent(int i) {
      return (i - 1) / 2; 
    }
    int left(int i) {
      return 2 * i + 1; 
    }
    int right(int i) { 
      return 2 * i + 2;
     }

public:
    MaxHeap(int arrSize) {
        this->heapSize = 0;
        this->arrSize = arrSize;
        arr = new long long[arrSize];
    }

    ~MaxHeap() {
         delete[] arr; 
        }

    void heapify(int i) {
        int smallest = i;
        int l = left(i);
        int r = right(i);

        if (l < heapSize && arr[l] > arr[smallest]) smallest = l;
        if (r < heapSize && arr[r] > arr[smallest]) smallest = r;

        if (smallest != i) {
            swap(arr[i], arr[smallest]);
            heapify(smallest);
        }
    }

    void unheapify(int i) {
        int p = parent(i);
        if (p >= 0 && arr[p] < arr[i]) {
            swap(arr[p], arr[i]);
            unheapify(p);
        }
    }

    void Insert(long long val) {
        arr[heapSize] = val;
        heapSize++;
        unheapify(heapSize - 1);
    }

    long long extractMax() {
        long long root = arr[0];
        arr[0] = arr[heapSize - 1];
        heapSize--;
        heapify(0);
        return root;
    }

    long long top() { 
        return arr[0]; 
    }

    int getsize() { 
        return heapSize; 
    }
};

int main() {
    int n;
    cin >> n;
    long long arr[n];
    MaxHeap h(1000);

    for (int i = 0; i < n; i++) {
        cin >> arr[i];
        h.Insert(arr[i]);
    }

    while (h.getsize() > 1) {
        long long a = h.extractMax();
        long long b = h.extractMax();
        if(a!=b){
            h.Insert(a-b);
        }
    }
     if(h.getsize()==0)
        cout<<0;
        else
        cout<<h.top();
}
