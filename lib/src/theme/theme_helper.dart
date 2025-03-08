import 'package:flutter/material.dart';

BoxDecoration defaultCourtDecoration({double radius = 16}) => BoxDecoration(
      color: null,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      border: Border.all(
        width: 2,
        color: Colors.green.withValues(alpha: 0.67),
      ),
    );

BoxDecoration selectedCourtDecoration({double radius = 16}) => BoxDecoration(
      color: Colors.green.withValues(alpha: 0.87),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      border: Border.all(
        width: 2,
        color: Colors.green.withValues(alpha: 0.67),
      ),
    );

BoxDecoration disabledCourtDecoration({double radius = 16}) => BoxDecoration(
      color: Color(0x199CA3AF),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      border: Border.all(
        width: 2,
        color: Color(0xffe2e2e2),
      ),
    );
