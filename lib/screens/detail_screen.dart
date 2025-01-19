import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_detail_model.dart';
import 'package:movieflix/services/api_service.dart';
import 'package:movieflix/utils/image_utils.dart';

class DetailScreenStyles {
  static const titleStyle = TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w800,
  );

  static const sectionTitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.w800,
  );

  static const bodyTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  static const buttonTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
}

class DetailScreen extends StatefulWidget {
  final int id;

  const DetailScreen({
    super.key,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> movie;

  @override
  void initState() {
    super.initState();
    movie = ApiService.getMovieDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Back to list',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
      future: movie,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildMovieDetail(snapshot.data!);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildMovieDetail(MovieDetailModel movie) {
    return Stack(
      children: [
        _buildBackgroundImage(movie.posterPath),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMovieTitle(movie.title),
              const SizedBox(height: 10),
              _buildRatingStars(movie.voteAverage),
              const SizedBox(height: 20),
              _buildMovieInfo(movie),
              const SizedBox(height: 30),
              _buildStorylineSection(movie.overview),
              const SizedBox(height: 30),
              _buildBuyTicketButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundImage(String posterPath) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(ImageUtils.getImageUrl(posterPath)),
          fit: BoxFit.cover,
          colorFilter: const ColorFilter.mode(
            Colors.black54,
            BlendMode.darken,
          ),
        ),
      ),
    );
  }

  Widget _buildMovieTitle(String title) {
    return Text(title, style: DetailScreenStyles.titleStyle);
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < (rating / 2).round() ? Icons.star : Icons.star_border,
          color: Colors.yellow,
        ),
      ),
    );
  }

  Widget _buildMovieInfo(MovieDetailModel movie) {
    final duration =
        '${(movie.runtime / 60).floor()}h ${movie.runtime % 60}min';
    final genres = movie.genres.map((genre) => genre.name).join(', ');

    return Text(
      '$duration | $genres',
      style: DetailScreenStyles.bodyTextStyle,
    );
  }

  Widget _buildStorylineSection(String overview) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Storyline', style: DetailScreenStyles.sectionTitleStyle),
        const SizedBox(height: 10),
        Text(
          overview,
          style: DetailScreenStyles.bodyTextStyle.copyWith(height: 1.5),
        ),
      ],
    );
  }

  Widget _buildBuyTicketButton() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text('Buy ticket', style: DetailScreenStyles.buttonTextStyle),
      ),
    );
  }
}
