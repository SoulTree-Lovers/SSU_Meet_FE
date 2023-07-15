import 'package:flutter/material.dart';
//임시로 학과 정보 저장//

class Item{
  String title;
  int ind;
  Item(this.title,this.ind);
}

class Colleges{
  List<DropdownMenuItem<Item>> colleges=List.empty(growable: true);
  Colleges(){ //생성자
    colleges.add(DropdownMenuItem(child: Text('대학(선택안함)'),value: Item('대학(선택안함)',0)));
    colleges.add(DropdownMenuItem(child: Text('인문대학'),value: Item('인문대학',1)));
    colleges.add(DropdownMenuItem(child: Text('사회과학대학'),value: Item('사회과학대학',2)));
    colleges.add(DropdownMenuItem(child: Text('법과대학'),value: Item('법과대학',3)));
    colleges.add(DropdownMenuItem(child: Text('경영대학'),value: Item('경영대학',4)));
    colleges.add(DropdownMenuItem(child: Text('경제통상대학'),value: Item('경제통상대학',5)));
    colleges.add(DropdownMenuItem(child: Text('자연과학대학'),value: Item('자연과학대학',6)));
    colleges.add(DropdownMenuItem(child: Text('공과대학'),value: Item('공과대학',7)));
    colleges.add(DropdownMenuItem(child: Text('IT대학'),value: Item('IT대학',8)));
    colleges.add(DropdownMenuItem(child: Text('융합특성화자유전공학부'),value: Item('융합특성화자유전공학부',9)));
  }
}
class Majors {
  List<DropdownMenuItem<Item>> majors = List.empty(growable: true);
  Majors(int i) {

    switch(i){
      case 0:
        majors.add(DropdownMenuItem(child:Text('학과(부)'),value: Item('학과(부)',0),));
        break;
      case 1:
        majors.add(DropdownMenuItem(child:Text('선택하기'),value: Item('선택하기',0),));
        majors.add(DropdownMenuItem(child:Text('기독교학과'),value: Item('기독교학과',1),));
        majors.add(DropdownMenuItem(child:Text('국어국문학과'),value: Item('국어국문학과',2),));
        majors.add(DropdownMenuItem(child:Text('영어영문학과'),value: Item('영어영문학과',3)));
        majors.add(DropdownMenuItem(child:Text('독어독문학과'),value: Item('독어독문학과',4),));
        majors.add(DropdownMenuItem(child:Text('불어불문학과'),value: Item('불어불문학과',5),));
        majors.add(DropdownMenuItem(child:Text('중어중문학과'),value: Item('중어중문학과',6),));
        majors.add(DropdownMenuItem(child:Text('일어일문학과'),value: Item('일어일문학과',7),));
        majors.add(DropdownMenuItem(child:Text('철학과'),value: Item('철학과',8),));
        majors.add(DropdownMenuItem(child:Text('사학과'),value: Item('사학과',9),));
        majors.add(DropdownMenuItem(child:Text('예술창작부 문예창작전공'),value: Item('예술창작부 문예창작전공',10),));
        majors.add(DropdownMenuItem(child:Text('예술창작부 영화예술전공'),value: Item('예술창작부 영화예술전공',11),));
        majors.add(DropdownMenuItem(child:Text('스포츠학부'),value: Item('스포츠학부',12),));
        break;
      case 2:
        majors.add(DropdownMenuItem(child:Text('선택하기'),value: Item('선택하기',0),));
        majors.add(DropdownMenuItem(child:Text('사회복지학부'),value: Item('사회복지학부',1),));
        majors.add(DropdownMenuItem(child:Text('행정학부'),value: Item('행정학부',2),));
        majors.add(DropdownMenuItem(child:Text('정치외교학과'),value: Item('정치외교학과',3),));
        majors.add(DropdownMenuItem(child:Text('정보사회학과'),value: Item('정보사회학과',4),));
        majors.add(DropdownMenuItem(child:Text('언론홍보학과'),value: Item('언론홍보학과',5),));
        majors.add(DropdownMenuItem(child:Text('평생교육학과'),value: Item('평생교육학과',6),));
        break;
      case 3:
        majors.add(DropdownMenuItem(child:Text('선택하기'),value: Item('선택하기',0),));
        majors.add(DropdownMenuItem(child:Text('법학과'),value: Item('법학과',1),));
        majors.add(DropdownMenuItem(child:Text('국제법무학과'),value: Item('국제법무학과',2),));
        break;
      case 4:
        majors.add(DropdownMenuItem(child:Text('선택하기'),value: Item('선택하기',0),));
        majors.add(DropdownMenuItem(child:Text('경영학부'),value: Item('경영학부',0),));
        break;
      case 5:
        majors.add(DropdownMenuItem(child:Text('선택하기'),value: Item('선택하기',0),));
        majors.add(DropdownMenuItem(child:Text('경제학과'),value: Item('경제학과',0),));
        break;
      case 6:
        majors.add(DropdownMenuItem(child:Text('선택하기'),value: Item('선택하기',0),));
        majors.add(DropdownMenuItem(child:Text('수학과'),value: Item('수학과',0),));
        break;
      case 7:
        majors.add(DropdownMenuItem(child:Text('선택하기'),value: Item('선택하기',0),));
        majors.add(DropdownMenuItem(child:Text('화학공학과'),value: Item('화학공학과',0),));
        break;
      case 8:
        majors.add(DropdownMenuItem(child:Text('선택하기'),value: Item('선택하기',0),));
        majors.add(DropdownMenuItem(child:Text('컴퓨터학부'),value: Item('컴퓨터학부',0),));
        break;
      case 9:
        //majors.add(DropdownMenuItem(child:Text('선택하기'),value: Item('선택하기',0),));
        majors.add(DropdownMenuItem(child:Text('융합특성화자유전공학부'),value: Item('융합특성화자유전공학부',0),));
        break;

    }

  }
}