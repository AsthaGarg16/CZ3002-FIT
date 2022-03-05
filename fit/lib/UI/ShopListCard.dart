import 'package:flutter/material.dart';

class ShopListWidget extends StatefulWidget {
  ShopListWidget({Key? key,
    required this.label,
    required this.quantity,
    required this.isRecipe,
    required this.recipe,
    required this.value,
    required this.labelColor,
    required this.visible,
    required this.onValueChanged,
    required this.onButtonPress}) : super(key: key);

  final String label;
  final String quantity;
  final bool isRecipe;
  final String recipe;
  bool value;
  bool visible;
  Color labelColor;
  final Function onValueChanged;
  final Function onButtonPress;

  @override
  State<ShopListWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<ShopListWidget> {

  @override
  Widget build(BuildContext context) {
    bool _isSelected = false;
    String text = widget.label;
    if(widget.isRecipe)
      {
        text = text + "  ("+widget.recipe+")";
      }

    return Container(
        height: MediaQuery.of(context).size.height * 0.075,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.black26),
            bottom: BorderSide(color: Colors.black26),
          ),),
        child: Material(
            child: InkWell(
              onTap: () {
                setState(() {
                  _isSelected = !widget.value;
                  widget.value=_isSelected;
                  widget.labelColor = widget.value?Colors.teal:Colors.black87;
                  widget.onValueChanged();
                });

              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Checkbox(
                        value: widget.value,
                        onChanged: (bool? newValue) {
                          setState(() {
                            _isSelected = newValue!;
                            widget.value = _isSelected;
                            widget.labelColor = widget.value?Colors.teal:Colors.black87;
                            widget.onValueChanged();
                          });
                        },
                      ),
                    ),

                    const SizedBox(width: 5.0),

                        Expanded(flex: 4,child: Text(text, style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            color: widget.value?Colors.teal:Colors.black87))),


                    Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(widget.quantity, style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                              color: widget.value?Colors.teal:Colors.black87)),
                        )

                    ),
                    //const SizedBox(width: 2.0),
                    Expanded(
                      child: widget.value?Container():IconButton(icon: widget.visible?const Icon(Icons.arrow_drop_up_rounded):const Icon(Icons.arrow_drop_down_rounded),
                        color: widget.visible?Colors.teal:Colors.black87,
                        onPressed: () { widget.onButtonPress(); },),
                    ),

                  ],
                ),
              ),
            )
        )
    );

  }

}
