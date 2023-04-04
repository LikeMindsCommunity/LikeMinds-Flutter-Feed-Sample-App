import 'package:feed_sx/src/views/feed/components/post/post_media/media_model.dart';
import 'package:likeminds_feed/likeminds_feed.dart';

class AllCommentsScreenArguments {
  final Post post;
  final int feedroomId;
  AllCommentsScreenArguments({
    required this.post,
    required this.feedroomId,
  });
}

class LikesScreenArguments {
  final String postId;
  String? commentId;
  bool isCommentLikes;
  LikesScreenArguments({
    required this.postId,
    this.commentId,
    this.isCommentLikes = false,
  });
}

class NewPostScreenArguments {
  final User user;
  final int feedroomId;
  final String feedRoomTitle;
  bool isCm;
  NewPostScreenArguments({
    required this.user,
    required this.feedroomId,
    required this.feedRoomTitle,
    required this.isCm,
  });
}

class MediaPreviewArguments {
  final String postId;
  final List<Attachment>? attachments;
  final List<MediaModel>? mediaFiles;
  MediaPreviewArguments({
    this.attachments,
    this.mediaFiles,
    required this.postId,
  });
}

class DocumentPreviewArguments {
  final String docUrl;
  DocumentPreviewArguments({
    required this.docUrl,
  });
}

class FeedRoomSelectArguments {
  final User user;
  List<FeedRoom> feedRoomIds;
  FeedRoomSelectArguments({
    required this.user,
    required this.feedRoomIds,
  });
}
