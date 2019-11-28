# frozen_string_literal: true

json.(tweet, :id_str, :text, :url)

json.user do
  json.partial! "api/tweets/user", user: tweet[:user]
end
