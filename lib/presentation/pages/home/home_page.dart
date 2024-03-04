import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/presentation/providers/audio_player_provider/audio_player_provider.dart';
import 'package:music_app/presentation/providers/songs_provider/songs_provider.dart';
import 'package:music_app/presentation/widgets/music_tile_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            // app title app bar
            SliverAppBar(
              backgroundColor: AppColors.scaffoldBg,
              toolbarHeight: context.height(80),
              title: Text(
                "Zing",
                style: GoogleFonts.pacifico(
                  color: AppColors.white,
                  fontSize: context.width(40),
                ),
              ),
              floating: true,
            ),
            // list view
            ref.watch(songsProvider).when(
                  data: (data) => SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => InkWell(
                        onTap: () {
                          ref.read(playBarProvider.notifier).state = true;
                          // read song path
                          ref
                              .read(audioPlayerProvider)
                              .setFilePath(data[index].data);
                          // play song for click
                          ref.read(audioPlayerProvider).play();
                        },
                        child: MusicTileWidget(
                          songName: data[index].title.substring(0, 20),
                          singer: data[index].artist ?? '',
                        ),
                      ),
                      childCount: data.length,
                    ),
                  ),
                  error: (error, stackTrace) => SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Text("error ocuured${error.toString()}"),
                        IconButton(
                          onPressed: () {
                            ref.invalidate(songsProvider);
                          },
                          icon: const Icon(
                            Icons.repeat_outlined,
                          ),
                        )
                      ],
                    ),
                  ),
                  loading: () => SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        const Center(
                          child: CircularProgressIndicator(),
                        )
                      ],
                    ),
                  ),
                )
          ],
        ),
      ),
    );
  }
}
