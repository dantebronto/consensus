namespace :setup do
  desc "create the admin user"
  task :admin => :environment do
    admin = User.first(:conditions => {:permission_level => -1})
    if admin
      puts "Admin user already exists"
    else
      puts "This user has the ability to create all other users in the system"
      login = ask("what should the admin's login be? ")
      password = ask("what should the admin's password be? ")
      admin = User.create({
        :login => login, 
        :password => password, 
        :password_confirmation => password,
        :permission_level => -1
      })
      if admin
        puts "Created admin user. login: #{login}, pasword: #{password}"
      else
        puts "Error encountered while creating admin"
      end
    end
  end
end

def ask message
  print message
  STDIN.gets.chomp
end