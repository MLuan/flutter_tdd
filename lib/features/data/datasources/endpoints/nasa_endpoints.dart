class NasaEndpoints {
  static String apodEndpoints(String apiKey, String date) =>
      "https://api.nasa.gov/planetary/apod?api_key=$apiKey&date=$date";
}
