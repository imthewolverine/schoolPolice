class CounterState {
  final int counterValue;

  const CounterState({required this.counterValue});

  List<Object> get props => [counterValue];
}
