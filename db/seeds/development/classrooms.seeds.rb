school_district = SchoolDistrict.where(name: 'Verona School District').first_or_initialize
school_district.save!

elementary_school = School.where(name: 'Verona Elementary School').first_or_initialize
elementary_school.school_district = school_district
elementary_school.save!

high_school = School.where(name: 'Verona high school').first_or_initialize
high_school.school_district = school_district
high_school.save!

middle_school = School.where(name: 'Verona Middle School').first_or_initialize
middle_school.school_district = school_district
middle_school.save!

elementary = GradeLevel.where(name: 'Elementary').first_or_create!
middle = GradeLevel.where(name: 'Middle').first_or_create!
high = GradeLevel.where(name: 'High School').first_or_create!

chem = Subject.where(name: 'Chemistry').first_or_create!
math = Subject.where(name: 'Mathematics').first_or_create!
physics = Subject.where(name: 'Physics').first_or_create!
biology = Subject.where(name: 'Biology').first_or_create!
history = Subject.where(name: 'History').first_or_create!

classroom = Classroom.where(name: 'Judy Smith\'s 11th Grade Chemistry Class').first_or_initialize
classroom.school = high_school
classroom.subjects.delete_all
classroom.subjects << chem
classroom.grade = 11
classroom.grade_level = high
classroom.save!

classroom = Classroom.where(name: 'John Simpson\'s 8th Grade Math Class').first_or_initialize
classroom.school = middle_school
classroom.subjects.delete_all
classroom.subjects << math
classroom.grade = 8
classroom.grade_level = middle_school
classroom.save!

classroom = Classroom.where(name: 'Jill Jones\' 10th Grade Physics Class').first_or_initialize
classroom.school = high_school
classroom.subjects.delete_all
classroom.subjects << physics
classroom.grade = 10
classroom.grade_level = high
classroom.save!

classroom = Classroom.where(name: 'Ruth Perez\'s High School Biology Class').first_or_initialize
classroom.school = high_school
classroom.subjects.delete_all
classroom.subjects << biology
classroom.grade = 12
classroom.grade_level = high
classroom.save!

classroom = Classroom.where(name: 'Jonah Stotsky\'s 5th Grade History Class').first_or_initialize
classroom.school = elementary_school
classroom.subjects.delete_all
classroom.subjects << history
classroom.grade = 5
classroom.grade_level = elementary
classroom.save!
