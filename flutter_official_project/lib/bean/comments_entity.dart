// ignore_for_file: prefer_typing_uninitialized_variables

class CommentsEntity {
	int? total;
	List<CommantsBeanCommants>? comments;
	int? nextStart;
	CommentsBeanSubject? subject;
	int? count;
	int? start;

	CommentsEntity({this.total, this.comments, this.nextStart, this.subject, this.count, this.start});

	CommentsEntity.fromJson(Map<String, dynamic> json) {
		total = json['total'];
		if (json['comments'] != null) {
			comments = <CommantsBeanCommants>[];
			json['comments'].forEach((v) { comments?.add(CommantsBeanCommants.fromJson(v)); });
		}
		nextStart = json['next_start'];
		subject = json['subject'] != null ? CommentsBeanSubject.fromJson(json['subject']) : null;
		count = json['count'];
		start = json['start'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['total'] = total;
		if (comments != null) {
      data['comments'] = comments?.map((v) => v.toJson()).toList();
    }
		data['next_start'] = nextStart;
		if (subject != null) {
      data['subject'] = subject?.toJson();
    }
		data['count'] = count;
		data['start'] = start;
		return data;
	}
}

class CommantsBeanCommants {
	String? subjectId;
	CommentsBeanCommentsAuthor? author;
	CommentsBeanCommentsRating? rating;
	String? createdAt;
	String? id;
	int? usefulCount;
	String? content;

	CommantsBeanCommants({this.subjectId, this.author, this.rating, this.createdAt, this.id, this.usefulCount, this.content});

	CommantsBeanCommants.fromJson(Map<String, dynamic> json) {
		subjectId = json['subject_id'];
		author = json['author'] != null ? CommentsBeanCommentsAuthor.fromJson(json['author']) : null;
		rating = json['rating'] != null ? CommentsBeanCommentsRating.fromJson(json['rating']) : null;
		createdAt = json['created_at'];
		id = json['id'];
		usefulCount = json['useful_count'];
		content = json['content'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['subject_id'] = subjectId;
		if (author != null) {
      data['author'] = author?.toJson();
    }
		if (rating != null) {
      data['rating'] = rating?.toJson();
    }
		data['created_at'] = createdAt;
		data['id'] = id;
		data['useful_count'] = usefulCount;
		data['content'] = content;
		return data;
	}
}

class CommentsBeanCommentsAuthor {
	String? uid;
	String? signature;
	String? alt;
	String? name;
	String? avatar;
	String? id;

	CommentsBeanCommentsAuthor({this.uid, this.signature, this.alt, this.name, this.avatar, this.id});

	CommentsBeanCommentsAuthor.fromJson(Map<String, dynamic> json) {
		uid = json['uid'];
		signature = json['signature'];
		alt = json['alt'];
		name = json['name'];
		avatar = json['avatar'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['uid'] = uid;
		data['signature'] = signature;
		data['alt'] = alt;
		data['name'] = name;
		data['avatar'] = avatar;
		data['id'] = id;
		return data;
	}
}

class CommentsBeanCommentsRating {
	var min;
	var max;
	var value;

	CommentsBeanCommentsRating({this.min, this.max, this.value});

	CommentsBeanCommentsRating.fromJson(Map<String, dynamic> json) {
		min = json['min'];
		max = json['max'];
		value = json['value'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['min'] = min;
		data['max'] = max;
		data['value'] = value;
		return data;
	}
}

class CommentsBeanSubject {
	CommentsBeanSubjectImages? images;
	String? originalTitle;
	String? year;
	List<CommantsBeanSubjectDirectors>? directors;
	CommentsBeanSubjectRating? rating;
	String? alt;
	String? title;
	int? collectCount;
	bool? hasVideo;
	List<String>? pubdates;
	List<CommantsBeanSubjectCasts>? casts;
	String? subtype;
	List<String>? genres;
	List<String>? durations;
	String? mainlandPubdate;
	String? id;

	CommentsBeanSubject({this.images, this.originalTitle, this.year, this.directors, this.rating, this.alt, this.title, this.collectCount, this.hasVideo, this.pubdates, this.casts, this.subtype, this.genres, this.durations, this.mainlandPubdate, this.id});

	CommentsBeanSubject.fromJson(Map<String, dynamic> json) {
		images = json['images'] != null ? CommentsBeanSubjectImages.fromJson(json['images']) : null;
		originalTitle = json['original_title'];
		year = json['year'];
		if (json['directors'] != null) {
			directors = <CommantsBeanSubjectDirectors>[];
			json['directors'].forEach((v) { directors?.add(CommantsBeanSubjectDirectors.fromJson(v)); });
		}
		rating = json['rating'] != null ? CommentsBeanSubjectRating.fromJson(json['rating']) : null;
		alt = json['alt'];
		title = json['title'];
		collectCount = json['collect_count'];
		hasVideo = json['has_video'];
		pubdates = json['pubdates'].cast<String>();
		if (json['casts'] != null) {
			casts = <CommantsBeanSubjectCasts>[];
			json['casts'].forEach((v) { casts?.add(CommantsBeanSubjectCasts.fromJson(v)); });
		}
		subtype = json['subtype'];
		genres = json['genres'].cast<String>();
		durations = json['durations'].cast<String>();
		mainlandPubdate = json['mainland_pubdate'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		if (images != null) {
      data['images'] = images?.toJson();
    }
		data['original_title'] = originalTitle;
		data['year'] = year;
		if (directors != null) {
      data['directors'] = directors?.map((v) => v.toJson()).toList();
    }
		if (rating != null) {
      data['rating'] = rating?.toJson();
    }
		data['alt'] = alt;
		data['title'] = title;
		data['collect_count'] = collectCount;
		data['has_video'] = hasVideo;
		data['pubdates'] = pubdates;
		if (casts != null) {
      data['casts'] = casts?.map((v) => v.toJson()).toList();
    }
		data['subtype'] = subtype;
		data['genres'] = genres;
		data['durations'] = durations;
		data['mainland_pubdate'] = mainlandPubdate;
		data['id'] = id;
		return data;
	}
}

class CommentsBeanSubjectImages {
	String? small;
	String? large;
	String? medium;

	CommentsBeanSubjectImages({this.small, this.large, this.medium});

	CommentsBeanSubjectImages.fromJson(Map<String, dynamic> json) {
		small = json['small'];
		large = json['large'];
		medium = json['medium'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['small'] = small;
		data['large'] = large;
		data['medium'] = medium;
		return data;
	}
}

class CommantsBeanSubjectDirectors {
	String? name;
	String? alt;
	String? id;
	CommentsBeanSubjectDirectorsAvatars? avatars;
	String? nameEn;

	CommantsBeanSubjectDirectors({this.name, this.alt, this.id, this.avatars, this.nameEn});

	CommantsBeanSubjectDirectors.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? CommentsBeanSubjectDirectorsAvatars.fromJson(json['avatars']) : null;
		nameEn = json['name_en'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['name'] = name;
		data['alt'] = alt;
		data['id'] = id;
		if (avatars != null) {
      data['avatars'] = avatars?.toJson();
    }
		data['name_en'] = nameEn;
		return data;
	}
}

class CommentsBeanSubjectDirectorsAvatars {
	String? small;
	String? large;
	String? medium;

	CommentsBeanSubjectDirectorsAvatars({this.small, this.large, this.medium});

	CommentsBeanSubjectDirectorsAvatars.fromJson(Map<String, dynamic> json) {
		small = json['small'];
		large = json['large'];
		medium = json['medium'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['small'] = small;
		data['large'] = large;
		data['medium'] = medium;
		return data;
	}
}

class CommentsBeanSubjectRating {
	var average;
	var min;
	var max;
	CommentsBeanSubjectRatingDetails? details;
	String? stars;

	CommentsBeanSubjectRating({this.average, this.min, this.max, this.details, this.stars});

	CommentsBeanSubjectRating.fromJson(Map<String, dynamic> json) {
		average = json['average'];
		min = json['min'];
		max = json['max'];
		details = json['details'] != null ? CommentsBeanSubjectRatingDetails.fromJson(json['details']) : null;
		stars = json['stars'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['average'] = average;
		data['min'] = min;
		data['max'] = max;
		if (details != null) {
      data['details'] = details?.toJson();
    }
		data['stars'] = stars;
		return data;
	}
}

class CommentsBeanSubjectRatingDetails {
	var d1;
	var d2;
	var d3;
	var d4;
	var d5;

	CommentsBeanSubjectRatingDetails({this.d1, this.d2, this.d3, this.d4, this.d5});

	CommentsBeanSubjectRatingDetails.fromJson(Map<String, dynamic> json) {
		d1 = json['1'];
		d2 = json['2'];
		d3 = json['3'];
		d4 = json['4'];
		d5 = json['5'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['1'] = d1;
		data['2'] = d2;
		data['3'] = d3;
		data['4'] = d4;
		data['5'] = d5;
		return data;
	}
}

class CommantsBeanSubjectCasts {
	String? name;
	String? alt;
	String? id;
	CommentsBeanSubjectCastsAvatars? avatars;
	String? nameEn;

	CommantsBeanSubjectCasts({this.name, this.alt, this.id, this.avatars, this.nameEn});

	CommantsBeanSubjectCasts.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? CommentsBeanSubjectCastsAvatars.fromJson(json['avatars']) : null;
		nameEn = json['name_en'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['name'] = name;
		data['alt'] = alt;
		data['id'] = id;
		if (avatars != null) {
      data['avatars'] = avatars?.toJson();
    }
		data['name_en'] = nameEn;
		return data;
	}
}

class CommentsBeanSubjectCastsAvatars {
	String? small;
	String? large;
	String? medium;

	CommentsBeanSubjectCastsAvatars({this.small, this.large, this.medium});

	CommentsBeanSubjectCastsAvatars.fromJson(Map<String, dynamic> json) {
		small = json['small'];
		large = json['large'];
		medium = json['medium'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['small'] = small;
		data['large'] = large;
		data['medium'] = medium;
		return data;
	}
}
