import 'package:flutter/material.dart';
//임시로 학과 정보 저장//

class Item{
  String title;
  int ind;
  Item(this.title,this.ind);
}

class Colleges{
  List<DropdownMenuItem<Item>> colleges=List.empty(growable: true);
  Colleges(){
    colleges.add(DropdownMenuItem(value: Item('대학(선택안함)',0), child: const Text('대학(선택안함)')));
    colleges.add(DropdownMenuItem(value: Item('인문대학',1), child: const Text('인문대학')));
    colleges.add(DropdownMenuItem(value: Item('사회과학대학',2), child: const Text('사회과학대학')));
    colleges.add(DropdownMenuItem(value: Item('법과대학',3), child: const Text('법과대학')));
    colleges.add(DropdownMenuItem(value: Item('경영대학',4), child: const Text('경영대학')));
    colleges.add(DropdownMenuItem(value: Item('경제통상대학',5), child: const Text('경제통상대학')));
    colleges.add(DropdownMenuItem(value: Item('자연과학대학',6), child: const Text('자연과학대학')));
    colleges.add(DropdownMenuItem(value: Item('공과대학',7), child: const Text('공과대학')));
    colleges.add(DropdownMenuItem(value: Item('IT대학',8), child: const Text('IT대학')));
    colleges.add(DropdownMenuItem(value: Item('융합특성화자유전공학부',9), child: const Text('융합특성화자유전공학부')));
  }
}
class Majors {
  List<DropdownMenuItem<Item>> majors = List.empty(growable: true);
  Majors(int i) {

    switch(i){
      case 0:
        majors.add(DropdownMenuItem(value: Item('학과(부)',0),child:const Text('학과(부)'),));
        break;
      case 1:
        majors.add(DropdownMenuItem(value: Item('선택하기',0),child:const Text('선택하기'),));
        majors.add(DropdownMenuItem(value: Item('기독교학과',1),child:const Text('기독교학과'),));
        majors.add(DropdownMenuItem(value: Item('국어국문학과',2),child:const Text('국어국문학과'),));
        majors.add(DropdownMenuItem(value: Item('영어영문학과',3), child:const Text('영어영문학과')));
        majors.add(DropdownMenuItem(value: Item('독어독문학과',4),child:const Text('독어독문학과'),));
        majors.add(DropdownMenuItem(value: Item('불어불문학과',5),child:const Text('불어불문학과'),));
        majors.add(DropdownMenuItem(value: Item('중어중문학과',6),child:const Text('중어중문학과'),));
        majors.add(DropdownMenuItem(value: Item('일어일문학과',7),child:const Text('일어일문학과'),));
        majors.add(DropdownMenuItem(value: Item('철학과',8),child:const Text('철학과'),));
        majors.add(DropdownMenuItem(value: Item('사학과',9),child:const Text('사학과'),));
        majors.add(DropdownMenuItem(value: Item('예술창작부 문예창작전공',10),child:const Text('예술창작부 문예창작전공'),));
        majors.add(DropdownMenuItem(value: Item('예술창작부 영화예술전공',11),child:const Text('예술창작부 영화예술전공'),));
        majors.add(DropdownMenuItem(value: Item('스포츠학부',12),child:const Text('스포츠학부'),));
        break;
      case 2:
        majors.add(DropdownMenuItem(value: Item('선택하기',0),child:const Text('선택하기'),));
        majors.add(DropdownMenuItem(value: Item('사회복지학부',1),child:const Text('사회복지학부'),));
        majors.add(DropdownMenuItem(value: Item('행정학부',2),child:const Text('행정학부'),));
        majors.add(DropdownMenuItem(value: Item('정치외교학과',3),child:const Text('정치외교학과'),));
        majors.add(DropdownMenuItem(value: Item('정보사회학과',4),child:const Text('정보사회학과'),));
        majors.add(DropdownMenuItem(value: Item('언론홍보학과',5),child:const Text('언론홍보학과'),));
        majors.add(DropdownMenuItem(value: Item('평생교육학과',6),child:const Text('평생교육학과'),));
        break;
      case 3:
        majors.add(DropdownMenuItem(value: Item('선택하기',0),child:const Text('선택하기'),));
        majors.add(DropdownMenuItem(value: Item('법학과',1),child:const Text('법학과'),));
        majors.add(DropdownMenuItem(value: Item('국제법무학과',2),child:const Text('국제법무학과'),));
        break;
      case 4:
        majors.add(DropdownMenuItem(value: Item('선택하기',0),child:const Text('선택하기'),));
        majors.add(DropdownMenuItem(value: Item('경영학부',1),child:const Text('경영학부'),));
        majors.add(DropdownMenuItem(value: Item('회계학과',2),child:const Text('회계학과'),));
        majors.add(DropdownMenuItem(value: Item('벤처중소기업학과',3),child:const Text('벤처중소기업학과'),));
        majors.add(DropdownMenuItem(value: Item('금융학부',4),child:const Text('금융학부'),));
        break;
      case 5:
        majors.add(DropdownMenuItem(value: Item('선택하기',0),child:const Text('선택하기'),));
        majors.add(DropdownMenuItem(value: Item('경제학과',1),child:const Text('경제학과'),));
        majors.add(DropdownMenuItem(value: Item('글로벌통상학과',2),child:const Text('글로벌통상학과'),));
        majors.add(DropdownMenuItem(value: Item('금융경제학과',3),child:const Text('금융경제학과'),));
        majors.add(DropdownMenuItem(value: Item('국제무역학과',4),child:const Text('국제무역학과'),));
        majors.add(DropdownMenuItem(value: Item('국제무역학과',5),child:const Text('국제무역학과'),));
        break;
      case 6:
        majors.add(DropdownMenuItem(value: Item('선택하기',0),child:const Text('선택하기'),));
        majors.add(DropdownMenuItem(value: Item('수학과',1),child:const Text('수학과'),));
        majors.add(DropdownMenuItem(value: Item('물리학과',2),child:const Text('물리학과'),));
        majors.add(DropdownMenuItem(value: Item('화학과',3),child:const Text('화학과'),));
        majors.add(DropdownMenuItem(value: Item('정보통계보험수리학과',4),child:const Text('정보통계보험수리학과'),));
        majors.add(DropdownMenuItem(value: Item('의생명시스템학부',5),child:const Text('의생명시스템학부'),));
        break;
      case 7:
        majors.add(DropdownMenuItem(value: Item('선택하기',0),child:const Text('선택하기'),));
        majors.add(DropdownMenuItem(value: Item('화학공학과',1),child:const Text('화학공학과'),));
        majors.add(DropdownMenuItem(value: Item('신소재공학과',2),child:const Text('신소재공학과'),));
        majors.add(DropdownMenuItem(value: Item('기계공학부',3),child:const Text('기계공학부'),));
        majors.add(DropdownMenuItem(value: Item('전기공학부',4),child:const Text('전기공학부'),));
        majors.add(DropdownMenuItem(value: Item('산업정보시스템공학과',5),child:const Text('산업정보시스템공학과'),));
        majors.add(DropdownMenuItem(value: Item('건축학부',6),child:const Text('건축학부'),));
        break;
      case 8:
        majors.add(DropdownMenuItem(value: Item('선택하기',0),child:const Text('선택하기'),));
        majors.add(DropdownMenuItem(value: Item('컴퓨터학부',1),child:const Text('컴퓨터학부'),));
        majors.add(DropdownMenuItem(value: Item('소프트웨어학부',2),child:const Text('소프트웨어학부'),));
        majors.add(DropdownMenuItem(value: Item('전자정보공학부(전자공학)',3),child:const Text('전자정보공학부(전자공학)'),));
        majors.add(DropdownMenuItem(value: Item('전자정보공학부(IT융합)',4),child:const Text('전자정보공학부(IT융합)'),));
        majors.add(DropdownMenuItem(value: Item('AI융합학부',5),child:const Text('AI융합학부'),));
        majors.add(DropdownMenuItem(value: Item('글로벌미디어학부',6),child:const Text('글로벌미디어학부'),));
        majors.add(DropdownMenuItem(value: Item('미디어경영학과',7),child:const Text('미디어경영학과'),));
        break;
      case 9:
        //majors.add(DropdownMenuItem(child:Text('선택하기'),value: Item('선택하기',0),));
        majors.add(DropdownMenuItem(value: Item('융합특성화자유전공학부',0),child:const Text('융합특성화자유전공학부'),));
        break;

    }

  }
}