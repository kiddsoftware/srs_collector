class CardModelSerializer < ActiveModel::Serializer
  attributes :id, :short_name, :name, :anki_css, :cloze
  has_many :card_model_fields
  has_many :card_model_templates
end
