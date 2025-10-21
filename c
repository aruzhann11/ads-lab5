Проблема C: Стандартная задача о футболе
Какёин любит футбол и выходит в финал чемпионата мира. На стадионе он обратил внимание, что есть 
 ряды, каждый из которых может вместить определенное количество людей. Цена билета зависит от ряда. Если есть 
 (
 > 0) свободных мест в ряду, то цена одного билета будет равна k. Какую максимальную сумму денег может получить руководство стадиона, если есть 
 Люди в очереди за билетом?

Формат ввода
Первая линия состоит из 
 и 
 (
). 
 обозначает количество рядов сидячих мест на стадионе и 
 обозначает количество футбольных болельщиков, ожидающих в очереди за билетом на матч.

Следующая строка состоит из 
 целые числа через пробел 
, 
, 
, ..., 
 где 
 (
) обозначает количество свободных мест изначально в поле 
-й ряд.

Гарантируется, что свободных мест хватит для всех посетителей.

Формат вывода
Выведите одно целое число - максимальную сумму денег, которую может заработать стадион.


#include <iostream>
using namespace std;

class MaxHeap{
    private:
    long long* arr;
    int arrSize;
    int HeapSize;

    int left(int i){
        return 2*i+1;
    }
    
    int right(int i){
        return 2*i+2;
    }
    
    int parent(int i){
        return (i-1)/2;
    }

    public:
    MaxHeap(int arrSize){
        this->arrSize=arrSize;
        this->HeapSize=0;
        arr=new long long[arrSize];
    }

    void heapify(int i){
        int largest=i;
        int l=left(i);
        int r=right(i);
        if(l<HeapSize && arr[l]>arr[i]) largest=l;
        if(r<HeapSize && arr[r]>arr[i]) largest=r;
        if(largest!=i){
            swap(arr[i],arr[largest]);
            heapify(largest);
        }

    }
    void unheapify(int i){
        int p=parent(i);
        if(p>=0 && arr[p]<arr[i]){
            swap(arr[i],arr[p]);
            unheapify(p);
        }
    }
    void insert(long long val){
        arr[HeapSize]=val;
        HeapSize++;
        unheapify(HeapSize-1);

    }
    void deleteInHeap(){
        arr[0]=arr[HeapSize-1];
        HeapSize--;
        heapify(0);
    }
    long long top(){
        return arr[0];
    }
    int getSize(){
        return HeapSize;
    }
};
int main(){
    int n,m;
    cin>>n>>m;

    long long a[n];
    MaxHeap h(n+5);
    for(int i=0;i<n;i++){
        cin>>a[i];
    }
    long long total=0;
    for(int i=0;i<m;i++){
        long long top=h.top();
        total+=top;
        h.deleteInHeap();
        if(top-1>0){
            h.insert(top-1);
        }
    }
    cout<<total;

}
