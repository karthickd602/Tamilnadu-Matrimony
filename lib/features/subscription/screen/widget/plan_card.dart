import '../../../../utils/constants/path_provider.dart';
import '../../model/subscription_model.dart';

class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key, required this.plan, required this.selected,
  });
  final SubscriptionPlan plan;final bool selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected ? Colors.red : Colors.grey.shade300,
          width: selected ? 2 : 1,
        ),
        color: selected ? Colors.red.withOpacity(0.05) : Colors.white,
      ),
      child: Column(
        children: [
          Icon(
            selected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: selected ? Colors.red : Colors.grey,
          ),
          const SizedBox(height: 8),
          Text(
            plan.name.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selected ? Colors.red : Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "${plan.unlocks} unlocks",
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
          const SizedBox(height: 10),
          Text(
            "₹ ${plan.price}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            "₹ ${plan.originalPrice}",
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}
