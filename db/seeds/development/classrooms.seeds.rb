school_district = SchoolDistrict.where(name: 'Verona School District').first_or_initialize
school_district.save!
high_school = School.where(name: 'Verona high school').first_or_initialize
high_school.school_district = school_district
high_school.save!

middle_school = School.where(name: 'Verona Middle School').first_or_initialize
middle_school.school_district = school_district
middle_school.save!

chem = Subject.where(name: 'Chemistry').first_or_create
math = Subject.where(name: 'Mathematics').first_or_create
physics = Subject.where(name: 'Physics').first_or_create
biology = Subject.where(name: 'Biology').first_or_create


classroom = Classroom.where(name: 'Judy Smith\'s 11th Grade Chemistry Class').first_or_initialize
classroom.school = high_school
classroom.subjects.delete_all
classroom.subjects << chem
classroom.save!

classroom = Classroom.where(name: 'John Simpson\'s 8th Grade Math Class').first_or_initialize
classroom.school = middle_school
classroom.subjects.delete_all
classroom.subjects << math
classroom.save!

classroom = Classroom.where(name: 'Jill Jones\' 10th Grade Physics Class').first_or_initialize
classroom.school = high_school
classroom.subjects.delete_all
classroom.subjects << physics
classroom.save!

classroom = Classroom.where(name: 'Ruth Perez\'s High School Biology Class').first_or_initialize
classroom.school = high_school
classroom.subjects.delete_all
classroom.subjects << biology
classroom.save!
