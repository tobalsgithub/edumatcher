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
michael.reload

michael_expert = Expert.where(user_id: michael.id).first_or_initialize
michael_expert.notes = "I've missed more than 9000 shots in my career. I've lost almost 300 games. 26 times, I've been trusted to take the game winning shot and missed. I've failed over and over and over again in my life. And that is why I succeed."
michael.expert = michael_expert
subject = Subject.where(name: 'Basketball').first_or_initialize
michael.expert.subjects.clear
michael.expert.subjects << subject
