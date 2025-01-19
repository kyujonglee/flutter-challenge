import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/services/api_service.dart';
import 'package:movieflix/screens/detail_screen.dart';
import 'package:movieflix/utils/image_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const _SectionTitle(title: 'Popular Movies'),
              const SizedBox(height: 20),
              _MovieSection(
                future: ApiService.getPopularMovies(),
                isLargeCard: true,
              ),
              const SizedBox(height: 20),
              const _SectionTitle(title: 'Now in Cinemas'),
              const SizedBox(height: 20),
              _MovieSection(
                future: ApiService.getNowPlayingMovies(),
              ),
              const SizedBox(height: 20),
              const _SectionTitle(title: 'Coming soon'),
              const SizedBox(height: 20),
              _MovieSection(
                future: ApiService.getComingSoonMovies(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _MovieSection extends StatelessWidget {
  final Future<List<MovieModel>> future;
  final bool isLargeCard;

  const _MovieSection({
    required this.future,
    this.isLargeCard = false,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: isLargeCard ? 200 : 220,
            child: _MovieList(
              movies: snapshot.data!,
              isLargeCard: isLargeCard,
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _MovieList extends StatelessWidget {
  final List<MovieModel> movies;
  final bool isLargeCard;

  const _MovieList({
    required this.movies,
    this.isLargeCard = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      separatorBuilder: (context, index) => const SizedBox(width: 15),
      itemBuilder: (context, index) {
        var movie = movies[index];
        return _MovieCard(
          movie: movie,
          isLargeCard: isLargeCard,
        );
      },
    );
  }
}

class _MovieCard extends StatelessWidget {
  final MovieModel movie;
  final bool isLargeCard;

  const _MovieCard({
    required this.movie,
    required this.isLargeCard,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(id: movie.id),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMovieImage(),
          if (!isLargeCard) ...[
            const SizedBox(height: 10),
            SizedBox(
              width: 150,
              child: Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.visible,
                maxLines: 2,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMovieImage() {
    return Container(
      width: isLargeCard ? 300 : 150,
      height: isLargeCard ? 200 : 150,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Image.network(
        ImageUtils.getImageUrl(movie.backdropPath),
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
