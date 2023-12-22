import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src/constants/app_colors.dart';
import '../../../../src/features/weather/application/providers.dart';

class CitySearchBox extends ConsumerStatefulWidget {
  const CitySearchBox({super.key});
  @override
  ConsumerState<CitySearchBox> createState() => _CitySearchRowState();
}

class _CitySearchRowState extends ConsumerState<CitySearchBox> {
  static const _radius = 10.0;

  late final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = ref.read(cityProvider);

  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: _radius * 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                    color: Colors.black,
                    width: 2,),
                    borderRadius: BorderRadius.circular(_radius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 10, // Adjust the blur radius as needed
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  // Adjust the sigma values as needed
                  child: TextField(
                    controller: _searchController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintFadeDuration: Duration(milliseconds:500),
                      prefixIcon: Icon(Icons.search_outlined),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _searchController.text = ""; // Set the text to an empty string
                          });
                        },
                      ),
                      fillColor: Colors.white.withOpacity(0.4),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(_radius),
                      ),
                    ),
                    onSubmitted: (value) =>
                    ref
                        .read(cityProvider.notifier)
                        .state = value,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}