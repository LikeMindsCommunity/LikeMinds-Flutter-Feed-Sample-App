import 'dart:io';

import 'package:feed_sx/feed.dart';
import 'package:feed_sx/src/services/media_service.dart';
import 'package:feed_sx/src/utils/credentials/credentials.dart';
import 'package:feed_sx/src/utils/local_preference/user_local_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:likeminds_feed/likeminds_feed.dart';

const bool _prodFlag = false;

abstract class ILikeMindsService {
  Future<InitiateUserResponse> initiateUser(InitiateUserRequest request);
  Future<MemberStateResponse> getMemberState();
  Future<GetFeedResponse?> getFeed(GetFeedRequest request);
  Future<GetFeedRoomResponse> getFeedRoom(GetFeedRoomRequest request);
  Future<GetFeedOfFeedRoomResponse> getFeedOfFeedRoom(
      GetFeedOfFeedRoomRequest request);
  Future<AddPostResponse> addPost(AddPostRequest request);
  Future<GetPostResponse> getPost(GetPostRequest request);
  Future<PostDetailResponse> getPostDetails(PostDetailRequest request);
  Future<GetPostLikesResponse> getPostLikes(GetPostLikesRequest request);
  Future<PinPostResponse> pinPost(PinPostRequest request);
  Future<EditPostResponse> editPost(EditPostRequest request);
  Future<GetCommentLikesResponse> getCommentLikes(
      GetCommentLikesRequest request);
  Future<DeletePostResponse> deletePost(DeletePostRequest request);
  Future<LikePostResponse> likePost(LikePostRequest request);
  Future<AddCommentResponse> addComment(AddCommentRequest request);
  Future<GetCommentResponse> getComment(GetCommentRequest request);
  Future<ToggleLikeCommentResponse> toggleLikeComment(
      ToggleLikeCommentRequest request);
  Future<DeleteCommentResponse> deleteComment(DeleteCommentRequest request);
  Future<EditCommentResponse> editComment(EditCommentRequest request);
  Future<AddCommentReplyResponse> addCommentReply(
      AddCommentReplyRequest request);
  Future<EditCommentReplyResponse> editCommentReply(
      EditCommentReplyRequest request);
  Future<String?> uploadFile(File file, String userUniqueId);
  Future<RegisterDeviceResponse> registerDevice(RegisterDeviceRequest request);
  Future<GetTaggingListResponse> getTaggingList(
      {required GetTaggingListRequest request});
  Future<DecodeUrlResponse> decodeUrl(DecodeUrlRequest request);
  Future<GetDeleteReasonResponse> getReportTags(GetDeleteReasonRequest request);
  void routeToProfile(String userId);
}

class LikeMindsService implements ILikeMindsService {
  late final LMFeedClient _sdkApplication;
  late final MediaService _mediaService;

  int? feedroomId;

  set setFeedroomId(int feedroomId) {
    debugPrint("UI Layer: FeedroomId set to $feedroomId");
    this.feedroomId = feedroomId;
  }

  get getFeedroomId => feedroomId;

  LikeMindsService(LMSDKCallback sdkCallback, String apiKey) {
    print("UI Layer: LikeMindsService initialized");
    _mediaService = MediaService(_prodFlag);
    final String key = apiKey.isEmpty
        ? _prodFlag
            ? CredsProd.apiKey
            : CredsDev.apiKey
        : apiKey;
    _sdkApplication = (LMFeedClientBuilder()
          ..apiKey(key)
          ..sdkCallback(sdkCallback))
        .build();
    LMAnalytics.get().initialize();
  }

  @override
  Future<InitiateUserResponse> initiateUser(InitiateUserRequest request) async {
    UserLocalPreference userLocalPreference = UserLocalPreference.instance;
    await userLocalPreference.initialize();
    return await _sdkApplication.initiateUser(request);
  }

  @override
  Future<GetFeedResponse?> getFeed(GetFeedRequest request) async {
    return await _sdkApplication.getFeed(request);
  }

  @override
  Future<AddPostResponse> addPost(AddPostRequest request) async {
    return await _sdkApplication.addPost(request);
  }

  @override
  Future<DeletePostResponse> deletePost(DeletePostRequest request) async {
    return await _sdkApplication.deletePost(request);
  }

  @override
  Future<GetPostResponse> getPost(GetPostRequest request) async {
    return await _sdkApplication.getPost(request);
  }

  @override
  Future<GetPostLikesResponse> getPostLikes(GetPostLikesRequest request) async {
    return await _sdkApplication.getPostLikes(request);
  }

  @override
  Future<GetCommentLikesResponse> getCommentLikes(
      GetCommentLikesRequest request) async {
    return await _sdkApplication.getCommentLikes(request);
  }

  @override
  Future<LikePostResponse> likePost(LikePostRequest likePostRequest) async {
    return await _sdkApplication.likePost(likePostRequest);
  }

  @override
  Future<PinPostResponse> pinPost(PinPostRequest pinPostRequest) async {
    return await _sdkApplication.pinPost(pinPostRequest);
  }

  @override
  Future<EditPostResponse> editPost(EditPostRequest editPostRequest) async {
    return await _sdkApplication.editPost(editPostRequest);
  }

  @override
  Future<AddCommentResponse> addComment(
      AddCommentRequest addCommentRequest) async {
    return await _sdkApplication.addComment(addCommentRequest);
  }

  @override
  Future<AddCommentReplyResponse> addCommentReply(
      AddCommentReplyRequest addCommentReplyRequest) async {
    return await _sdkApplication.addCommentReply(addCommentReplyRequest);
  }

  @override
  Future<EditCommentReplyResponse> editCommentReply(
      EditCommentReplyRequest editCommentReplyRequest) async {
    return await _sdkApplication.editCommentReply(editCommentReplyRequest);
  }

  @override
  Future<GetCommentResponse> getComment(GetCommentRequest request) {
    return _sdkApplication.getComment(request);
  }

  @override
  Future<ToggleLikeCommentResponse> toggleLikeComment(
      ToggleLikeCommentRequest toggleLikeCommentRequest) async {
    return await _sdkApplication.toggleLikeComment(toggleLikeCommentRequest);
  }

  @override
  Future<PostDetailResponse> getPostDetails(
      PostDetailRequest postDetailRequest) async {
    return await _sdkApplication.getPostDetails(postDetailRequest);
  }

  @override
  Future<DeleteCommentResponse> deleteComment(
      DeleteCommentRequest deleteCommentRequest) async {
    return await _sdkApplication.deleteComment(deleteCommentRequest);
  }

  @override
  Future<EditCommentResponse> editComment(
      EditCommentRequest editCommentRequest) async {
    return await _sdkApplication.editComment(editCommentRequest);
  }

  @override
  Future<String?> uploadFile(File file, String userUniqueId) async {
    return await _mediaService.uploadFile(file, userUniqueId);
  }

  @override
  Future<GetFeedOfFeedRoomResponse> getFeedOfFeedRoom(
      GetFeedOfFeedRoomRequest request) async {
    return await _sdkApplication.getFeedOfFeedRoom(request);
  }

  @override
  Future<GetFeedRoomResponse> getFeedRoom(GetFeedRoomRequest request) async {
    return await _sdkApplication.getFeedRoom(request);
  }

  @override
  Future<MemberStateResponse> getMemberState() async {
    return await _sdkApplication.getMemberState();
  }

  @override
  Future<RegisterDeviceResponse> registerDevice(
      RegisterDeviceRequest request) async {
    return await LMNotifications.registerDevice(request);
  }

  @override
  Future<GetTaggingListResponse> getTaggingList(
      {required GetTaggingListRequest request}) async {
    return await _sdkApplication.getTaggingList(request: request);
  }

  @override
  Future<DecodeUrlResponse> decodeUrl(DecodeUrlRequest request) async {
    return await _sdkApplication.decodeUrl(request);
  }

  @override
  Future<GetDeleteReasonResponse> getReportTags(
      GetDeleteReasonRequest request) async {
    return await _sdkApplication.getReportTags(request);
  }

  @override
  void routeToProfile(String userId) {
    _sdkApplication.routeToProfile(userId);
  }
}
