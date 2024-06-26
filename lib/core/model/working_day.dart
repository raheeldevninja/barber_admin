class WorkingDay {

  String? weekday;
  bool? isSelected;
  
  WorkingDay({
    required this.weekday,
    required this.isSelected,
  });
  
  
  WorkingDay copyWith({
    String? weekday,
    bool? isSelected,
  }) {
    return WorkingDay(
      weekday: weekday ?? this.weekday,
      isSelected: isSelected ?? this.isSelected,
    );
  }


}