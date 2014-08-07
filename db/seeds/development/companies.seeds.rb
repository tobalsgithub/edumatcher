comp = Company.where(name: 'Apple').first_or_initialize
comp.save!

comp = Company.where(name: 'Google').first_or_initialize
comp.save!

comp = Company.where(name: 'Epic').first_or_initialize
comp.save!

comp = Company.where(name: 'Epic Gaming Company').first_or_initialize
comp.save!

comp = Company.where(name: 'American Family Insurance').first_or_initialize
comp.save!
