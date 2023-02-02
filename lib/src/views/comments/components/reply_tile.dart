import 'package:likeminds_feed/likeminds_feed.dart';
import 'package:feed_sx/feed.dart';
import 'package:feed_sx/src/packages/expandable_text/expandable_text.dart';
import 'package:feed_sx/src/services/likeminds_service.dart';
import 'package:feed_sx/src/utils/constants/assets_constants.dart';
import 'package:feed_sx/src/utils/constants/ui_constants.dart';
import 'package:feed_sx/src/utils/utils.dart';
import 'package:feed_sx/src/views/comments/blocs/comment_replies/comment_replies_bloc.dart';
import 'package:feed_sx/src/views/comments/blocs/toggle_like_comment/toggle_like_comment_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReplyTile extends StatefulWidget {
  final String postId;
  final CommentReply reply;
  final PostUser user;
  const ReplyTile(
      {super.key,
      required this.reply,
      required this.user,
      required this.postId});

  @override
  State<ReplyTile> createState() => _ReplyTileState();
}

class _ReplyTileState extends State<ReplyTile> {
  late final ToggleLikeCommentBloc _toggleLikeCommentBloc;
  late final CommentRepliesBloc _commentRepliesBloc;
  late final CommentReply reply;
  late final PostUser user;
  late final String postId;
  bool isLiked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reply = widget.reply;
    user = widget.user;
    postId = widget.postId;
    isLiked = reply.isLiked;
    FeedApi feedApi = locator<LikeMindsService>().getFeedApi();
    _toggleLikeCommentBloc = ToggleLikeCommentBloc(feedApi: feedApi);
    _commentRepliesBloc = CommentRepliesBloc(feedApi: feedApi);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: kWhiteColor),
      padding: EdgeInsets.all(kPaddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.user.name,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              )
            ],
          ),
          kVerticalPaddingSmall,
          ExpandableText(widget.reply.text,
              expandText: 'show more', collapseText: 'show less'),
          kVerticalPaddingLarge,
          Row(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLiked = !isLiked;
                      });

                      _toggleLikeCommentBloc.add(ToggleLikeComment(
                          toggleLikeCommentRequest: ToggleLikeCommentRequest(
                        commentId: reply.id,
                        postId: postId,
                      )));
                    },
                    child: Builder(builder: ((context) {
                      return isLiked
                          ? SvgPicture.asset(
                              kAssetLikeFilledIcon,
                              // color: kPrimaryColor,
                              height: 12,
                            )
                          : SvgPicture.asset(
                              kAssetLikeIcon,
                              color: kGrey3Color,
                              height: 12,
                            );
                    })),
                  ),
                  kHorizontalPaddingSmall,
                  Text(
                    'Like',
                    style: TextStyle(fontSize: kFontSmall, color: kGrey3Color),
                  ),
                ],
              ),
              // kHorizontalPaddingMedium,
              // Text(
              //   '|',
              //   style: TextStyle(fontSize: kFontSmall, color: kGrey3Color),
              // ),
              // kHorizontalPaddingMedium,
              // Text(
              //   'Reply',
              //   style: TextStyle(fontSize: kFontSmall, color: kGrey3Color),
              // ),
              // kHorizontalPaddingMedium,
              // Text(
              //   '·',
              //   style: TextStyle(fontSize: kFontSmall, color: kGrey3Color),
              // ),
              // kHorizontalPaddingMedium,
              // GestureDetector(
              //   onTap: () {
              //     _commentRepliesBloc.add(GetCommentReplies(
              //         commentDetailRequest: CommentDetailRequest(
              //             commentId: reply.id, page: 1, postId: postId),
              //         forLoadMore: false));
              //   },
              //   child: Text(
              //     "${widget.reply.repliesCount}  replies",
              //     style: TextStyle(fontSize: kFontSmall, color: kPrimaryColor),
              //   ),
              // ),
              // BlocBuilder(
              //     bloc: _commentRepliesBloc,
              //     builder: ((context, state) {
              //       if (state is CommentRepliesLoading) {
              //         return Container(
              //           height: 20,
              //           width: 20,
              //           child: CircularProgressIndicator(),
              //         );
              //       }
              //       if (state is CommentRepliesLoaded) {
              //         return ListView.builder(
              //           itemBuilder: ((context, index) {
              //             return ReplyTile(
              //               reply:
              //                   state.commentDetails.postReplies.replies[index],
              //               user: state.commentDetails.users[state
              //                   .commentDetails
              //                   .postReplies
              //                   .replies[index]
              //                   .userId]!,
              //               postId: postId,
              //             );
              //           }),
              //           itemCount:
              //               state.commentDetails.postReplies.replies.length,
              //           shrinkWrap: true,
              //         );
              //       }
              //       return Container();
              //     })),
              Spacer(),
              Text(
                reply.createdAt.timeAgo(),
                style: TextStyle(fontSize: kFontSmall, color: kGrey3Color),
              ),
            ],
          )
        ],
      ),
    );
  }
}
