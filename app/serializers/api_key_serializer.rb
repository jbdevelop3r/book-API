class ApiKeySerializer < ActiveModel::Serializer
  belongs_to :user
  attributes :id, :access_token
end
