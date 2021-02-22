import 'package:flutter/material.dart';
import 'package:marrat/app/locator.dart';
import 'package:marrat/enums/dialog_type.dart';
import 'package:stacked_services/stacked_services.dart';

 setupDialogUi()  {
  var dialogService = locator<DialogService>();

    dialogService.registerCustomDialogBuilder(
    variant: DialogType.confirmation,
    builder: (BuildContext context, DialogRequest dialogRequest) => Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              dialogRequest.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              dialogRequest.description,
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                    onPressed: () => dialogService
                        .completeDialog(DialogResponse(confirmed: false)),
                    child: Text("No")),
                SizedBox(
                  width: 10,
                ),
                FlatButton(
                    onPressed: () => dialogService
                        .completeDialog(DialogResponse(confirmed: true)),
                    child: Text("Yes")),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
/*
onTap: () =>
dialogService.completeDialog(DialogResponse(confirmed: true)),*/
