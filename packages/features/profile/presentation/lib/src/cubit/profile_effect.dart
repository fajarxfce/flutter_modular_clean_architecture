abstract class ProfileEffect {}

class ShowProfileDialog extends ProfileEffect {
  final String message;

  ShowProfileDialog(this.message);
}
