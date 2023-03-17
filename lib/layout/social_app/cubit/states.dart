abstract class SocialStates {}

class SocialInitialState extends SocialStates{}
class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates{
  final String error;

  SocialGetUserErrorState(this.error);

}
class SocialGetAllUserLoadingState extends SocialStates{}

class SocialGetAllUserSuccessState extends SocialStates{}
class SocialGetAllUserErrorState extends SocialStates{
  final String error;

  SocialGetAllUserErrorState(this.error);

}

class SocialChangeBottomNavState extends SocialStates{}

class SocialAddPostState extends SocialStates{}
class SocialEditProfileImageSuccessState extends SocialStates{}
class SocialEditProfileImageErrorState extends SocialStates{}
class SocialEditCoverImageSuccessState extends SocialStates{}
class SocialEditCoverImageErrorState extends SocialStates{}

class SocialUploadingProfileImageSuccessState extends SocialStates{}
class SocialUploadingProfileImageErrorState extends SocialStates{}

class SocialUploadingCoverImageSuccessState extends SocialStates{}
class SocialUploadingCoverImageErrorState extends SocialStates{}
class SocialUpdateErrorState extends SocialStates{}
class SocialUpdateLoadingState extends SocialStates{}

class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{}

class SocialPostImageSuccessState extends SocialStates{}
class SocialPostImageErrorState extends SocialStates{}
class SocialRemovePostImageState extends SocialStates{}


class SocialGetPostsLoadingState extends SocialStates{}

class SocialGetPostsSuccessState extends SocialStates{}
class SocialGetPostsErrorState extends SocialStates{
  final String error;

  SocialGetPostsErrorState(this.error);

}
class SocialLikePostSuccessState extends SocialStates{}
class SocialLikePostErrorState extends SocialStates{
  final String error;

  SocialLikePostErrorState(this.error);

}
class SocialCommentPostSuccessState extends SocialStates{}
class SocialCommentPostErrorState extends SocialStates{
  final String error;

  SocialCommentPostErrorState(this.error);

}

class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{
  final String error;

  SocialSendMessageErrorState(this.error);

}
class SocialReceiveMessageSuccessState extends SocialStates{}
class SocialReceiveMessageErrorState extends SocialStates{
  final String error;

  SocialReceiveMessageErrorState(this.error);

}


class SocialGetMessageSuccessState extends SocialStates{}


