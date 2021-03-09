import 'package:flutter/material.dart';
import 'package:marrat/app/locator.dart';
import 'package:marrat/models/mosque/prayer.dart';
import 'package:marrat/styles/text_styles.dart';
import 'package:marrat/ui/setup_services_ui/bottom_sheet_type.dart';
import 'package:marrat/ui/widgets/times/table_data_grid.dart';

import 'package:stacked_services/stacked_services.dart';

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final builders = {
    BottomSheetType.floating: (context, sheetRequest, completer) =>
        _FloatingBoxBottomSheet(
          request: sheetRequest,
          onDismissPressed: completer,
        )
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}

class TimesBottomSheetArguments {
  final List<Prayer> prayers;
  final Function onEditPressed;
  TimesBottomSheetArguments(this.prayers, this.onEditPressed);
}

class _FloatingBoxBottomSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) onDismissPressed;
  const _FloatingBoxBottomSheet({
    Key key,
    this.request,
    this.onDismissPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimesBottomSheetArguments args = request.customData;
    return Container(
      margin: EdgeInsets.all(25),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(request.title,
                textAlign: TextAlign.center, style: kcMainHeadingStyle),
            if (args != null)
              TimesDataGrid(
                isEdit: false,
                onPrayerTimePressed: () {},
                prayers: args.prayers,
              ),
            if (args == null) Text('Missing arguments'),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: args.onEditPressed,
                  child: Text(
                    'Edit Times',
                    style: kcSubHeadingStyle(Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
