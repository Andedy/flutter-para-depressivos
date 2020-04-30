import 'package:ui_viagens/models/activity_model.dart';

class Destination{
  String imageUrl;
  String city;
  String country;
  String description;
  List<Activity> activities;

  Destination({
    this.imageUrl,
    this.city,
    this.country,
    this.description,
    this.activities,

  });
}

List<Activity> activities = [
  Activity(
    imageUrl: 'assets/images/stmarksbasilica.jpg',
    name: 'St. Mark\'s Basilica',
    type: 'Passeio Turístico',
    startTimes: ['9:00 am', '11:00 am'],
    rating: 5,
    price: 30,
  ),
  Activity(
    imageUrl: 'assets/images/gondola.jpg',
    name: 'Caminhada e passeio de Gondola',
    type: 'Passeio Turístico',
    startTimes: ['11:00 pm', '1:00 pm'],
    rating: 4,
    price: 210,
  ),
  Activity(
    imageUrl: 'assets/images/murano.jpg',
    name: 'Murano e Burano Tour',
    type: 'Passeio Turístico',
    startTimes: ['12:30 pm', '2:00 pm'],
    rating: 3,
    price: 125,
  ),
];

List<Destination> destinations = [
  Destination(
    imageUrl: 'assets/images/venice.jpg',
    city: 'Veneza',
    country: 'Itália',
    description: 'Visite Veneza e tenha uma experiência incrível na sua vida!',
    activities: activities,
  ),
  Destination(
    imageUrl: 'assets/images/paris.jpg',
    city: 'Paris',
    country: 'França',
    description: 'Visite Paris e tenha uma experiência incrível na sua vida!',
    activities: activities,
  ),
  Destination(
    imageUrl: 'assets/images/newdelhi.jpg',
    city: 'Nova Delhi',
    country: 'Índia',
    description: 'Visite Nova Delhi e tenha uma experiência incrível na sua vida!',
    activities: activities,
  ),
  Destination(
    imageUrl: 'assets/images/saopaulo.jpg',
    city: 'São Paulo',
    country: 'Brasil',
    description: 'Visite São Paulo e tenha uma experiência incrível na sua vida!',
    activities: activities,
  ),
  Destination(
    imageUrl: 'assets/images/newyork.jpg',
    city: 'Nova York',
    country: 'Estados Unidos',
    description: 'Visite Nova York e tenha uma experiência incrível na sua vida!',
    activities: activities,
  ),
];