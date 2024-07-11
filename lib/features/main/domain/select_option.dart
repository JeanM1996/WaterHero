class SelectOption {
  SelectOption({
    required this.label,
    this.value,
    this.icon,
    this.description,
    this.semanticLabel,
    this.count,
  });

  SelectOption.fromJson(Map<String, dynamic> json) {
    label = (json['label'] ?? json['name'] ?? '') as String;
    value = json['value'] ?? json['id'] ?? '';
    icon = (json['icon']) as String?;
    description = (json['description']) as String?;
    semanticLabel = (json['semanticLabel'] ?? '') as String;
    count = (json['count']) as num?;
  }
  String? label;
  String? icon;
  String? description;
  dynamic value;
  String? semanticLabel;
  num? count;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    data['icon'] = icon;
    data['description'] = description;
    data['semanticLabel'] = semanticLabel;
    data['count'] = count;
    return data;
  }

  @override
  String toString() {
    return '''
SelectOption{label: $label, value: $value, icon: $icon, description: $description, semanticLabel: $semanticLabel, count: $count}''';
  }
}
