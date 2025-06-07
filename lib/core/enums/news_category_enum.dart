enum NewsCategory {
  general(displayName: "General"),
  business(displayName: "Business"),
  sports(displayName: "Sports"),
  entertainment(displayName: "Entertainment"),
  technology(displayName: "Technology"),
  science(displayName: "Science"),
  health(displayName: "Health"),
  world(displayName: "World"),
  nation(displayName: "Nation");

  final String displayName;

  const NewsCategory({required this.displayName});
}
