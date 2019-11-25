# frozen_string_literal: true

json.(tweet, :id_str, :text)

json.user do
  json.partial! "api/tweets/user", user: tweet[:user]
end
