import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/pokemon.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var pokapi =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  List pokedex = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      fetchPokemonData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -50,
            right: -50,
            child: Image.asset(
              'images/pokeball.png',
              width: 200,
              fit: BoxFit.fitHeight,
            ),
          ),

          Positioned(
            top: 100,
            left: 20,
            child: Text(
              "Pokedex",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          Positioned(
            top: 150,
            bottom: 0,
            width: width,
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.4,
                    ),
                    itemCount: pokedex.length,
                    itemBuilder: (context, index) {
                      var type = pokedex[index]['type'][0];
                      return InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 12.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  type == 'Grass'
                                      ? Colors.green
                                      : type == 'Fire'
                                      ? Colors.red
                                      : type == 'Water'
                                      ? Colors.blue
                                      : type == 'Bug'
                                      ? Colors.lightGreenAccent
                                      : type == 'Electric'
                                      ? Colors.yellow
                                      : type == 'Rock'
                                      ? Colors.blueGrey
                                      : type == 'Ground'
                                      ? Colors.brown
                                      : type == 'Psychic'
                                      ? Colors.purpleAccent
                                      : type == 'Fighting'
                                      ? Colors.orange
                                      : type == 'Ghost'
                                      ? Colors.deepPurple
                                      : type == 'Normal'
                                      ? Colors.grey
                                      : type == 'Poison'
                                      ? Colors.pinkAccent
                                      : type == 'Ice'
                                      ? Colors.lightBlueAccent
                                      : Colors.lime,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            // color: Colors.green,
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: -10,
                                  right: -10,
                                  child: Image.asset(
                                    'images/pokeball.png',
                                    height: 100,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),

                                Positioned(
                                  top: 20,
                                  left: 10,
                                  child: Text(
                                    pokedex[index]['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: 50,
                                  left: 10,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: Colors.black26,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8.0,
                                        right: 8.0,
                                        top: 4.0,
                                        bottom: 4.0,
                                      ),
                                      child: Text(
                                        type.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: Hero(
                                    tag: index,
                                    child: CachedNetworkImage(
                                      imageUrl: pokedex[index]['img'],
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => Pokemon(
                                    pokemon: pokedex[index],
                                    color:
                                        type == 'Grass'
                                            ? Colors.green
                                            : type == 'Fire'
                                            ? Colors.red
                                            : type == 'Water'
                                            ? Colors.blue
                                            : type == 'Bug'
                                            ? Colors.lightGreenAccent
                                            : type == 'Electric'
                                            ? Colors.yellow
                                            : type == 'Rock'
                                            ? Colors.blueGrey
                                            : type == 'Ground'
                                            ? Colors.brown
                                            : type == 'Psychic'
                                            ? Colors.purpleAccent
                                            : type == 'Fighting'
                                            ? Colors.orange
                                            : type == 'Ghost'
                                            ? Colors.deepPurple
                                            : type == 'Normal'
                                            ? Colors.grey
                                            : type == 'Poison'
                                            ? Colors.pinkAccent
                                            : type == 'Ice'
                                            ? Colors.lightBlueAccent
                                            : Colors.lime,
                                    heroTag: index,
                                  ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                // Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void fetchPokemonData() {
    var url = Uri.https(
      "raw.githubusercontent.com",
      "/Biuni/PokemonGO-Pokedex/master/pokedex.json",
    );
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodedJsonData = jsonDecode(value.body);
        pokedex = decodedJsonData['pokemon'];
        // print(pokedex[1]['name']);
        setState(() {});
      }
    });
  }
}
