import 'package:flutter/material.dart';
import 'package:ssu_meet/tag_data/ideal_tag.dart';

class SelectIdealType extends StatefulWidget {
  const SelectIdealType({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectIdealType();
}

List _ideal_list = []; //사용자가 선택한 태그

List getSelectedList() {
  return _ideal_list;
}

class _SelectIdealType extends State<SelectIdealType> {
  @override
  void initState() {
    super.initState();
    _ideal_list = [];
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.fromLTRB(screenWidth * 0.08, 0, screenWidth * 0.08, 0),
      height: screenHeight * 0.6,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyCustomListView(
              category: personality,
            ),
            MyCustomListView(
              category: appearance,
            ),
            MyCustomListView(
              category: face_to_animal,
            ),
            MyCustomListView(
              category: style,
            ),
            Center(
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    Navigator.pop(context, _ideal_list);
                  },
                  child: const Text(
                    "선택 완료",
                    style: TextStyle(color: Colors.black),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCustomListView extends StatefulWidget {
  final List _category;

  get category => _category;

  const MyCustomListView({
    Key? key,
    required dynamic category,
  })  : _category = category,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _MyCustomListView();
}

class _MyCustomListView extends State<MyCustomListView> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      //카테고리별 차지하는 영역
      height: screenHeight * 0.12,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.vertical,
          children: [
            for (var i = 0; i < widget.category.length; i++)
              Material(
                child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: screenWidth * 0.2,
                      height: screenHeight * 0.04,
                      margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black),
                          color: _ideal_list.contains(widget.category[i])
                              ? const Color.fromRGBO(236, 243, 225, 1)
                              : Colors.grey),
                      child: Center(
                        child: Text(
                          "#${widget.category[i]}",
                          style: TextStyle(
                              fontFamily: "Nanum_Ogbice",
                              fontSize: screenWidth * 0.04),
                        ),
                      ),
                    ),
                    onTap: () {
                      _ideal_list.contains(widget.category[i])
                          ? _ideal_list.remove(widget.category[i])
                          : _ideal_list.add(widget.category[i]);
                      setState(() {});
                    }),
              ),
          ],
        ),
      ),
    );
  }
}
