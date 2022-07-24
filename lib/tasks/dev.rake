namespace :dev do
  desc "populating database"
  task setup: :environment do
    %x(rails db:drop db:create db:migrate)
    puts "creating categories..."
    Category.create!(
      name:"Desktop"
    )
    Category.create!(
      name:"Notepad"
    )
    Category.create!(
      name:"Laptop"
    )
    puts "categories sucessifully created!"

    puts "creating measures..."
    Measure.create!(
      name:"Batch"
    )
    Measure.create!(
      name:"One-piece"
    )
    puts "measures sucessifully created!"

  end

end
