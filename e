Задача E: K-я сумма
Нурдана обожает печенье! Она хранит все печенье в отдельных коробках, но мама разрешает ей хранить только 
 Коробки. Ее папа является помощником в этом деле. Он дарит ей коробку, в которой есть 
 Печенье. Помогите ей посчитать, сколько печенья она может съесть?

Формат ввода
В первой строке записаны два целых числа 
 и 
 (1 
 
, 
 
 
). Каждый из следующих 
 lines содержит одну команду.

Существует два типа команд:

вставка 
 - папа дарит коробку с 
 Файлы cookie (
)

print - распечатать максимальное количество печенья, которое может иметь Нурдана

Формат вывода
Для каждого запроса типа print вывести максимальное количество файлов cookie, если считать не более 
 Коробки.


 #include <iostream>
#include <string>
using namespace std;

class MinHeap {
private:
    long long *arr;
    int size;
    int capacity;

    void swap(long long &a, long long &b) {
        long long t = a; a = b; b = t;
    }

    void heapify_up(int i) {
        while (i > 0) {
            int p = (i - 1) / 2;
            if (arr[p] > arr[i]) {
                swap(arr[p], arr[i]);
                i = p;
            } else break;
        }
    }

    void heapify_down(int i) {
        while (true) {
            int l = 2 * i + 1;
            int r = 2 * i + 2;
            int smallest = i;
            if (l < size && arr[l] < arr[smallest]) smallest = l;
            if (r < size && arr[r] < arr[smallest]) smallest = r;
            if (smallest != i) {
                swap(arr[i], arr[smallest]);
                i = smallest;
            } else break;
        }
    }

public:
    MinHeap(int cap) {
        arr = new long long[cap];
        size = 0;
        capacity = cap;
    }
    ~MinHeap() { delete[] arr; }

    void push(long long x) {
        arr[size] = x;
        heapify_up(size);
        size++;
    }

    void pop() {
        if (size == 0) return;
        arr[0] = arr[size - 1];
        size--;
        heapify_down(0);
    }

    long long top() { return arr[0]; }
    int sz() { return size; }
    bool empty() { return size == 0; }
};


int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int q, k;
    cin >> q >> k;

    MinHeap heap(q + 5);
    long long sum = 0;

    for (int i = 0; i < q; i++) {
        string cmd;
        cin >> cmd;

        if (cmd == "insert") {
            long long n;
            cin >> n;
            if (heap.sz() < k) {
                heap.push(n);
                sum += n;
            } else if (n > heap.top()) {
                sum -= heap.top();
                heap.pop();
                heap.push(n);
                sum += n;
            }
        } else if (cmd == "print") {
            cout << sum << "\n";
        }
    }

    return 0;
}
