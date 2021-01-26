class PostModel {
  final String featuredImage, title, date, url, content, authorName; final int id;

  PostModel({
    this.authorName,
    this.content,
   // this.avatarURL,
    this.featuredImage,
    this.title,
    this.date,
    this.url, this.id
  });

  factory PostModel.fromJson(Map<dynamic, dynamic> parsedJson) {
    return PostModel(
          title: parsedJson["title"]["rendered"].toString(), id: parsedJson["id"], featuredImage: parsedJson["featured_image_url"],
          authorName: parsedJson["author_meta"]["display_name"], content: parsedJson["content"]["rendered"], date: parsedJson["date"]
     
    );
  }
}

class Title{
  final String posttitle;

  Title({this.posttitle});

  factory Title.fromJson(Map<String, dynamic> parsedJson){
  return Title(
  
    posttitle: parsedJson["rendered"]
  );
}
}

class PostsList {
  final List<PostModel> postModel;

  PostsList({
    this.postModel,
  });

 factory PostsList.fromJson(List<dynamic> parsedJson){
    List<PostModel> mytrails = new List<PostModel>();
    mytrails = parsedJson.map((i)=>PostModel.fromJson(i)).toList();

    return new PostsList(
      postModel: mytrails
    );
 }


}