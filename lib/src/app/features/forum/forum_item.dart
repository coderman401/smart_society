import 'dart:math';
import 'package:flutter/material.dart';

class ForumItem {
  final String profilePicUrl;
  final String name;
  final String flatNumber;
  final String? forumText;
  final String? forumImageUrl;
  final DateTime date;
  bool isLiked;
  bool isRead;

  ForumItem({
    required this.profilePicUrl,
    required this.name,
    required this.flatNumber,
    this.forumText,
    this.forumImageUrl,
    required this.date,
    this.isLiked = false,
    this.isRead = false,
  });
}
