class Meditation {
  final String id;
  final String title;
  final String subtitle;
  final int time;
  final int order;
  final String image;
  final String uri;
  final int track;

  Meditation({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.order,
    required this.image,
    required this.uri,
    required this.track,
  });
}

class MeditationRepository {
  static List<Meditation> popular = [
    Meditation(
      id: 'ff171f80-5960-41e7-965c-1f9bcf31e02c',
      order: 1,
      title: 'Power of Love',
      track: 0,
      subtitle: 'Love and Peace',
      time: 2,
      uri: 'https://goofy-ritchie-dd0c3d.netlify.app/meditations/17.mp3',
      image: 'assets/images/meditate6.jpg',
    ),
    Meditation(
      id: 'ff171f80-5960-41e7-965c-1f9bcf31e02d',
      order: 2,
      title: 'Quick Powerful Meditation',
      track: 1,
      subtitle: 'Busy At Work',
      time: 5,
      uri: 'https://goofy-ritchie-dd0c3d.netlify.app/meditations/1.mp3',
      image: 'assets/images/meditate1.jpg',
    ),
    Meditation(
      id: 'ff171f80-5960-41e7-965c-1f9bcf31e02e',
      order: 3,
      title: 'Deep Breathing',
      track: 2,
      subtitle: 'Just Breath',
      time: 5,
      uri: 'https://goofy-ritchie-dd0c3d.netlify.app/meditations/2.mp3',
      image: 'assets/images/meditate2.jpg',
    ),
    Meditation(
      id: 'ff171f80-5960-41e7-965c-1f9bcf31e02f',
      order: 4,
      title: 'Yawn and Stretch',
      subtitle: 'Rise and Shine',
      track: 3,
      time: 5,
      uri: 'https://goofy-ritchie-dd0c3d.netlify.app/meditations/3.mp3',
      image: 'assets/images/meditate5.jpg',
    ),
  ];

  static List<Meditation> anxiety = [
    Meditation(
      id: 'ff171f80-5960-41e7-965c-1f9bcf31e030',
      order: 1,
      title: 'Deep and Quick Relaxation',
      track: 4,
      subtitle: 'Release Anxiety',
      time: 10,
      uri: 'https://goofy-ritchie-dd0c3d.netlify.app/meditations/4.mp3',
      image: 'assets/images/meditate3.jpg',
    ),
    Meditation(
      id: 'ff171f80-5960-41e7-965c-1f9bcf31e031',
      order: 2,
      title: 'Calming Medition',
      subtitle: 'Deep Relaxation',
      track: 7,
      time: 11,
      uri: 'https://goofy-ritchie-dd0c3d.netlify.app/meditations/7.mp3',
      image: 'assets/images/meditate4.jpg',
    ),
    Meditation(
      id: 'ff171f80-5960-41e7-965c-1f9bcf31e032',
      order: 2,
      title: 'Candle Relaxation',
      subtitle: 'Get Some Rest',
      track: 8,
      time: 11,
      uri: 'https://goofy-ritchie-dd0c3d.netlify.app/meditations/8.mp3',
      image: 'assets/images/rocks.jpg',
    ),
  ];

  static List<Meditation> sleep = [
    Meditation(
      id: 'ff171f80-5960-41e7-965c-1f9bcf31e033',
      order: 1,
      title: 'Deep Sleep',
      subtitle: 'Wake Up Refreshed',
      track: 5,
      time: 8,
      uri: 'https://goofy-ritchie-dd0c3d.netlify.app/meditations/5.mp3',
      image: 'assets/images/tea.jpg',
    ),
    Meditation(
      id: 'ff171f80-5960-41e7-965c-1f9bcf31e034',
      order: 2,
      title: 'Short Sleep',
      subtitle: 'For Taking a Nap',
      track: 6,
      time: 28,
      uri: 'https://goofy-ritchie-dd0c3d.netlify.app/meditations/6.mp3',
      image: 'assets/images/sleep.jpg',
    ),
    Meditation(
      id: 'ff171f80-5960-41e7-965c-1f9bcf31e035',
      order: 2,
      title: 'Good Sleep',
      track: 12,
      subtitle: 'Drift Off To Sleep',
      time: 15,
      uri: 'https://goofy-ritchie-dd0c3d.netlify.app/meditations/12.mp3',
      image: 'assets/images/sleep2.jpg',
    ),
  ];

  static List<Meditation> meditations = [...popular, ...anxiety, ...sleep];
}
