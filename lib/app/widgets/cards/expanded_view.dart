import 'package:flutter/material.dart';

class ExpandedView extends StatefulWidget {
  final Widget? child;
  final int? height;
  final bool expand;

  const ExpandedView({Key? key, this.expand = false, this.child, this.height})
      : super(key: key);

  @override
  _ExpandedViewState createState() => _ExpandedViewState();
}

class _ExpandedViewState extends State<ExpandedView>
    with SingleTickerProviderStateMixin {
  AnimationController? expandController;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = CurvedAnimation(
      parent: expandController!,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.expand) {
      expandController!.forward();
    } else {
      expandController!.reverse();
    }
  }

  @override
  void didUpdateWidget(ExpandedView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 1.0,
        sizeFactor: animation!,
        child: Container(
          padding: const EdgeInsets.only(bottom: 5),
          constraints: BoxConstraints(
              //minHeight: 100,
              minWidth: double.infinity,
              maxHeight: widget.height! > 5
                  ? MediaQuery.of(context).size.height * 0.23
                  : widget.height == 1
                      ? MediaQuery.of(context).size.height * 0.08
                      : widget.height! * 50.0),
          child: Padding(
              padding: const EdgeInsets.only(bottom: 5), child: widget.child),
        ));
  }
}
