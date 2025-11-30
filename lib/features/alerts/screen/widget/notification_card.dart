import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  // final String logo;

  const NotificationCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    // required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      // elevation: 4,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          TRoundedImage(width:48,height:48,imageType: ImageType.asset,image: TImages.appLogo,),
          /// Logo
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(50),
          //   child: Image.network(
          //     logo,
          //     width: 48,
          //     height: 48,
          //     fit: BoxFit.cover,
          //     errorBuilder: (_, __, ___) => Icon(Icons.notifications, size: 48),
          //   ),
          // ),

          const SizedBox(width: 12),

          /// Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  description[0].toUpperCase()+description.substring(1),
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    THelperFunctions.formatDateTimeWithSecString(date),
                    style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.darkGrey),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
