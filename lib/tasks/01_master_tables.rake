namespace :master_tables do

  desc "Currencies data seeding"
  task :seed_currencies => :environment do
      Currency.create_with(name: "Indian Rupee", code: "INR", active: true).first_or_create
      Currency.create_with(name: "United States Dollar", code: "USD", active: true).first_or_create
      Currency.create_with(name: "Euro", code: "EUR", active: true).first_or_create
      puts "Currencies data seed successful"
  end

  desc "Users data seeding"
  task :seed_users => :environment do
    User.create_with(name: 'Gorav Bhootra', password: 'password', membership_number: 'INAAAA001',
      password_confirmation: 'password', active: 'true', confirmed_at: Time.zone.now,
      contact_number_primary: '+919840164646').where(email: 'email@gorav.in').first_or_create
    puts 'Users data seed successful'
  end

  desc "Distribution Types data seeding"
  task :seed_distribution_types => :environment do
    ActiveRecord::Base.transaction do
      DistributionType.where(name: "Sales only", active: true).first_or_create
      DistributionType.where(name: "Sales and Corpus", active: true).first_or_create
      DistributionType.where(name: "Special Publications", active: true).first_or_create
    end
  end

  desc "Payment Modes data seeding"
  task :seed_payment_modes => :environment do
    ActiveRecord::Base.transaction do
      PaymentMode.create_with(active: true).where(name: "Cash").first_or_create
      PaymentMode.create_with(active: true).where(name: "Credit Card").first_or_create
      PaymentMode.create_with(active: true).where(name: "Cheque").first_or_create
      PaymentMode.create_with(active: true).where(name: "DD").first_or_create
      PaymentMode.create_with(active: true).where(name: "Bank Transfer").first_or_create
    end
  end

  desc "Core Levels data seeding"
  task :seed_core_levels => :environment do
    ActiveRecord::Base.transaction do
      CoreLevel.create_with(active: true).where(name: "Core 1").first_or_create
      CoreLevel.create_with(active: true).where(name: "Core 2").first_or_create
      CoreLevel.create_with(active: true).where(name: "Core 3").first_or_create
    end
  end

  desc "Focus Groups data seeding"
  task :seed_focus_groups => :environment do
    ActiveRecord::Base.transaction do
      FocusGroup.create_with(active: true).where(name: "Prefects").first_or_create
      FocusGroup.create_with(active: true).where(name: "General").first_or_create
      FocusGroup.create_with(active: true).where(name: "Children").first_or_create
    end
  end

  desc "Authors data seeding"
  task :seed_authors => :environment do
    ActiveRecord::Base.transaction do
      Author.create_with(active: true ).where(name: "Gorav Bhootra").first_or_create
      Author.create_with(active: true ).where(name: "John Doe").first_or_create
      Author.create_with(active: true ).where(name: "My fav author").first_or_create
    end
  end

  desc 'Unit of Measurement (UOM) data seeding'
  task :seed_uoms => :environment do
    Uom.where(name: 'Numbers', print_name: 'Nos.', active: true).first_or_create
  end

  desc "Run all tasks in this file"
  task seed_all: [
                  :seed_currencies, :seed_users, :seed_distribution_types, :seed_focus_groups,
                  :seed_payment_modes, :seed_core_levels, :seed_authors, :seed_uoms
                  ]
end
