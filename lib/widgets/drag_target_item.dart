import 'package:flutter/material.dart';

class DragTargetItem extends StatefulWidget {
  final String property;
  final Function(String, String) onDrop;

  const DragTargetItem({
    super.key,
    required this.property,
    required this.onDrop,
  });

  @override
  State<DragTargetItem> createState() => _DragTargetItemState();
}

class _DragTargetItemState extends State<DragTargetItem> {
  String dragItem = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(widget.property)),
        Expanded(
          flex: 2,
          child: DragTarget<String>(
            builder:
                (context, candidateData, rejectedData) => Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border:
                        candidateData.isNotEmpty
                            ? Border.all(color: Colors.blue, width: 2)
                            : null,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(dragItem.isEmpty ? 'Drop here' : dragItem),
                      ),
                      if (dragItem.isNotEmpty)
                        InkWell(
                          onTap: () {
                            setState(() {
                              dragItem = '';
                            });
                          },
                          child: const Icon(Icons.clear, size: 15),
                        ),
                    ],
                  ),
                ),
            onAcceptWithDetails: (value) {
              String droppedData = value.data;
              setState(() {
                if (dragItem.isEmpty) {
                  dragItem = droppedData;
                } else {
                  dragItem = '$dragItem $droppedData';
                }
              });
              widget.onDrop(widget.property, dragItem);
            },
          ),
        ),
      ],
    );
  }
}
