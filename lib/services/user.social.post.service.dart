// Ez még hasznos lehet
class UserPostService {
  // static Future<UserPost> createUserPiggyPost(UserPost post) async {
  //   await Firestore.instance.collection('userPosts').add(post.toJson());

  //   return post;
  // }

  // static Future<Iterable<DocumentSnapshot>> getUserPosts(
  //     PaginationHelper paginationHelper) async {
  //   var query = (Firestore.instance
  //       .collection('userPosts')
  //       .orderBy('postedDate', descending: false));

  //   if (paginationHelper.lastDocument != null) {
  //     query.startAfterDocument(paginationHelper.lastDocument).limit(4);
  //   } else {
  //     query.limit(4);
  //   }

  //   return (await query.getDocuments()).documents;
  // }
}
