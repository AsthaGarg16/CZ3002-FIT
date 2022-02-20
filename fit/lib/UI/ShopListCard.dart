import 'package:flutter/material.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key? key,
    required this.label,
    required this.quantity,
    required this.isRecipe,
    required this.recipe,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final bool value;
  final String quantity;
  final bool isRecipe;
  final String recipe;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.black26),
            bottom: BorderSide(color: Colors.black26),
          ),),
      child: Material(
          child: InkWell(
            onTap: () {
              onChanged(!value);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Checkbox(
                      value: value,
                      onChanged: (bool? newValue) {
                        onChanged(newValue!);
                      },
                    ),
                  ),

                  const SizedBox(width: 5.0),
                  Expanded(flex: 4,child: Text(label, style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87))),
                  Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(quantity, style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87)),
                      )

                  ),
                  const SizedBox(width: 2.0),
                  Expanded(
                    child: IconButton(icon: const Icon(Icons.arrow_drop_down), onPressed: () {  },),
                  ),

                ],
              ),
            ),
          )
      )
    );
  }
}

class ShopListWidget extends StatefulWidget {
  const ShopListWidget({Key? key,
    required this.label,
    required this.quantity,
    required this.isRecipe,
    required this.recipe,}) : super(key: key);

  final String label;
  final String quantity;
  final bool isRecipe;
  final String recipe;

  @override
  State<ShopListWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<ShopListWidget> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return LabeledCheckbox(
      label: widget.label,
      value: _isSelected,
      onChanged: (bool newValue) {
        setState(() {
          _isSelected = newValue;
        });
      }, recipe: widget.isRecipe ? widget.recipe:'', isRecipe: widget.isRecipe, quantity: widget.quantity,
    );
  }
}
