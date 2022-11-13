// ignore_for_file: prefer_typing_uninitialized_variables

class SearchResultEntity {
	int? total;
	List<SearchResultSubject>? subjects;
	int? count;
	int? start;
	String? title;

	SearchResultEntity({this.total, this.subjects, this.count, this.start, this.title});

	SearchResultEntity.fromJson(Map<String, dynamic> json) {
		total = json['total'];
		if (json['subjects'] != null) {
			subjects = <SearchResultSubject>[];
			json['subjects'].forEach((v) { subjects?.add(SearchResultSubject.fromJson(v)); });
		}
		count = json['count'];
		start = json['start'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['total'] = total;
		if (subjects != null) {
      data['subjects'] = subjects?.map((v) => v.toJson()).toList();
    }
		data['count'] = count;
		data['start'] = start;
		data['title'] = title;
		return data;
	}
}

class SearchResultSubject {
	SearchResultSubjectsImages? images;
	String? originalTitle;
	String? year;
	List<SearchResultSubjectsDirector>? directors;
	SearchResultSubjectsRating? rating;
	String? alt;
	String? title;
	int? collectCount;
	bool? hasVideo;
	List<String>? pubdates;
	List<SearchResultSubjectsCast>? casts;
	String? subtype;
	List<String>? genres;
	List<String>? durations;
	String? mainlandPubdate;
	String? id;

	SearchResultSubject({this.images, this.originalTitle, this.year, this.directors, this.rating, this.alt, this.title, this.collectCount, this.hasVideo, this.pubdates, this.casts, this.subtype, this.genres, this.durations, this.mainlandPubdate, this.id});

	SearchResultSubject.fromJson(Map<String, dynamic> json) {
		images = json['images'] != null ? SearchResultSubjectsImages.fromJson(json['images']) : null;
		originalTitle = json['original_title'];
		year = json['year'];
		if (json['directors'] != null) {
			directors = <SearchResultSubjectsDirector>[];
			json['directors'].forEach((v) { directors?.add(SearchResultSubjectsDirector.fromJson(v)); });
		}
		rating = json['rating'] != null ? SearchResultSubjectsRating.fromJson(json['rating']) : null;
		alt = json['alt'];
		title = json['title'];
		collectCount = json['collect_count'];
		hasVideo = json['has_video'];
		pubdates = json['pubdates'].cast<String>();
		if (json['casts'] != null) {
			casts = <SearchResultSubjectsCast>[];
			json['casts'].forEach((v) { casts?.add(SearchResultSubjectsCast.fromJson(v)); });
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

class SearchResultSubjectsImages {
	String? small;
	String? large;
	String? medium;

	SearchResultSubjectsImages({this.small, this.large, this.medium});

	SearchResultSubjectsImages.fromJson(Map<String, dynamic> json) {
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

class SearchResultSubjectsDirector {
	var name;
	var alt;
	var id;
	var avatars;
	var nameEn;

	SearchResultSubjectsDirector({this.name, this.alt, this.id, this.avatars, this.nameEn});

	SearchResultSubjectsDirector.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'];
		nameEn = json['name_en'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['name'] = name;
		data['alt'] = alt;
		data['id'] = id;
		data['avatars'] = avatars;
		data['name_en'] = nameEn;
		return data;
	}
}

class SearchResultSubjectsRating {
	var average;
	var min;
	var max;
	SearchResultSubjectsRatingDetails? details;
	String? stars;

	SearchResultSubjectsRating({this.average, this.min, this.max, this.details, this.stars});

	SearchResultSubjectsRating.fromJson(Map<String, dynamic> json) {
		average = json['average'];
		min = json['min'];
		max = json['max'];
		details = json['details'] != null ? SearchResultSubjectsRatingDetails.fromJson(json['details']) : null;
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

class SearchResultSubjectsRatingDetails {
	var d1;
	var d2;
	var d3;
	var d4;
	var d5;

	SearchResultSubjectsRatingDetails({this.d1, this.d2, this.d3, this.d4, this.d5});

	SearchResultSubjectsRatingDetails.fromJson(Map<String, dynamic> json) {
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

class SearchResultSubjectsCast {
	String? name;
	var alt;
	var id;
	var avatars;
	String? nameEn;

	SearchResultSubjectsCast({this.name, this.alt, this.id, this.avatars, this.nameEn});

	SearchResultSubjectsCast.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'];
		nameEn = json['name_en'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['name'] = name;
		data['alt'] = alt;
		data['id'] = id;
		data['avatars'] = avatars;
		data['name_en'] = nameEn;
		return data;
	}
}
