# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
user     = User.create!(:name => "admin", :last_name => "admin", :email => "admin@mail.ru", :password => "admin", :password_confirmation => "admin", :phone => "000000", :is_admin => true, :is_anonym => false)
category = Category.create!(:name => "Bus stops", :description => " It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing.")
#State.create([{:name => 'Чуй'},{:name => 'Ош'},{:name => 'Баткен'},{:name => 'Джалал-Абад'},{:name => 'Талас'},{:name => 'Иссык-Куль'},{:name => 'Нарын'},{:name => 'Бишкек'}])

