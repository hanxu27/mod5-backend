class LastPictureSerializer < ActiveModel::Serializer
  attributes :id, :park, :url, :title, :caption, :like_count
end