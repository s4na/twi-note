# frozen_string_literal: true

require "factory_bot"

user_1 = FactoryBot.create(:user, name: "s4na_penguin", uid: "1072823223190835201", email: "1072823223190835201-twitter@example.com")
note_1 = FactoryBot.create(:note, user: user_1)
FactoryBot.create(:search_setting, note: note_1)
