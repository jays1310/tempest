import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';

class CustomSearch extends StatefulWidget {
  final VoidCallback onLocationTap;
  final Function(String) onSearch;

  const CustomSearch({
    super.key,
    required this.onLocationTap,
    required this.onSearch,
  });

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  Timer? _debounce;

  void _search() {
    final city = _controller.text.trim();

    if (city.isNotEmpty) {
      widget.onSearch(city);

      context.read<WeatherProvider>().clearSuggestions();

      _focusNode.unfocus();
    }
  }

  void _onSearchChanged(String value) {
    setState(() {});

    _debounce?.cancel();

    if (value.trim().isEmpty) {
      context.read<WeatherProvider>().clearSuggestions();
      return;
    }

    _debounce = Timer(
      const Duration(milliseconds: 400),
          () {
        context.read<WeatherProvider>().searchCities(value);
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .08),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.white24,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: Colors.white70,
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.search,

                        onChanged: _onSearchChanged,

                        onSubmitted: (_) => _search(),

                        decoration: const InputDecoration(
                          hintText: "Search city",
                          hintStyle: TextStyle(
                            color: Colors.white70,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: _controller.text.trim().isEmpty
                          ? IconButton(
                        key: const ValueKey("search"),
                        onPressed: _search,
                        icon: const Icon(
                          Icons.travel_explore_rounded,
                          color: Colors.white,
                        ),
                      )
                          : IconButton(
                        key: const ValueKey("clear"),
                        onPressed: () {
                          _controller.clear();

                          provider.clearSuggestions();

                          setState(() {});

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted) {
                              _focusNode.requestFocus();
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 15),

            InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: widget.onLocationTap,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.my_location,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: provider.suggestions.isEmpty
              ? const SizedBox.shrink()
              : Container(
            key: const ValueKey("suggestions"),
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: .18),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: Colors.white.withValues(alpha: .12),
              ),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.suggestions.length > 5
                  ? 5
                  : provider.suggestions.length,
              separatorBuilder: (_, _) => Divider(
                color: Colors.white.withValues(alpha: .08),
                height: 1,
              ),
              itemBuilder: (context, index) {
                final city = provider.suggestions[index];

                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    _controller.text = city.fullName;

                    setState(() {});

                    widget.onSearch(city.fullName);

                    provider.clearSuggestions();

                    _focusNode.unfocus();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: .08),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.location_on_rounded,
                            color: Colors.white70,
                            size: 20,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                city.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),

                              const SizedBox(height: 3),

                              Text(
                                "${city.region} • ${city.country}",
                                style: TextStyle(
                                  color: Colors.white.withValues(
                                    alpha: .65,
                                  ),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}