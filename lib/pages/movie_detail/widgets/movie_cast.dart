// lib/pages/movie_detail/widgets/movie_cast.dart
import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/movie_credits_model.dart';

class MovieCast extends StatelessWidget {
  final Future<Credits> movieCredits;

  const MovieCast({Key? key, required this.movieCredits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Credits>(
      future: movieCredits,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final credits = snapshot.data!;

          // Exibe o elenco principal
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Elenco Principal",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: credits.cast.length,
                    itemBuilder: (context, index) {
                      final castMember = credits.cast[index];
                      return Container(
                        width: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: castMember.profilePath.isNotEmpty
                                  ? Image.network(
                                      '$imageUrl${castMember.profilePath}',
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'images/avatar_placeholder.png',
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              castMember.name,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              castMember.character,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Exibe a equipe técnica principal
                const SizedBox(height: 20),
                const Text(
                  "Equipe Técnica",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: credits.crew.length,
                  itemBuilder: (context, index) {
                    final crewMember = credits.crew[index];
                    // Filtra para mostrar apenas diretor e roteiristas
                    if (crewMember.job == 'Director' ||
                        crewMember.job == 'Screenplay' ||
                        crewMember.job == 'Writer') {
                      return ListTile(
                        leading: crewMember.profilePath.isNotEmpty
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                    '$imageUrl${crewMember.profilePath}'),
                              )
                            : const CircleAvatar(
                                backgroundImage:
                                    AssetImage('images/avatar_placeholder.png'),
                              ),
                        title: Text(
                          crewMember.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          crewMember.job,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('Nenhuma informação disponível.'));
        }
      },
    );
  }
}
