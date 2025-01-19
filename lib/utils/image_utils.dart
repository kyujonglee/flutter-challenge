class ImageUtils {
  static const String _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  static String getImageUrl(String? path) {
    if (path == null) return '';
    return '$_imageBaseUrl$path';
  }
}
