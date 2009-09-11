namespace :setup do
  desc "create the admin user"
  task :admin => :environment do
    admin = User.first(:conditions => {:permission_level => -1})
    if admin
      puts "Admin user already exists"
    else
      admin = User.create({
        :email => "admin@yourdomain.com", 
        :login => "siteadmin", 
        :password => "p455wd!", 
        :password_confirmation => "p455wd!",
        :permission_level => -1
      })
      if admin
        puts "Created admin user. login: siteadmin, pasword: p455wd!"
      else
        puts "Error encountered while creating admin"
      end
    end
  end
  
  desc "setup the admin user and renumeration schedule"
  task :all => [:admin]
end
