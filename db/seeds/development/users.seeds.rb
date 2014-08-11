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
michael_expert.save!
michael.expert = michael_expert
subject = Subject.where(name: 'Basketball').first_or_initialize
michael.expert.subjects.clear
michael.expert.subjects << subject

george = User.where(fullname: 'George Feeny').first_or_initialize
george.email = 'george.feeny@gmail.com'
george.password = 'asdfasdf'
george.password_confirmation = 'asdfasdf'
george.skip_confirmation!
george.admin = false
george.save!
george.reload

george_edu = Educator.where(user_id: george.id).first_or_initialize
george_edu.save!
george.educator = george_edu
