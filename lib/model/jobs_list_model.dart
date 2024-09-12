


class JobsListModel {

  String? jobId;
  String? title;
  String? company;
  String? location;
  String? description;
  String? longDescription;
  String? salary;
  String? datePosted;
  String? imageUrl;

  JobsListModel({
    this.jobId,
    this.title,
    this.company,
    this.location,
    this.description,
    this.longDescription,
    this.salary,
    this.datePosted,
    this.imageUrl,
  });
  JobsListModel.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id']?.toString();
    title = json['title']?.toString();
    company = json['company']?.toString();
    location = json['location']?.toString();
    description = json['description']?.toString();
    longDescription = json['long_description']?.toString();
    salary = json['salary']?.toString();
    datePosted = json['date_posted']?.toString();
    imageUrl = json['image_url']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['job_id'] = jobId;
    data['title'] = title;
    data['company'] = company;
    data['location'] = location;
    data['description'] = description;
    data['long_description'] = longDescription;
    data['salary'] = salary;
    data['date_posted'] = datePosted;
    data['image_url'] = imageUrl;
    return data;
  }
}