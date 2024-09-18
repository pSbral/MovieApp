// lib/pages/movie_detail/widgets/movie_trailer.dart
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_trailer_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailer extends StatefulWidget {
  final Future<VideoResult> movieVideos;

  const MovieTrailer({Key? key, required this.movieVideos}) : super(key: key);

  @override
  State<MovieTrailer> createState() => _MovieTrailerState();
}

class _MovieTrailerState extends State<MovieTrailer> {
  YoutubePlayerController? _youtubeController;

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<VideoResult>(
      future: widget.movieVideos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(); // Ou um indicador de carregamento
        } else if (snapshot.hasError) {
          return const SizedBox();
        } else if (snapshot.hasData) {
          final videos = snapshot.data!.videos;
          if (videos.isNotEmpty) {
            // Filtra para pegar o trailer oficial do YouTube
            final trailer = videos.firstWhere(
              (video) => video.type == 'Trailer' && video.site == 'YouTube',
              orElse: () => videos.first,
            );

            _youtubeController = YoutubePlayerController(
              initialVideoId: trailer.key,
              flags: const YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
              ),
            );

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10), // Margem adicionada
              child: YoutubePlayer(
                controller: _youtubeController!,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.red,
              ),
            );
          } else {
            return const Center(child: Text('Trailer não disponível.'));
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
