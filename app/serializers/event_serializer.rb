class EventSerializer < ActiveModel::Serializer
  attributes :id, :event_type, :public, :repo_id, :actor_id
end
