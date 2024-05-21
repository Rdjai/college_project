import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

const defaultDuration = Duration(seconds: 60);
const defaultPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 5);

class countdownTimer extends StatelessWidget {
  const countdownTimer({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: Text('Default'),
          ),
          const SlideCountdown(
            duration: defaultDuration,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: Text('Default SlideCountdownSeparated'),
          ),
          const SlideCountdownSeparated(
            duration: defaultDuration,
            padding: defaultPadding,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: Text('With Icon, Fade true, & SlideDirection.up'),
          ),
          const SlideCountdown(
            duration: defaultDuration,
            slideDirection: SlideDirection.up,
            icon: Padding(
              padding: EdgeInsets.only(right: 5),
              child: Icon(
                Icons.alarm,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: Text('Custom BoxDecoration & SeparatorType.title'),
          ),
          const SlideCountdown(
            duration: defaultDuration,
            separatorType: SeparatorType.title,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: Text('Localization Custom Duration Title'),
          ),
          SlideCountdown(
            duration: defaultDuration,
            separatorType: SeparatorType.title,
            durationTitle: DurationTitle.id(),
            icon: const Padding(
              padding: EdgeInsets.only(right: 5),
              child: Icon(
                Icons.alarm,
                color: Colors.white,
                size: 20,
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ],
      ),
    );
  }
}

// class countDownTimr extends StatefulWidget {
//   const countDownTimr({super.key});

//   @override
//   State<countDownTimr> createState() => _countDownTimrState();
// }

// class _countDownTimrState extends State<countDownTimr> {
//   late final StreamDuration _streamDuration;

//   @override
//   void initState() {
//     super.initState();
//     _streamDuration = StreamDuration(
//       config: const StreamDurationConfig(
//         countDownConfig: CountDownConfig(
//           duration: Duration(seconds: 60),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _streamDuration.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SlideCountdown(
//             // This duration no effect if you customize stream duration
//             streamDuration: _streamDuration,
//           ),
//           const SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () => _streamDuration.pause(),
//             child: const Text('Pause'),
//           ),
//           const SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () => _streamDuration.play(),
//             child: const Text('Play'),
//           ),
//           const SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () {
//               // this will add 10 minutes to the remaining duration
//               _streamDuration.add(const Duration(seconds: 60));
//             },
//             child: const Text('Add Duration'),
//           ),
//           const SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () {
//               // this will subtract 10 minutes to the remaining duration
//               _streamDuration.subtract(const Duration(seconds: 60));
//             },
//             child: const Text('Subtract Duration'),
//           ),
//         ],
//       ),
//     );
//   }
// }
