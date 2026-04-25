import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:spjewellery/models/advertisement_model.dart';
import 'package:spjewellery/router/route_helper.dart';

import 'package:url_launcher/url_launcher.dart';

class AdvertisementScreen extends StatefulWidget {
  final List<AdvertisementData> images;
  final int skipSeconds;
  final Duration? autoAdvanceInterval;
  final VoidCallback? onFinish;

  const AdvertisementScreen({
    super.key,
    required this.images,
    this.skipSeconds = 8,
    this.autoAdvanceInterval = const Duration(seconds: 2),
    this.onFinish,
  });

  @override
  State<AdvertisementScreen> createState() => _AdvertisementScreenState();
}

class _AdvertisementScreenState extends State<AdvertisementScreen> {
  late final PageController _pageController;
  late int _currentPage;
  Timer? _countdownTimer;
  int _remainingSeconds = 0;
  Timer? _autoAdvanceTimer;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _pageController = PageController(initialPage: 0);
    _startCountdown();
    if (widget.autoAdvanceInterval != null) {
      _startAutoAdvance(widget.autoAdvanceInterval!);
    }
  }

  void _startCountdown() {
    _remainingSeconds = widget.skipSeconds;
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _remainingSeconds--;
      });
      if (_remainingSeconds <= 0) {
        _countdownTimer?.cancel();
        _finishAndNavigate();
      }
    });
  }

  void _startAutoAdvance(Duration interval) {
    _autoAdvanceTimer?.cancel();
    _autoAdvanceTimer = Timer.periodic(interval, (timer) {
      if (!mounted) return;
      final next = (_currentPage + 1) % widget.images.length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  void _finishAndNavigate() {
    // Stop timers
    _countdownTimer?.cancel();
    _autoAdvanceTimer?.cancel();

    if (widget.onFinish != null) {
      widget.onFinish!();
      return;
    }

    // Default action: push replacement to a placeholder HomeScreen
    Get.offAllNamed(RouteHelper.nav);
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _autoAdvanceTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildImage(String path, {VoidCallback? onTap}) {
    if (path.toLowerCase().startsWith('http')) {
      return GestureDetector(
        onTap: onTap,
        child: CachedNetworkImage(
          imageUrl: path,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          placeholder:
              (context, url) =>
                  const Center(child: CircularProgressIndicator()),
          errorWidget:
              (context, url, error) =>
                  const Center(child: Icon(Icons.broken_image)),
        ),
      );
    } else {
      return GestureDetector(
        onTap: onTap,
        child: CachedNetworkImage(
          imageUrl: path,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          placeholder:
              (context, url) =>
                  const Center(child: CircularProgressIndicator()),
          errorWidget:
              (context, url, error) =>
                  const Center(child: Icon(Icons.broken_image)),
        ),
      );
    }
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.images.length, (i) {
        final isActive = i == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 12 : 8,
          height: isActive ? 12 : 8,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.white54,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    final Uri launchUri = Uri.parse(url);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri, mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // PageView with images
            PageView.builder(
              controller: _pageController,
              itemCount: widget.images.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return _buildImage(
                  widget.images[index].imageUrl.toString(),
                  onTap: () {
                    _launchInBrowser(widget.images[index].link.toString());
                  },
                );
              },
            ),
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: _finishAndNavigate,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.close, color: Colors.white, size: 18),
                      SizedBox(width: 6),
                      Text(
                        'Skip ${_remainingSeconds}s',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom: page indicators + CTA (optional)
            Positioned(
              left: 0,
              right: 0,
              bottom: 20 + media.padding.bottom,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [_buildPageIndicator(), SizedBox(height: 60)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
