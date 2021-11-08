import 'package:flutter/material.dart';


class PopupMenuContainer<T> extends StatefulWidget {
  final Widget child;
  final List<PopupMenuEntry<T>> items;
  final void Function(T) onItemSelected;

  const PopupMenuContainer({required this.child, required this.items, required this.onItemSelected, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PopupMenuContainerState<T>();
}


class PopupMenuContainerState<T> extends State<PopupMenuContainer<T>>{
  late Offset _tapDownPosition;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (TapDownDetails details){
          _tapDownPosition = details.globalPosition;
        },
        onLongPress: () async {
          final RenderObject? overlay = Overlay.of(context)!.context.findRenderObject();

          T value = (await showMenu<T>(
            context: context,
            items: widget.items,

            position: RelativeRect.fromLTRB(
              _tapDownPosition.dx,
              _tapDownPosition.dy,
              overlay!.semanticBounds.width - _tapDownPosition.dx,
              overlay.semanticBounds.height - _tapDownPosition.dy,
            ),
          )) as T;

          widget.onItemSelected(value);
        },
        child: widget.child,
    );
  }
}

/*PopupMenuContainer<String>(
                    child: const SizedBox(child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.delete),
                    )),
                    items: const [
                      PopupMenuItem(value: 'delete', child: Text('Delete'))
                    ],
                    onItemSelected: (value) async {
                      if( value == 'delete' ){
                        deleteNote(repository, itemNote);
                      }
                    },
                  );*/