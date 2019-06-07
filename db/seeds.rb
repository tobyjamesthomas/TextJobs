# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(first_name: "Alice", phone: "5148931435", coffee: true)
User.create(first_name: "Bob", phone: "5148931435", coffee: true, store: true)
User.create(first_name: "Celine", phone: "5148931435", coffee: true)
User.create(first_name: "Danny", phone: "5148931435", coffee: true, call_center: true)
User.create(first_name: "Ellen", phone: "5148931435", coffee: true)
