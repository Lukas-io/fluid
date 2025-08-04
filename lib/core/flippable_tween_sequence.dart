import 'package:flutter/animation.dart';

class FlippableTweenSequence<T> extends TweenSequence<T> {
  FlippableTweenSequence(this._items) : super(_items);

  final List<TweenSequenceItem<T>> _items;
  FlippableTweenSequence<T>? _flipped;

  FlippableTweenSequence<T>? get flipped {
    if (_flipped == null) {
      final List<TweenSequenceItem<T>> newItems = <TweenSequenceItem<T>>[];
      for (int i = 0; i < _items.length; i++) {
        newItems.add(
          TweenSequenceItem<T>(
            tween: _items[i].tween,
            weight: _items[_items.length - 1 - i].weight,
          ),
        );
      }
      _flipped = FlippableTweenSequence<T>(newItems);
    }
    return _flipped;
  }
}
