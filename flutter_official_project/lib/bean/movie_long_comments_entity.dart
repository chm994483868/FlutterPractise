// ignore_for_file: prefer_typing_uninitialized_variables

class MovieLongCommentsEntity {
	int? total;
	int? nextStart;
	List<MovieLongCommentReviews>? reviews;
	MovieLongCommentsSubject? subject;
	int? count;
	int? start;

	MovieLongCommentsEntity({this.total, this.nextStart, this.reviews, this.subject, this.count, this.start});

	MovieLongCommentsEntity.fromJson(Map<String, dynamic> json) {
		total = json['total'];
		nextStart = json['next_start'];
		if (json['reviews'] != null) {
			reviews = <MovieLongCommentReviews>[];
			json['reviews'].forEach((v) { reviews?.add(MovieLongCommentReviews.fromJson(v)); });
		}
		subject = json['subject'] != null ? MovieLongCommentsSubject.fromJson(json['subject']) : null;
		count = json['count'];
		start = json['start'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['total'] = total;
		data['next_start'] = nextStart;
		if (reviews != null) {
      data['reviews'] = reviews?.map((v) => v.toJson()).toList();
    }
		if (subject != null) {
      data['subject'] = subject?.toJson();
    }
		data['count'] = count;
		data['start'] = start;
		return data;
	}
}

class MovieLongCommentReviews {
	String? summary;
	String? subjectId;
	MovieLongCommentsReviewsAuthor? author;
	MovieLongCommentsReviewsRating? rating;
	String? alt;
	String? createdAt;
	String? title;
	int? uselessCount;
	String? content;
	String? updatedAt;
	String? shareUrl;
	int? commentsCount;
	String? id;
	int? usefulCount;

	MovieLongCommentReviews({this.summary, this.subjectId, this.author, this.rating, this.alt, this.createdAt, this.title, this.uselessCount, this.content, this.updatedAt, this.shareUrl, this.commentsCount, this.id, this.usefulCount});

	MovieLongCommentReviews.fromJson(Map<String, dynamic> json) {
		summary = json['summary'];
		subjectId = json['subject_id'];
		author = json['author'] != null ? MovieLongCommentsReviewsAuthor.fromJson(json['author']) : null;
		rating = json['rating'] != null ? MovieLongCommentsReviewsRating.fromJson(json['rating']) : null;
		alt = json['alt'];
		createdAt = json['created_at'];
		title = json['title'];
		uselessCount = json['useless_count'];
		content = json['content'];
		updatedAt = json['updated_at'];
		shareUrl = json['share_url'];
		commentsCount = json['comments_count'];
		id = json['id'];
		usefulCount = json['useful_count'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['summary'] = summary;
		data['subject_id'] = subjectId;
		if (author != null) {
      data['author'] = author?.toJson();
    }
		if (rating != null) {
      data['rating'] = rating?.toJson();
    }
		data['alt'] = alt;
		data['created_at'] = createdAt;
		data['title'] = title;
		data['useless_count'] = uselessCount;
		data['content'] = content;
		data['updated_at'] = updatedAt;
		data['share_url'] = shareUrl;
		data['comments_count'] = commentsCount;
		data['id'] = id;
		data['useful_count'] = usefulCount;
		return data;
	}
}

class MovieLongCommentsReviewsAuthor {
	String? uid;
	String? signature;
	String? alt;
	String? name;
	String? avatar;
	String? id;

	MovieLongCommentsReviewsAuthor({this.uid, this.signature, this.alt, this.name, this.avatar, this.id});

	MovieLongCommentsReviewsAuthor.fromJson(Map<String, dynamic> json) {
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

class MovieLongCommentsReviewsRating {
	var min;
	var max;
	var value;

	MovieLongCommentsReviewsRating({this.min, this.max, this.value});

	MovieLongCommentsReviewsRating.fromJson(Map<String, dynamic> json) {
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

class MovieLongCommentsSubject {
	MovieLongCommentsSubjectImages? images;
	String? originalTitle;
	String? year;
	List<MovieLongCommantsSubjectDirectors>? directors;
	MovieLongCommentsSubjectRating? rating;
	String? alt;
	String? title;
	int? collectCount;
	bool? hasVideo;
	List<String>? pubdates;
	List<MovieLongCommantsSubjectCasts>? casts;
	String? subtype;
	List<String>? genres;
	List<String>? durations;
	String? mainlandPubdate;
	String? id;

	MovieLongCommentsSubject({this.images, this.originalTitle, this.year, this.directors, this.rating, this.alt, this.title, this.collectCount, this.hasVideo, this.pubdates, this.casts, this.subtype, this.genres, this.durations, this.mainlandPubdate, this.id});

	MovieLongCommentsSubject.fromJson(Map<String, dynamic> json) {
		images = json['images'] != null ? MovieLongCommentsSubjectImages.fromJson(json['images']) : null;
		originalTitle = json['original_title'];
		year = json['year'];
		if (json['directors'] != null) {
			directors = <MovieLongCommantsSubjectDirectors>[];
			json['directors'].forEach((v) { directors?.add(MovieLongCommantsSubjectDirectors.fromJson(v)); });
		}
		rating = json['rating'] != null ? MovieLongCommentsSubjectRating.fromJson(json['rating']) : null;
		alt = json['alt'];
		title = json['title'];
		collectCount = json['collect_count'];
		hasVideo = json['has_video'];
		pubdates = json['pubdates'].cast<String>();
		if (json['casts'] != null) {
			casts = <MovieLongCommantsSubjectCasts>[];
			json['casts'].forEach((v) { casts?.add(MovieLongCommantsSubjectCasts.fromJson(v)); });
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

class MovieLongCommentsSubjectImages {
	String? small;
	String? large;
	String? medium;

	MovieLongCommentsSubjectImages({this.small, this.large, this.medium});

	MovieLongCommentsSubjectImages.fromJson(Map<String, dynamic> json) {
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

class MovieLongCommantsSubjectDirectors {
	String? name;
	String? alt;
	String? id;
	MovieLongCommentsSubjectDirectorsAvatars? avatars;
	String? nameEn;

	MovieLongCommantsSubjectDirectors({this.name, this.alt, this.id, this.avatars, this.nameEn});

	MovieLongCommantsSubjectDirectors.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? MovieLongCommentsSubjectDirectorsAvatars.fromJson(json['avatars']) : null;
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

class MovieLongCommentsSubjectDirectorsAvatars {
	String? small;
	String? large;
	String? medium;

	MovieLongCommentsSubjectDirectorsAvatars({this.small, this.large, this.medium});

	MovieLongCommentsSubjectDirectorsAvatars.fromJson(Map<String, dynamic> json) {
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

class MovieLongCommentsSubjectRating {
	double? average;
	int? min;
	int? max;
	MovieLongCommentsSubjectRatingDetails? details;
	String? stars;

	MovieLongCommentsSubjectRating({this.average, this.min, this.max, this.details, this.stars});

	MovieLongCommentsSubjectRating.fromJson(Map<String, dynamic> json) {
		average = json['average'];
		min = json['min'];
		max = json['max'];
		details = json['details'] != null ? MovieLongCommentsSubjectRatingDetails.fromJson(json['details']) : null;
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

class MovieLongCommentsSubjectRatingDetails {
	double? d1;
	double? d2;
	double? d3;
	double? d4;
	double? d5;

	MovieLongCommentsSubjectRatingDetails({this.d1, this.d2, this.d3, this.d4, this.d5});

	MovieLongCommentsSubjectRatingDetails.fromJson(Map<String, dynamic> json) {
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

class MovieLongCommantsSubjectCasts {
	String? name;
	String? alt;
	String? id;
	MovieLongCommentsSubjectCastsAvatars? avatars;
	String? nameEn;

	MovieLongCommantsSubjectCasts({this.name, this.alt, this.id, this.avatars, this.nameEn});

	MovieLongCommantsSubjectCasts.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? MovieLongCommentsSubjectCastsAvatars.fromJson(json['avatars']) : null;
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

class MovieLongCommentsSubjectCastsAvatars {
	String? small;
	String? large;
	String? medium;

	MovieLongCommentsSubjectCastsAvatars({this.small, this.large, this.medium});

	MovieLongCommentsSubjectCastsAvatars.fromJson(Map<String, dynamic> json) {
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
