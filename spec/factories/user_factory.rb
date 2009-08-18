Factory.define :user do |u|
  u.email 'email@email.com'
  u.login 'kellen'
  u.password 'p455wd!'
  u.hashed_password 'a17399c4f519a1bf7d9adb8aaec873e076ec3ee3'
  u.salt 'gRylvfoJi8'
  u.permission_level 1
end

Factory.define :admin, :class => User do |u|
  u.email 'email@email.com'
  u.login 'username'
  u.password 'p455wd!'
  u.hashed_password 'a17399c4f519a1bf7d9adb8aaec873e076ec3ee3'
  u.salt 'gRylvfoJi8'
  u.permission_level -1
end

Factory.define :alice, :class => :user do |u|
  u.email 'alice@email.com'
  u.login 'alice'
  u.password 'p455wd!'
  u.hashed_password 'a17399c4f519a1bf7d9adb8aaec873e076ec3ee3'
  u.salt 'gRylvfoJi8'
  u.permission_level 1
end

Factory.define :bob, :class => :user do |u|
  u.email 'bob@email.com'
  u.login 'bob'
  u.password 'p455wd!'
  u.hashed_password 'a17399c4f519a1bf7d9adb8aaec873e076ec3ee3'
  u.salt 'gRylvfoJi8'
  u.permission_level 1
end

Factory.define :charlie, :class => :user do |u|
  u.email 'charlie@email.com'
  u.login 'charlie'
  u.password 'p455wd!'
  u.hashed_password 'a17399c4f519a1bf7d9adb8aaec873e076ec3ee3'
  u.salt 'gRylvfoJi8'
  u.permission_level 1
end