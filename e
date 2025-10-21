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
        this->arrSize=arrSize;
        this->heapSize=0;
        arr= new long long[arrSize];
    }
    void heapify(int i){
        int smallest=i;
        int l=left(i);
        int r=right(i);
        if(l<heapSize && arr[l]<arr[i]) smallest=l;
        if(r<heapSize && arr[r]<arr[i]) smallest=r;

        if(smallest!=i){
            swap(arr[i],arr[smallest]);
            heapify(smallest);
        }

    }
    void unheapify(int i){
        int p=parent(i);
        if(p>=0 && arr[p]>arr[i]){
            swap(arr[i],arr[p]);
            unheapify(p);
        }
    }

    void Insert(long long val){
        arr[heapSize]=val;
        heapSize++;
        unheapify(heapSize-1);
    }
    void deleteInHeap(){
        arr[0]=arr[heapSize-1];
        heapSize--;
        heapify(0);
    }
    long long top(){
        return arr[0];
    }
    int getSize(){
        return heapSize;
    }   
};
int main(){
    int n;
    int m;
    cin>>n>>m;
    MinHeap h(n+5);
    long long sum=0;
    for(int i=0;i<n;i++){
        string s;
        cin>>s;
    if(s=="insert"){
      long long t;
      cin>>t;
      if(h.getSize()<m){
        h.Insert(t);
        sum+=t;
      }   else if(t>h.top()){
        sum-=h.top();
        h.deleteInHeap();
        h.Insert(t);
        sum+=t;
      }
     }else if(s=="print"){
        cout<<sum<<"\n";
     }
    }
}
