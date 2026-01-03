//region bos seyler

import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home(), debugShowCheckedModeBanner: false,);
  }
}

//endregion

//region Home

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home>{

  void navigateToPage(Widget page) {
    gettxt.get(txt);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page, 
      ),
    );
  }

  TextEditingController txt = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sorting Algorithm",style: Sty.tit),backgroundColor: Sty.background,),
      backgroundColor: Sty.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Row(children: [Expanded( flex: 6,child:
              TextField(
                controller:txt,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Sty.bar),
                decoration: InputDecoration(
                  labelText: "Sayıları girin (örn: 50,20,90,10)",
                  labelStyle: TextStyle(color: Sty.bar),
                  enabledBorder: OutlineInputBorder( 
                    borderSide: BorderSide(color:Sty.bar),
                  ),
                  focusedBorder: OutlineInputBorder( 
                    borderSide: BorderSide(color:Sty.bar, width: 2),
                  ),
                ),
              ),),
              const SizedBox(height: 20),Expanded( flex: 1,child:  FloatingActionButton(onPressed: sifirla , backgroundColor: Sty.eleButtonColor, child: Icon(Icons.restart_alt_sharp,color:Colors.white),))],),
              ElevatedButton(
                onPressed:() => navigateToPage(const Bub()),
                style: ElevatedButton.styleFrom(backgroundColor: Sty.eleButtonColor), 
                child: Text("Bubble Sort",style: Sty.txtStyle),
              ),
              ElevatedButton(onPressed: () => navigateToPage(const ins()),
              style: ElevatedButton.styleFrom(backgroundColor: Sty.eleButtonColor) ,
              child: Text("Insertion Sort",style: Sty.txtStyle)),
              ElevatedButton(
                onPressed: () => navigateToPage(const qui()), 
                style: ElevatedButton.styleFrom(backgroundColor: Sty.eleButtonColor),
                child: Text("Quick Sort",style: Sty.txtStyle),
              ),
              ElevatedButton(onPressed: () => navigateToPage(const mer()),style: ElevatedButton.styleFrom(backgroundColor: Sty.eleButtonColor),
               child: Text("Merge Sort",style:Sty.txtStyle)),
              ElevatedButton(onPressed: () => navigateToPage(const sel()),style: ElevatedButton.styleFrom(backgroundColor: Sty.eleButtonColor),
              child: Text("Selection Sort",style: Sty.txtStyle)),
              ElevatedButton(onPressed: () => navigateToPage(const hep()),style: ElevatedButton.styleFrom(backgroundColor: Sty.eleButtonColor), 
              child: Text("Heap Sort",style: Sty.txtStyle)),
            ],
          ),
        ),
      ),
    );
  }
}
//endregion

//region Bubble Sort 

class Bub extends StatefulWidget{
  const Bub({super.key});
  @override    
  State<Bub> createState() => _BUb();
}

class _BUb extends State<Bub>{
  @override
  Widget build(BuildContext context) {
    // Bubble Sort'un görselleştiricisini döndür
    return const gosterme(
      title: 'Bubble Sort',
      algorithm: bubsortGen,
    );
  }
}

// ignore: camel_case_types
typedef algoritma = Iterable<List<BarData>> Function(List<BarData> dizi);

Iterable<List<BarData>> bubsortGen(List<BarData> dizi) sync*{
  int uzunluk = dizi.length;
  bool degitir;
  
  List<BarData> calismaDizisi = List.from(dizi);  

  for(int i = 0 ; i < uzunluk - 1 ; i ++){
    degitir = false;
    
    for(int ii = 0 ; ii < uzunluk - i - 1 ; ii++){
      
      List<BarData> kopya = List.from(calismaDizisi.map((b) {
        return b.copyWith(color: Sty.bar);  
      }));
      kopya[ii] = kopya[ii].copyWith(color: Sty.cur);
      kopya[ii + 1] = kopya[ii+1].copyWith(color: Sty.cur);  

      for( int iii = uzunluk - i ; iii < uzunluk ; iii++){
        kopya[iii] = calismaDizisi[iii].copyWith(color: Sty.finish);  
      }
      yield kopya;  

      if(calismaDizisi[ii].value > calismaDizisi[ii + 1].value){

        BarData temp = calismaDizisi[ii];
        calismaDizisi[ii] = calismaDizisi[ii + 1];
        calismaDizisi[ii + 1] = temp;
        degitir = true;

        List<BarData> degistirmeDurumu = List.from(calismaDizisi.map((b){return b.copyWith(color: Sty.bar);})); // HATA DÜZELTİLDİ: Noktalı virgül ekle
        
        degistirmeDurumu[ii] = degistirmeDurumu[ii].copyWith(color: Sty.swapped);
        degistirmeDurumu[ii + 1] = degistirmeDurumu[ii+1].copyWith(color: Sty.swapped);

        for(int iii = uzunluk - i ; iii < uzunluk ; iii++){
          degistirmeDurumu[iii] = degistirmeDurumu[iii].copyWith(color:Sty.finish);
        }
        yield degistirmeDurumu;  
      }
    }
    calismaDizisi[uzunluk - i - 1] = calismaDizisi[uzunluk - i - 1].copyWith(color: Sty.finish);
    yield List.from(calismaDizisi);

    if(degitir == false) {break;}
  }
  
  if (uzunluk > 0 && calismaDizisi[0].color != Sty.finish) {
    calismaDizisi[0] = calismaDizisi[0].copyWith(color: Sty.finish);
  }
  yield calismaDizisi.map((b){return b.copyWith(color: Sty.finish);}).toList();
}

//endregion

//region Style
class Sty {
  // --- Text Styles ---
  static const TextStyle tit = TextStyle(
    fontSize: 28,
    color: Color(0xFFECEFF1), // Dark Slate Grey for better readability
    fontWeight: FontWeight.w800, 
    letterSpacing: 1.2,
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle txtStyle = TextStyle(
    fontSize: 20,
    color: Color(0xFFECEFF1),
    fontWeight: FontWeight.w500,
    //overflow: TextOverflow.ellipsis,
  );

  // --- Algorithm Colors ---

  // Default Bar: A calm, neutral blue-grey so it doesn't distract
  static const Color bar = Color(0xFF546E7A); 

  // Comparing (Yellow): A warm Amber that is easy on the eyes
  static const Color cur = Color(0xFFFFD54F);

  // Success (Green): A vibrant Emerald to show completion
  static const Color finish = Color(0xFF66BB6A);

  // Action/Swap (Red): A strong Crimson to highlight the move
  static const Color swapped = Color(0xFFEF5350);

  // Active Sub-list (Light Blue): Used in Merge Sort to show the working range
  static const Color mlis = Color(0xFFB3E5FC);

  //Background deep midnight
  static const Color background = Color(0xFF121212);

  static const Color eleButtonColor = Color(0xFF263238);

  static const Color pivot = Colors.lightBlue;
}

//endregion

//region Quick Sort

// ignore: camel_case_types
class qui extends StatefulWidget {
  const qui({super.key});

  @override
  State<qui> createState() => _qui();
}

// ignore: camel_case_types
class _qui extends State<qui> {
  @override
  Widget build(BuildContext context) {
    return const gosterme(
      title: 'Quick Sort',
      algorithm: quicksortStarter, 
    );
  }
}

Iterable<List<BarData>> quicksortStarter(List<BarData> dizi) sync* {
  final List<BarData> workingArray = List.from(dizi);
  yield* _quick(workingArray, 0, workingArray.length - 1);
  
  // Tamamlandığında hepsini yeşil yap
  yield workingArray.map((e) => e.copyWith(color: Sty.finish)).toList();
}

Iterable<List<BarData>> _quick(List<BarData> dizi, int low, int high) sync* {
  if (low < high) {
    int pivotIndex = -1;
    
    // Partition işleminin içindeki yield'ları yakalamak için iterator kullanıyoruz
    final Iterator<Object> partitionSteps = _partition(dizi, low, high).iterator;
    
    while(partitionSteps.moveNext()){
      if(partitionSteps.current is int){
        pivotIndex = partitionSteps.current as int;
      } else if (partitionSteps.current is List<BarData>) {
        yield List<BarData>.from(partitionSteps.current as List<BarData>);
      }
    }

    if(pivotIndex != -1){
        yield* _quick(dizi, low, pivotIndex - 1);
        yield* _quick(dizi, pivotIndex + 1, high);
    }
  } else if (low >= 0 && low < dizi.length) {
    dizi[low] = dizi[low].copyWith(color: Sty.finish);
    yield List<BarData>.from(dizi);
  }
}

Iterable<Object> _partition(List<BarData> dizi, int low, int high) sync* {
  int i = low - 1;
  BarData pivot = dizi[high];

  dizi[high] = dizi[high].copyWith(color: Sty.pivot);
  yield List<BarData>.from(dizi);

  for (int j = low; j < high; j++) {

    dizi[j] = dizi[j].copyWith(color: Sty.cur);
    dizi[i+1] = dizi[i+1].copyWith(color:Sty.cur);
    yield List<BarData>.from(dizi);

    if (dizi[j].value < pivot.value ) {
      i++;
      if(i != j){
      dizi[i] = dizi[i].copyWith(color: Sty.swapped);
      dizi[j] = dizi[j].copyWith(color: Sty.swapped);
      yield List<BarData>.from(dizi);}

      _swap(dizi, i, j);
      yield List<BarData>.from(dizi);

      dizi[i] = dizi[i].copyWith(color: Sty.bar);
      dizi[j] = dizi[j].copyWith(color: Sty.bar);
    } else {
      dizi[j] = dizi[j].copyWith(color: Sty.bar);
    }
    yield List<BarData>.from(dizi);
  }
  
  i++;
  dizi[i] = dizi[i].copyWith(color: Sty.swapped);
  dizi[high] = dizi[high].copyWith(color: Sty.swapped);
  yield List<BarData>.from(dizi);

  _swap(dizi, i, high);
  
  dizi[i] = dizi[i].copyWith(color: Sty.finish);

  for (int k = low; k <= high; k++) {
    if (dizi[k].color != Sty.finish) {
      dizi[k] = dizi[k].copyWith(color: Sty.bar);
    }
  }

  yield List<BarData>.from(dizi);
  yield i; 
}

void _swap(List<BarData> lis, int x, int y) {
  BarData temp = lis[x];
  lis[x] = lis[y];
  lis[y] = temp;
}

//endregion

//region Parcalma fonk

// ignore: camel_case_types
class parcala{
  

  static List<int> parc(){
    String text = gettxt.push();  
    List<int> sayiList = [];
    if(text.isEmpty){
      sayiList = random_list();
    }
    List<String> txtlist = text.split(',').map((s) => s.trim()).toList();
    for(var str in txtlist){
      int? num = int.tryParse(str);
      if(num != null){
        sayiList.add(num.abs().clamp(10, 100));
      }
    }
    
    if(sayiList.isEmpty) {
        sayiList = random_list();
    }
    
    return sayiList;
  }
}
// ignore: non_constant_identifier_names
List<int> random_dizi =[];
// ignore: non_constant_identifier_names
List<int> random_list(){
  if(random_dizi.isEmpty){
    final random = Random();
    random_dizi = List.generate(15, (index) => random.nextInt(90) + 10);
    return random_dizi;
  }else{
  return random_dizi;}
}
void sifirla(){
  random_dizi = [];
  parcala.parc();
}

//endregion

//region gettext method

// ignore: camel_case_types
class gettxt{
  static TextEditingController txt = TextEditingController();
  static void get(TextEditingController test){
    txt = test;
  }

  static String push(){
    String test = txt.text;
    return test;
  }
}

//endregion

//region bar data

class BarData {
  int value;
  Color color;
  Key key;

  BarData(this.value, {Color? color})
      : color = color ?? Sty.bar ,
        key = UniqueKey();  

  BarData copyWith({int? value, Color? color}) {
    return BarData(
      value ?? this.value,
      color: color ?? this.color,
    );
  }

}

//endregion

//region Bar Widget (Görsel Çubuk)

class _BarWidget extends StatelessWidget {
  final BarData barData;
  final double maxHeight;
  final int maxVal;

  const _BarWidget({
    super.key,  
    required this.barData,
    required this.maxHeight,
    required this.maxVal,
  });

  @override
  Widget build(BuildContext context) {
    double height = (barData.value / maxVal) * maxHeight;

    return Expanded(
      key: barData.key,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Text(
              '${barData.value}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

            AnimatedContainer(
              duration: const Duration(milliseconds: 100),  
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                color: barData.color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
              height: height,
            ),
          ],
        ),
      ),
    );
  }
}
//endregion

//region gosterme (Sorting Visualizer)

// ignore: camel_case_types
class gosterme extends StatefulWidget{
  const gosterme({super.key,required this.title,required this.algorithm});
  final String title;
  final algoritma algorithm;

  @override State<gosterme> createState() {return _gosterme();}
}

// ignore: camel_case_types
class _gosterme extends State<gosterme> {

  late List<BarData> bar;  
  bool siraliyor = false;
  bool siralandi=false;
  double hiz = 150;  

  @override
  void initState() {
    super.initState();
    _hazir();  
  }
  
  void _hazir(){
    List<int> degerler = parcala.parc();
    bar = degerler.map((val){return BarData(val , color: Sty.bar);}).toList();
    siralandi = false;  
    siraliyor = false;
  }
  
  void _basla() async{
    if (siraliyor) return;

    setState((){
      _hazir();  
      siralandi=false;
      siraliyor=true;
    });

    final List<BarData> arrayToSort = List<BarData>.from(bar);

    final Iterator<List<BarData>> sort = widget.algorithm(arrayToSort).iterator;

    while(sort.moveNext()){
      if(!mounted) return;

      setState(() {
        bar = sort.current;  
      });
      
      await Future.delayed(Duration(milliseconds: hiz.round()));  
    }
    
    if (mounted) {
        setState(() {
            bar = bar.map((e) => e.copyWith(color: Sty.finish)).toList();
            siraliyor = false;
            siralandi = true;
        });
    }
  }

  Widget _buildBars(BuildContext context) {
    final int maxVal = bar.isEmpty ? 100 : bar.map((b) => b.value).reduce(max);
    final double maxBarHeight = MediaQuery.of(context).size.height * 0.5;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: bar.map((barData) {
        return _BarWidget(
          key: barData.key,  
          barData: barData,
          maxHeight: maxBarHeight,
          maxVal: maxVal,
        );
      }).toList(),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: Sty.tit), 
        backgroundColor: Sty.background,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: _showAlgorithmInfo,
            tooltip: 'Nasıl çalışır?',
          ),
        ],
      ),
      backgroundColor: Sty.background,
      body: Column(
        children: [

          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
              child: _buildBars(context),
            ),
          ),
          
          
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    siraliyor
                        ? 'Durum: Sıralanıyor...'
                        : siralandi
                            ? 'Durum: Tamamlandı'
                            : 'Durum: Hazır',
                    style: Sty.txtStyle.copyWith(
                      color: siraliyor
                          ? Sty.cur
                          : siralandi
                              ? Sty.finish
                              : Sty.bar,
                    ),
                  ),
                ),

                
              Padding(
padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
child: Column( // Using a column to stack label and slider nicely
  children: [
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Animasyon Hızı', 
          style: Sty.txtStyle.copyWith(fontSize: 14)
        ),
        Text(
          '${hiz.round()} ms', 
          style: Sty.txtStyle.copyWith(fontSize: 14)
        ),
      ],
    ),
    Row(
      children: [
        const Icon(Icons.speed, color: Colors.white38, size: 20),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              // The line color
              activeTrackColor: Sty.cur, 
              inactiveTrackColor: Colors.white12,
              // The circle color
              thumbColor: Sty.finish,
              // ignore: deprecated_member_use
              overlayColor: Sty.finish.withOpacity(0.2),
              // Tooltip bubble
              valueIndicatorTextStyle: const TextStyle(color: Colors.black),
              valueIndicatorColor: Sty.cur,
              // Shape of the thumb
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
            ),
            child: Slider(
              value: hiz,
              min: 50,
              max: 500,
              divisions: 9,
              label: '${hiz.round()}ms',
              onChanged: (double newValue) {
                if (!siraliyor) {
                  setState(() {
                    hiz = newValue;
                  });
                }
              },
            ),
          ),
        ),
        const Icon(Icons.timer_off_outlined, color: Colors.white38, size: 20),
      ],
    ),
  ],
),
),
                
                // Butonlar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: siraliyor ? null : () => setState(_hazir),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Sıfırla'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade800,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: siraliyor || siralandi ? null : _basla,
                      icon: const Icon(Icons.play_arrow),
                      label: Text(siraliyor ? 'Sıralanıyor...' : 'Başlat'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: siraliyor || siralandi ? Colors.grey.shade800 : Colors.green.shade800,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
void _showAlgorithmInfo() {
  String explanation = "";
  
  switch (widget.title) {
    case 'Bubble Sort':
      explanation = "Bubble Sort (Baloncuk Sıralaması):\n\n"
          "• Yan yana olan iki sayıyı karşılaştırır.\n"
          "• Büyük olanı sağa atarak en büyük sayıyı 'baloncuk' gibi dizinin sonuna taşır.\n"
          "• Her turda en sağdaki eleman kesinleşir (Yeşil olur).";
      break;
    case 'Quick Sort':
      explanation = "Quick Sort (Hızlı Sıralama):\n\n"
          "• Bir 'Pivot' eleman seçer (Mavi).\n"
          "• Pivottan küçükleri sola, büyükleri sağa toplar.\n"
          "• Pivotun yerini sabitleyip işlemi alt listelerde tekrar eder.";
      break;
    case 'Insertion Sort':
      explanation = "Insertion Sort (Araya Ekleme):\n\n"
          "• Her elemanı solundaki sıralı kısım ile karşılaştırır.\n"
          "• Sayıyı olması gereken doğru boşluğa kadar geriye doğru taşır.\n"
          "• Elinizdeki iskambil kağıtlarını dizmek gibidir.";
      break;
    case 'Merge Sort':
      explanation = "Merge Sort (Birleştirmeli Sıralama):\n\n"
          "• 'Böl ve Yönet' prensibiyle çalışır.\n"
          "• Diziyi tek eleman kalana kadar ikiye böler.\n"
          "• Sonra parçaları küçükten büyüğe sıralayarak geri birleştirir.";
      break;
    case 'Selection Sort':
      explanation = "Selection Sort (Seçmeli Sıralama):\n\n"
          "• Dizideki en küçük elemanı arar (Kırmızı yanar).\n"
          "• Bulduğunda onu sıradaki en başa alır.\n"
          "• Sürekli en küçüğü bularak ilerler.";
      break;
    case 'Heap Sort':
      explanation = "Heap Sort (Yığın Sıralaması):\n\n"
          "• Diziyi bir ağaç yapısı gibi düşünür.\n"
          "• En büyük elemanı sürekli ağacın tepesine taşır.\n"
          "• Tepeyi dizinin sonuna atar ve ağacı tekrar kurar.";
      break;
    default:
      explanation = "Bu algoritma sayıları belirli bir mantıkla sıralar.";
  }

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF1E293B),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(widget.title, style: Sty.tit.copyWith(fontSize: 22)),
      content: SizedBox(
        // Genişliği manuel olarak ekran genişliğine zorluyoruz
        width: MediaQuery.of(context).size.width, 
        child: ListView(
          shrinkWrap: true, // İçeriğin boyutu kadar yer kaplamasını sağlar
          children: [
            Text(
              explanation,
              style: Sty.txtStyle.copyWith(
                fontSize: 16,
                height: 1.5,
                color: Colors.white,
              ),
              softWrap: true, // Metnin alt satıra geçmesini zorunlu kılar
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Anladım", style: TextStyle(color: Sty.cur, fontSize: 16)),
        ),
      ],
    ),
  );
}
}

//endregion

//region insertion sort

// ignore: camel_case_types
class ins extends StatefulWidget {
  const ins({super.key});

  @override
  State<ins> createState() => _ins();
}

  // ignore: camel_case_types
class _ins extends State<ins> {
  @override
  Widget build(BuildContext context) {
    return const gosterme(
      title: 'Insertion Sort',
      algorithm: insSort, 
    );
  }
}

Iterable<List<BarData>> insSort(List<BarData> lis) sync*{
  List<BarData> dizi = List.from(lis);
  for(int i = 1 ; i < dizi.length ; i++){
    dizi = List.from(dizi.map((p) { return p.copyWith(color: Sty.bar);}));
    int sayac = i-1;
    int sayac2 = i;
    dizi[sayac] = dizi[sayac].copyWith(color: Sty.cur);
    dizi[sayac2] = dizi[sayac2].copyWith(color: Sty.cur);
    
    while(dizi[sayac2].value < dizi[sayac].value){
      dizi[sayac2] = dizi[sayac2].copyWith(color: Sty.swapped);
      dizi[sayac] = dizi[sayac].copyWith(color: Sty.swapped);
      yield dizi;

      BarData temp = dizi[sayac2];
      dizi[sayac2] = dizi[sayac];
      dizi[sayac] = temp;
      dizi[sayac2] = dizi[sayac2].copyWith(color: Sty.cur);
      dizi[sayac] = dizi[sayac].copyWith(color: Sty.cur);
      yield dizi;
      sayac--;
      sayac2--;
      
      
      if(sayac < 0){
        break;
      }
    }
    
  }
  dizi = List.from(dizi.map((p) { return p.copyWith(color:Sty.finish);}));
  yield dizi;
}


//endregion

//region merge sort


// ignore: camel_case_types
class mer extends StatefulWidget{
  const mer({super.key});
  @override 
  State<mer> createState() => _mer();
}

// ignore: camel_case_types
class _mer extends State<mer>{
  @override
  Widget build(BuildContext context){
  return const gosterme(title: "Merge Sort", algorithm: merGen);}
}

Iterable <List<BarData>> merGen(List<BarData> dizi) sync*{
  yield* Mparclama(dizi, 0, dizi.length-1);
}
// ignore: non_constant_identifier_names
Iterable <List<BarData>> Mparclama(List<BarData> dizi , int left  , int right) sync*{
  if ( left < right){
    int mid = ((left + right)/2).floor();
    
    yield* Mparclama(dizi, left, mid);
    yield* Mparclama(dizi, mid+1, right);

    yield* Mbirlestir(dizi, left, mid, right);
  }
}
// ignore: non_constant_identifier_names
 Iterable<List<BarData>> Mbirlestir(List<BarData> dizi, int left, int mid, int right) sync* {
  // 1. Prepare temporary sub-lists
  List<BarData> L = dizi.sublist(left, mid + 1);
  List<BarData> R = dizi.sublist(mid + 1, right + 1);

  int i = 0, j = 0, k = left;

  // 2. Highlight the range being merged in Yellow (Sty.cur)
  for (int x = left; x <= right; x++) {
    dizi[x] = dizi[x].copyWith(color: Sty.cur);
  }
  yield List.from(dizi);

  // 3. Main Merge Loop
  while (i < L.length && j < R.length) {
    if (L[i].value <= R[j].value) {
      dizi[k] = L[i].copyWith(color: Sty.swapped); // Flash Red for movement
      i++;
    } else {
      dizi[k] = R[j].copyWith(color: Sty.swapped); // Flash Red for movement
      j++;
    }
    
    yield List.from(dizi);
    
    // Set it back to Yellow to show it is now "placed" in the mini-list
    dizi[k] = dizi[k].copyWith(color: Sty.cur);
    k++;
  }

  // 4. Handle remaining elements
  while (i < L.length) {
    dizi[k] = L[i].copyWith(color: Sty.swapped);
    yield List.from(dizi);
    dizi[k] = dizi[k].copyWith(color: Sty.cur);
    i++; k++;
  }
  while (j < R.length) {
    dizi[k] = R[j].copyWith(color: Sty.swapped);
    yield List.from(dizi);
    dizi[k] = dizi[k].copyWith(color: Sty.cur);
    j++; k++;
  }

  // 5. Section Complete: Turn this mini-list Green (Finish)
  // This helps the user see the "sorted chunks" growing
  for (int x = left; x <= right; x++) {
    dizi[x] = dizi[x].copyWith(color: Sty.bar);
  }
  yield List.from(dizi);
}




//endregion

//region selection sort

// ignore: camel_case_types
class sel extends StatefulWidget{
  const sel({super.key});
@override
State<sel> createState() => _sel();
}

// ignore: camel_case_types
class _sel extends State<sel>{

  @override
  Widget build(BuildContext context){
    return gosterme(title: "Selection Sort", algorithm: selGosterme);
  }
}

Iterable <List<BarData>> selGosterme(List<BarData> dizi)sync*{
  bool check = false;
  int index = 0;
  
  for(int i = 0 ; i < dizi.length ; i++){
    index = i;
    dizi[i] = dizi[i].copyWith(color:Sty.pivot);

    for(int ii = i ; ii < dizi.length ; ii++){
      if(ii == i) continue;
      dizi[ii] = dizi[ii].copyWith(color:Sty.cur);
      if(dizi[index].value > dizi[ii].value){
        if(index != i){
        dizi[index] = dizi[index].copyWith(color:Sty.bar);}
        check = true;index = ii;
        dizi[index] = dizi[index].copyWith(color:Sty.swapped);
        yield List.from(dizi);}
        else{
        yield List.from(dizi);
        dizi[ii] = dizi[ii].copyWith(color:Sty.bar);}}

  
    if(check == true){BarData temp = dizi[i];
    dizi[i] = dizi[index]; dizi[index] = temp; check = false;
    dizi[i] = dizi[i].copyWith(color: Sty.finish);
    dizi[index] = dizi[index].copyWith(color:Sty.bar);
    yield List.from(dizi);}
    else{dizi[i] = dizi[i].copyWith(color:Sty.finish);yield List.from(dizi);}
  }
}

//endregion

//region heap sort

  // ignore: camel_case_types
class hep extends StatefulWidget{
  const hep({super.key});
  @override
  State<hep> createState() => _hep();

}
  // ignore: camel_case_types
class _hep extends State<hep>{
  @override
  Widget build(BuildContext context){
  return gosterme(title: "Heap Sort", algorithm: heapSortGost);}
}

Iterable<List<BarData>> heapSortGost(List<BarData> dizi) sync* {
  int n = dizi.length;


  for (int i = (n / 2).floor() - 1; i >= 0; i--) {
    yield* heapify(dizi, n, i);
  }

  for (int i = n - 1; i > 0; i--) {

    dizi[0] = dizi[0].copyWith(color: Sty.swapped);
    dizi[i] = dizi[i].copyWith(color: Sty.swapped);
    yield List.from(dizi);

    _mswap(dizi, 0, i);

    dizi[i] = dizi[i].copyWith(color: Sty.finish);
    
    dizi[0] = dizi[0].copyWith(color: Sty.bar);
    yield List.from(dizi);

    yield* heapify(dizi, i, 0);
  }
  
  dizi[0] = dizi[0].copyWith(color: Sty.finish);
  yield List.from(dizi);
}

Iterable<List<BarData>> heapify(List<BarData> dizi, int n, int i) sync* {
  int largest = i;
  int left = 2 * i + 1;
  int right = 2 * i + 2;

  // 1. Highlight the Parent and both Children to show the "Comparison Group"
  if (left < n && dizi[left].color != Sty.finish) dizi[left] = dizi[left].copyWith(color: Sty.cur);
  if (right < n && dizi[right].color != Sty.finish) dizi[right] = dizi[right].copyWith(color: Sty.cur);
  if (dizi[i].color != Sty.finish) dizi[i] = dizi[i].copyWith(color: Sty.pivot);
  
  yield List.from(dizi); // Show the selection

  // 2. Logic to find the largest
  if (left < n && dizi[left].value > dizi[largest].value) largest = left;
  if (right < n && dizi[right].value > dizi[largest].value) largest = right;

  if (largest != i) {
    // 3. FLASH RED: We found a swap!
    dizi[i] = dizi[i].copyWith(color: Sty.swapped);
    dizi[largest] = dizi[largest].copyWith(color: Sty.swapped);
    yield List.from(dizi);

    _mswap(dizi, i, largest);
    yield List.from(dizi);

    // 4. THE FIX: Reset the "other" child that WASN'T swapped
    // If we swapped with 'left', the 'right' child is still yellow. We must clear it now.
    if (left < n && left != largest && dizi[left].color == Sty.cur) {
       dizi[left] = dizi[left].copyWith(color: Sty.bar);
    }
    if (right < n && right != largest && dizi[right].color == Sty.cur) {
       dizi[right] = dizi[right].copyWith(color: Sty.bar);
    }

    // Reset the current swapped bars back to neutral before moving deeper
    dizi[i] = dizi[i].copyWith(color: Sty.bar);
    dizi[largest] = dizi[largest].copyWith(color: Sty.bar);

    // 5. Dive deeper into the tree
    yield* heapify(dizi, n, largest);
  } else {
    // 6. NO SWAP: Clean up everything in this group
    if (i < n && dizi[i].color == Sty.pivot) dizi[i] = dizi[i].copyWith(color: Sty.bar);
    if (left < n && dizi[left].color == Sty.cur) dizi[left] = dizi[left].copyWith(color: Sty.bar);
    if (right < n && dizi[right].color == Sty.cur) dizi[right] = dizi[right].copyWith(color: Sty.bar);
    yield List.from(dizi);
  }
}
  


void _mswap(List<BarData> lis, int x , int y){
  BarData temp = lis[x];
  lis[x] = lis[y];
  lis[y] = temp;
}
//endregion
