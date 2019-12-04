# frozen_string_literal: true

json.(tweet, :id_str, :text, :url, :markdown)

json.user do
  json.partial! "api/tweets/user", user: tweet[:user]
end
