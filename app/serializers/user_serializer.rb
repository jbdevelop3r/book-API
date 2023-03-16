class UserSerializer < ActiveModel::Serializer
  has_one :api_key
  attributes :id, :clientEmail, :clientName, :api_key
end
