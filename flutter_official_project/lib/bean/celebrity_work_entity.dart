// ignore_for_file: deprecated_member_use, prefer_collection_literals, prefer_typing_uninitialized_variables, unnecessary_new

class CelebrityWorkEntity {
	CelebrityWorkCelebrity? celebrity;
	int? total;
	List<CelebrityWorkWork>? works;
	int? count;
	int? start;

	CelebrityWorkEntity({this.celebrity, this.total, this.works, this.count, this.start});

	CelebrityWorkEntity.fromJson(Map<String, dynamic> json) {
		celebrity = json['celebrity'] != null ? CelebrityWorkCelebrity.fromJson(json['celebrity']) : null;
		total = json['total'];
		if (json['works'] != null) {
			works = <CelebrityWorkWork>[];
			json['works'].forEach((v) { works?.add(CelebrityWorkWork.fromJson(v)); });
		}
		count = json['count'];
		start = json['start'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		if (celebrity != null) {
      data['celebrity'] = celebrity?.toJson();
    }
		data['total'] = total;
		if (works != null) {
      data['works'] = works?.map((v) => v.toJson()).toList();
    }
		data['count'] = count;
		data['start'] = start;
		return data;
	}
}

class CelebrityWorkCelebrity {
	String? name;
	String? alt;
	String? id;
	CelebrityWorkCelebrityAvatars? avatars;
	String? nameEn;

	CelebrityWorkCelebrity({this.name, this.alt, this.id, this.avatars, this.nameEn});

	CelebrityWorkCelebrity.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? CelebrityWorkCelebrityAvatars.fromJson(json['avatars']) : null;
		nameEn = json['name_en'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
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

class CelebrityWorkCelebrityAvatars {
	String? small;
	String? large;
	String? medium;

	CelebrityWorkCelebrityAvatars({this.small, this.large, this.medium});

	CelebrityWorkCelebrityAvatars.fromJson(Map<String, dynamic> json) {
		small = json['small'];
		large = json['large'];
		medium = json['medium'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['small'] = small;
		data['large'] = large;
		data['medium'] = medium;
		return data;
	}
}

class CelebrityWorkWork {
	CelebrityWorkWorksSubject? subject;
	List<String>? roles;

	CelebrityWorkWork({this.subject, this.roles});

	CelebrityWorkWork.fromJson(Map<String, dynamic> json) {
		subject = json['subject'] != null ? CelebrityWorkWorksSubject.fromJson(json['subject']) : null;
		roles = json['roles'].cast<String>();
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		if (subject != null) {
      data['subject'] = subject?.toJson();
    }
		data['roles'] = roles;
		return data;
	}
}

class CelebrityWorkWorksSubject {
	CelebrityWorkWorksSubjectImages? images;
	String? originalTitle;
	String? year;
	List<CelebrityWorkWorksSubjectDirector>? directors;
	CelebrityWorkWorksSubjectRating? rating;
	String? alt;
	String? title;
	int? collectCount;
	bool? hasVideo;
	List<String>? pubdates;
	List<CelebrityWorkWorksSubjectCast>? casts;
	String? subtype;
	List<String>? genres;
	List<String>? durations;
	String? mainlandPubdate;
	String? id;

	CelebrityWorkWorksSubject({this.images, this.originalTitle, this.year, this.directors, this.rating, this.alt, this.title, this.collectCount, this.hasVideo, this.pubdates, this.casts, this.subtype, this.genres, this.durations, this.mainlandPubdate, this.id});

	CelebrityWorkWorksSubject.fromJson(Map<String, dynamic> json) {
		images = json['images'] != null ? CelebrityWorkWorksSubjectImages.fromJson(json['images']) : null;
		originalTitle = json['original_title'];
		year = json['year'];
		if (json['directors'] != null) {
			directors = <CelebrityWorkWorksSubjectDirector>[];
			json['directors'].forEach((v) { directors?.add(CelebrityWorkWorksSubjectDirector.fromJson(v)); });
		}
		rating = json['rating'] != null ? CelebrityWorkWorksSubjectRating.fromJson(json['rating']) : null;
		alt = json['alt'];
		title = json['title'];
		collectCount = json['collect_count'];
		hasVideo = json['has_video'];
		pubdates = json['pubdates'] == null ? null : [];

		for (var pubdatesItem in pubdates == null ? [] : json['pubdates']){
			pubdates?.add(pubdatesItem);
		}
		if (json['casts'] != null) {
			casts = <CelebrityWorkWorksSubjectCast>[];
			json['casts'].forEach((v) { casts?.add(CelebrityWorkWorksSubjectCast.fromJson(v)); });
		}
		subtype = json['subtype'];
		genres = json['genres'].cast<String>();
		durations = json['durations'] == null ? null : [];

		for (var durationsItem in durations == null ? [] : json['durations']){
			durations?.add(durationsItem);
		}
		mainlandPubdate = json['mainland_pubdate'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
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
//		if (this.pubdates != null) {
//      data['pubdates'] = this.pubdates.map((v) => v.toJson()).toList();
//    }
		if (casts != null) {
      data['casts'] = casts?.map((v) => v.toJson()).toList();
    }
		data['subtype'] = subtype;
		data['genres'] = genres;
//		if (this.durations != null) {
//      data['durations'] = this.durations.map((v) => v.toJson()).toList();
//    }
		data['mainland_pubdate'] = mainlandPubdate;
		data['id'] = id;
		return data;
	}
}

class CelebrityWorkWorksSubjectImages {
	String? small;
	String? large;
	String? medium;

	CelebrityWorkWorksSubjectImages({this.small, this.large, this.medium});

	CelebrityWorkWorksSubjectImages.fromJson(Map<String, dynamic> json) {
		small = json['small'];
		large = json['large'];
		medium = json['medium'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['small'] = small;
		data['large'] = large;
		data['medium'] = medium;
		return data;
	}
}

class CelebrityWorkWorksSubjectDirector {
	String? name;
	String? alt;
	String? id;
	CelebrityWorkWorksSubjectDirectorsAvatars? avatars;
	String? nameEn;

	CelebrityWorkWorksSubjectDirector({this.name, this.alt, this.id, this.avatars, this.nameEn});

	CelebrityWorkWorksSubjectDirector.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? CelebrityWorkWorksSubjectDirectorsAvatars.fromJson(json['avatars']) : null;
		nameEn = json['name_en'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
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

class CelebrityWorkWorksSubjectDirectorsAvatars {
	String? small;
	String? large;
	String? medium;

	CelebrityWorkWorksSubjectDirectorsAvatars({this.small, this.large, this.medium});

	CelebrityWorkWorksSubjectDirectorsAvatars.fromJson(Map<String, dynamic> json) {
		small = json['small'];
		large = json['large'];
		medium = json['medium'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['small'] = small;
		data['large'] = large;
		data['medium'] = medium;
		return data;
	}
}

class CelebrityWorkWorksSubjectRating {
	var average;
	var min;
	var max;
	CelebrityWorkWorksSubjectRatingDetails? details;
	String? stars;

	CelebrityWorkWorksSubjectRating({this.average, this.min, this.max, this.details, this.stars});

	CelebrityWorkWorksSubjectRating.fromJson(Map<String, dynamic> json) {
		average = json['average'];
		min = json['min'];
		max = json['max'];
		details = json['details'] != null ? CelebrityWorkWorksSubjectRatingDetails.fromJson(json['details']) : null;
		stars = json['stars'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
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

class CelebrityWorkWorksSubjectRatingDetails {
	var d1;
	var d2;
	var d3;
	var d4;
	var d5;

	CelebrityWorkWorksSubjectRatingDetails({this.d1, this.d2, this.d3, this.d4, this.d5});

	CelebrityWorkWorksSubjectRatingDetails.fromJson(Map<String, dynamic> json) {
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

class CelebrityWorkWorksSubjectCast {
	String? name;
	String? alt;
	String? id;
	CelebrityWorkWorksSubjectCastsAvatars? avatars;
	String? nameEn;

	CelebrityWorkWorksSubjectCast({this.name, this.alt, this.id, this.avatars, this.nameEn});

	CelebrityWorkWorksSubjectCast.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? CelebrityWorkWorksSubjectCastsAvatars.fromJson(json['avatars']) : null;
		nameEn = json['name_en'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
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

class CelebrityWorkWorksSubjectCastsAvatars {
	String? small;
	String? large;
	String? medium;

	CelebrityWorkWorksSubjectCastsAvatars({this.small, this.large, this.medium});

	CelebrityWorkWorksSubjectCastsAvatars.fromJson(Map<String, dynamic> json) {
		small = json['small'];
		large = json['large'];
		medium = json['medium'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['small'] = small;
		data['large'] = large;
		data['medium'] = medium;
		return data;
	}
}
