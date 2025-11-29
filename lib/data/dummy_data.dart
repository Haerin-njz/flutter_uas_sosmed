class User {
  final String id;
  final String username; // handle
  final String displayName;
  final String avatarUrl;
  final String email;
  final String bio;
  final bool isVerified;

  User({
    required this.id,
    required this.username,
    required this.displayName,
    required this.avatarUrl,
    required this.email,
    this.bio = '',
    this.isVerified = false,
  });
}

class Story {
  final String id;
  final User user;
  final String imageUrl;
  final bool isViewed;

  Story({
    required this.id,
    required this.user,
    required this.imageUrl,
    this.isViewed = false,
  });
}

class Post {
  final String id;
  final User user;
  final String imageUrl;
  final String caption;
  final int likesCount;
  final String timeAgo;

  Post({
    required this.id,
    required this.user,
    required this.imageUrl,
    required this.caption,
    required this.likesCount,
    required this.timeAgo,
  });
}

class Reel {
  final String id;
  final User user;
  final String videoUrl;
  final String thumbnailUrl;
  final String caption;
  final int likesCount;
  final int commentsCount;
  final String timeAgo;

  Reel({
    required this.id,
    required this.user,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.caption,
    required this.likesCount,
    required this.commentsCount,
    required this.timeAgo,
  });
}

class Comment {
  final String id;
  final User user;
  final String text;
  final String timeAgo;

  Comment({
    required this.id,
    required this.user,
    required this.text,
    required this.timeAgo,
  });
}

final List<User> dummyUsers = [
  User(
    id: 'u1',
    username: 'ravya',
    displayName: 'Ravya Pratama',
    avatarUrl: 'https://i.pravatar.cc/150?img=32',
    email: 'ravya@example.com',
    bio: 'Mobile dev • Flutter enthusiast',
    isVerified: true,
  ),
  User(
    id: 'u2',
    username: 'mayaart',
    displayName: 'Maya Aziz',
    avatarUrl: 'https://i.pravatar.cc/150?img=12',
    email: 'maya@example.com',
    bio: 'Photographer • Travel',
    isVerified: false,
  ),
  User(
    id: 'u3',
    username: 'nizar',
    displayName: 'Nizar H.',
    avatarUrl: 'https://i.pravatar.cc/150?img=5',
    email: 'nizar@example.com',
    bio: 'UX Designer',
    isVerified: false,
  ),
  User(
    id: 'u4',
    username: 'lina.codes',
    displayName: 'Lina Putri',
    avatarUrl: 'https://i.pravatar.cc/150?img=8',
    email: 'lina@example.com',
    bio: 'Open-source contributor',
    isVerified: false,
  ),
  User(
    id: 'u5',
    username: 'dev_ali',
    displayName: 'Ali Rahman',
    avatarUrl: 'https://i.pravatar.cc/150?img=16',
    email: 'ali@example.com',
    bio: 'Game dev',
    isVerified: false,
  ),
  User(
    id: 'u6',
    username: 'ayla',
    displayName: 'Ayla Sari',
    avatarUrl: 'https://i.pravatar.cc/150?img=24',
    email: 'ayla@example.com',
    bio: 'Foodie & Chef',
    isVerified: false,
  ),
  User(
    id: 'u7',
    username: 'tariq',
    displayName: 'Tariq Z.',
    avatarUrl: 'https://i.pravatar.cc/150?img=28',
    email: 'tariq@example.com',
    bio: 'Runner • Coach',
    isVerified: false,
  ),
  User(
    id: 'u8',
    username: 'siti_art',
    displayName: 'Siti Rahma',
    avatarUrl: 'https://i.pravatar.cc/150?img=55',
    email: 'siti@example.com',
    bio: 'Illustrator',
    isVerified: false,
  ),
  User(
    id: 'u9',
    username: 'fandi',
    displayName: 'Fandi W.',
    avatarUrl: 'https://i.pravatar.cc/150?img=9',
    email: 'fandi@example.com',
    bio: 'Photographer',
    isVerified: false,
  ),
  User(
    id: 'u10',
    username: 'dika',
    displayName: 'Dika',
    avatarUrl: 'https://i.pravatar.cc/150?img=21',
    email: 'dika@example.com',
    bio: '',
    isVerified: false,
  ),
];

final List<Story> dummyStories = List.generate(
  dummyUsers.length,
  (i) => Story(
    id: 'story_${i + 1}',
    user: dummyUsers[i],
    imageUrl: 'https://picsum.photos/seed/story_${i + 1}/400/800',
    isViewed: i % 4 == 0,
  ),
);

final List<Post> dummyPosts = List.generate(14, (i) {
  final user = dummyUsers[i % dummyUsers.length];
  return Post(
    id: 'post_${i + 1}',
    user: user,
    imageUrl: 'https://picsum.photos/seed/post_${i + 1}/900/900',
    caption: '${user.displayName} — exploring the world #${i + 1}',
    likesCount: 120 + i * 7,
    timeAgo: '${i + 1}d',
  );
});

final List<Reel> dummyReels = List.generate(10, (i) {
  final user = dummyUsers[i % dummyUsers.length];
  return Reel(
    id: 'reel_${i + 1}',
    user: user,
    videoUrl: 'https://picsum.photos/seed/reel_${i + 1}/400/800', // Placeholder
    thumbnailUrl: 'https://picsum.photos/seed/reel_thumb_${i + 1}/400/800',
    caption: '${user.displayName} — quick reel #${i + 1}',
    likesCount: 500 + i * 50,
    commentsCount: 20 + i * 5,
    timeAgo: '${i + 1}h',
  );
});

final Map<String, List<Comment>> dummyComments = {
  for (var post in dummyPosts)
    post.id: List.generate(
      3 + (post.id.hashCode % 5),
      (i) => Comment(
        id: 'comment_${post.id}_$i',
        user: dummyUsers[(i + post.id.hashCode) % dummyUsers.length],
        text:
            'Great post! ${['Love it', 'Amazing', 'So cool', 'Nice work', 'Beautiful'][i % 5]}',
        timeAgo: '${i + 1}h',
      ),
    ),
};
