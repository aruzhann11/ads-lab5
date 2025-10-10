Проблема D: Экспериментируйте со смесями
Марк проводит эксперимент со смесями разной плотности. Для своего эксперимента он хочет, чтобы все смеси имели плотность 
.

Для получения комбинированной смеси он использует следующую формулу: 
 = 
 +  
где 
 – плотность новой смеси, 
 является наименьшей плотностью среди всех смесей и  
 является второй наименьшей плотностью среди всех смесей.

Марк повторяет смешивание до тех пор, пока не получит все смеси с плотностью 
.

Вам даны плотности смесей. Сколько раз Марк должен смешивать свои смеси, чтобы получить плотности всех смесей 
?

Формат ввода
Первая строка состоит из целых чисел 
 и 
 (
, 
), количество смесей и минимально необходимую плотность соответственно.

Следующая строка содержит 
 целые числа через пробел 
 (
), описывающие плотности смесей.

Формат вывода
Выведите количество операций, необходимых для создания всех плотностей 
. Если это невозможно, распечатайте 
.

 #include <iostream>
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
            int parent = (i - 1) / 2;
            if (arr[parent] > arr[i]) {
                swap(arr[parent], arr[i]);
                i = parent;
            } else break;
        }
    }

    void heapify_down(int i) {
        while (true) {
            int left = 2 * i + 1, right = 2 * i + 2, smallest = i;
            if (left < size && arr[left] < arr[smallest]) smallest = left;
            if (right < size && arr[right] < arr[smallest]) smallest = right;
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

    ~MinHeap() {
        delete[] arr;
    }

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

    long long top() {
        return arr[0];
    }

    int sz() {
        return size;
    }

    bool empty() {
        return size == 0;
    }
};

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n;
    long long m;
    cin >> n >> m;

    MinHeap heap(n + 5);
    for (int i = 0; i < n; i++) {
        long long x;
        cin >> x;
        heap.push(x);
    }

    int operations = 0;
    while (heap.sz() >= 2 && heap.top() < m) {
        long long a = heap.top(); heap.pop();
        long long b = heap.top(); heap.pop();

        long long newMix = a + 2 * b;
        heap.push(newMix);
        operations++;
    }

    if (heap.top() < m)
        cout << -1 << "\n";
    else
        cout << operations << "\n";

    return 0;
}
