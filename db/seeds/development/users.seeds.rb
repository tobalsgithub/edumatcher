admin = User.where(fullname: 'Administrator').first_or_initialize
admin.email = 'admin@gmail.com'
admin.password = 'adminadmin'
admin.password_confirmation = 'adminadmin'
admin.skip_confirmation!
admin.admin = true
admin.save!

michael = User.where(fullname: 'Michael Jordan').first_or_initialize
michael.email = 'michael.jordan@gmail.com'
michael.password = 'asdfasdf'
michael.password_confirmation = 'asdfasdf'
michael.skip_confirmation!
michael.admin = false
michael.save!
