class DummyUser {
  final String avatarUrl;
  final String name;

  DummyUser({required this.avatarUrl, required this.name});
}

/// Minimal dummy users. Replace with real fixtures or a user repository later.
final List<DummyUser> dummyUsers = [
  DummyUser(avatarUrl: 'https://i.pravatar.cc/150?img=1', name: 'Alice'),
  DummyUser(avatarUrl: 'https://i.pravatar.cc/150?img=2', name: 'Bob'),
  DummyUser(avatarUrl: 'https://i.pravatar.cc/150?img=3', name: 'Carol'),
];
