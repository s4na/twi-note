# frozen_string_literal: true

require "factory_bot"

user_1 = FactoryBot.create(:user, name: "s4na_penguin", uid: "1072823223190835201", email: "1072823223190835201-twitter@example.com")
10.times.collect { |i|
  note = FactoryBot.create(:note, user: user_1)
  FactoryBot.create(:search_setting, note: note)
}

user_2 = FactoryBot.create(:user, name: "bob", uid: "1072823223190835202", email: "1072823223190835202-twitter@example.com")
note_2 = FactoryBot.create(:note, user: user_2)
FactoryBot.create(:search_setting, note: note_2)

user_3 = FactoryBot.create(:user, name: "carol", uid: "1072823223190835203", email: "1072823223190835203-twitter@example.com")
note_3 = FactoryBot.create(:note, user: user_3)
FactoryBot.create(:search_setting, note: note_3)

user_1.follow(user_2)
user_2.follow(user_1)
user_3.follow(user_1)

10.times.collect { |i|
  user = FactoryBot.create(:user)
  10.times.collect { |h|
    note = FactoryBot.create(:note, user: user)
    FactoryBot.create(:search_setting, note: note)
  }

  user_1.follow(user)
  user.follow(user_1)

  user_2.follow(user)

  user.follow(user_3)
}
