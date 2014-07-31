admin = User.where(fullname: 'Administrator').first_or_initialize
admin.email = 'admin@gmail.com'
admin.password = 'adminadmin'
admin.password_confirmation = 'adminadmin'
admin.skip_confirmation!
admin.admin = true
admin.save!
