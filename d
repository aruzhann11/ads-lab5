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

class MinHeap{
    private:
    long long* arr;
    int arrSize;
    int heapSize;

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
    MinHeap(int arrSize){
        this->heapSize=0;
        this->arrSize=arrSize;
        arr=new long long[arrSize];
    }
    void heapify(int i){
        int smallest=i;
        int l=left(i);
        int r=right(i);
        if(l<heapSize && arr[l]<arr[smallest]) smallest=l;
        if(r<heapSize && arr[r]<arr[smallest]) smallest=r;

        if(smallest!=i){
            swap(arr[i],arr[smallest]);
            heapify(smallest);
        }
    }
    void unheapify(int i){
        int p=parent(i);
        if(p>=0 && arr[p]>arr[i]){
            swap(arr[p],arr[i]);
            unheapify(p);
        }
    }
    void Insert(long long val){
        arr[heapSize]=val;
        heapSize++;
        unheapify(heapSize-1);
    }
    void deleteInHeap(){
        arr[0]=arr[heapSize-1];;
        heapSize--;
        heapify(0);
    }
    int top(){
        return arr[0];
    }
    int getSize(){
        return heapSize;
    }
};

int main(){
    int n;
    long long m;
    cin>>n>>m;
    int arr[n];
    MinHeap h(n+5);
    for(int i;i<n;i++){
        cin>>arr[i];
        h.Insert(arr[i]);
    }
  int operations=0;
  while(h.getSize()>=2 && h.top()<m){
    long long a=h.top(); h.deleteInHeap();
    long long b=h.top(); h.deleteInHeap();

    long long mix=a+2*b;
    h.Insert(mix);
    operations++;

  }   

  if(h.top()<m){
    cout<<-1<<'\n';
  } else{
    cout<<operations<<'\n';
  }
}
