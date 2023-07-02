class NavigationStateDTO {
  bool home;
  bool task;
  String? taskId;

  NavigationStateDTO(
    this.home,
    this.task,
    this.taskId,
  );

  NavigationStateDTO.home()
      : home = true,
        task = false,
        taskId = null;
  NavigationStateDTO.taskCreate()
      : home = true,
        task = true,
        taskId = null;
  NavigationStateDTO.task(String id)
      : home = true,
        task = true,
        taskId = id;
}
