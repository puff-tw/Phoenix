user = User.create!(name: 'Aravind Kulkarni', city_id: 1, email: 'inakae401@kanha.org', contact_number_primary: '9986440406', active: true, membership_number: 'KAN000000')
userrole = UserRole.create!(user: user, role_id: 5, business_entity_location_id: 158, active: true)
account = Account::CashAccount.create!(business_entity_id: 134, name: "Cash_#{user.id}", alias_name: 'Cash - Aravind Kulkarni', reserved: true)
user.update_attributes!(cash_account_id: account.id)
user.update_attributes!(password: 'inakae401', password_confirmation: 'inakae401')

user = User.create!(name: 'Radha Kulkarni', city_id: 1, email: 'inrkae559@kanha.org', contact_number_primary: '9986440407', active: true, membership_number: 'KAN000001')
userrole = UserRole.create!(user: user, role_id: 5, business_entity_location_id: 158, active: true)
account = Account::CashAccount.create!(business_entity_id: 134, name: "Cash_#{user.id}", alias_name: 'Cash - Radha Kulkarni', reserved: true)
user.update_attributes!(cash_account_id: account.id)
user.update_attributes!(password: 'inrkae559', password_confirmation: 'inrkae559')

user = User.create!(name: 'Namit Chawra', city_id: 1, email: 'inacae044@kanha.org', contact_number_primary: '9822525897', active: true, membership_number: 'KAN000002')
userrole = UserRole.create!(user: user, role_id: 5, business_entity_location_id: 158, active: true)
account = Account::CashAccount.create!(business_entity_id: 134, name: "Cash_#{user.id}", alias_name: 'Cash - Namit Chawra', reserved: true)
user.update_attributes!(cash_account_id: account.id)
user.update_attributes!(password: 'inacae044', password_confirmation: 'inacae044')

user = User.create!(name: 'P.Chandra Sekaran', city_id: 1, email: 'sgcpaa002@kanha.org', contact_number_primary: '9442283209', active: true, membership_number: 'KAN000003')
userrole = UserRole.create!(user: user, role_id: 5, business_entity_location_id: 158, active: true)
account = Account::CashAccount.create!(business_entity_id: 134, name: "Cash_#{user.id}", alias_name: 'Cash - P.Chandra Sekaran', reserved: true)
user.update_attributes!(cash_account_id: account.id)
user.update_attributes!(password: 'sgcpaa002', password_confirmation: 'sgcpaa002')

user = User.create!(name: 'Hemani Chawra', city_id: 1, email: 'inhcae012@kanha.org', contact_number_primary: '8452987727', active: true, membership_number: 'KAN000004')
userrole = UserRole.create!(user: user, role_id: 5, business_entity_location_id: 158, active: true)
account = Account::CashAccount.create!(business_entity_id: 134, name: "Cash_#{user.id}", alias_name: 'Cash - Hemani Chawra', reserved: true)
user.update_attributes!(cash_account_id: account.id)
user.update_attributes!(password: 'inhcae012', password_confirmation: 'inhcae012')

user = User.create!(name: 'Karthik Durai', city_id: 1, email: 'inskaa353@kanha.org', contact_number_primary: '9176000515', active: true, membership_number: 'KAN000005')
userrole = UserRole.create!(user: user, role_id: 5, business_entity_location_id: 158, active: true)
account = Account::CashAccount.create!(business_entity_id: 134, name: "Cash_#{user.id}", alias_name: 'Cash - Karthik Durai', reserved: true)
user.update_attributes!(cash_account_id: account.id)
user.update_attributes!(password: 'inskaa353', password_confirmation: 'inskaa353')

user = User.create!(name: 'V.Chandra Sekhar', city_id: 1, email: 'invsad296@kanha.org', contact_number_primary: '9848150024', active: true, membership_number: 'KAN000006')
userrole = UserRole.create!(user: user, role_id: 5, business_entity_location_id: 158, active: true)
account = Account::CashAccount.create!(business_entity_id: 134, name: "Cash_#{user.id}", alias_name: 'Cash - V.Chandra Sekhar', reserved: true)
user.update_attributes!(cash_account_id: account.id)
user.update_attributes!(password: 'invsad296', password_confirmation: 'invsad296')

user = User.create!(name: 'Luxmi Ahuja', city_id: 1, email: 'inlaaa106@kanha.org', contact_number_primary: '9810239185', active: true, membership_number: 'KAN000007')
userrole = UserRole.create!(user: user, role_id: 5, business_entity_location_id: 158, active: true)
account = Account::CashAccount.create!(business_entity_id: 134, name: "Cash_#{user.id}", alias_name: 'Cash - Luxmi Ahuja', reserved: true)
user.update_attributes!(cash_account_id: account.id)
user.update_attributes!(password: 'inlaaa106', password_confirmation: 'inlaaa106')

user = User.create!(name: 'Harsh Ahuja', city_id: 1, email: 'inhaaa100@kanha.org', contact_number_primary: '9650995460', active: true, membership_number: 'KAN000008')
userrole = UserRole.create!(user: user, role_id: 5, business_entity_location_id: 158, active: true)
account = Account::CashAccount.create!(business_entity_id: 134, name: "Cash_#{user.id}", alias_name: 'Cash - Harsh Ahuja', reserved: true)
user.update_attributes!(cash_account_id: account.id)
user.update_attributes!(password: 'inhaaa100', password_confirmation: 'inhaaa100')

user = User.create!(name: 'K.Mohan', city_id: 1, email: 'inkkae291@kanha.org', contact_number_primary: '9985717985', active: true, membership_number: 'KAN000009')
userrole = UserRole.create!(user: user, role_id: 5, business_entity_location_id: 158, active: true)
account = Account::CashAccount.create!(business_entity_id: 134, name: "Cash_#{user.id}", alias_name: 'Cash - K.Mohan', reserved: true)
user.update_attributes!(cash_account_id: account.id)
user.update_attributes!(password: 'inkkae291', password_confirmation: 'inkkae291')

user = User.create!(name: 'Medha Bharadwaj', city_id: 1, email: 'inmbae332@kanha.org', contact_number_primary: '9986951235', active: true, membership_number: 'KAN000010')
userrole = UserRole.create!(user: user, role_id: 5, business_entity_location_id: 158, active: true)
account = Account::CashAccount.create!(business_entity_id: 134, name: "Cash_#{user.id}", alias_name: 'Cash - Medha Bharadwaj', reserved: true)
user.update_attributes!(cash_account_id: account.id)
user.update_attributes!(password: 'inmbae332', password_confirmation: 'inmbae332')

user = User.create!(name: 'Veena N Hegde', city_id: 1, email: 'invhae007@kanha.org', contact_number_primary: '9886081532', active: true, membership_number: 'KAN000011')
userrole = UserRole.create!(user: user, role_id: 5, business_entity_location_id: 158, active: true)
account = Account::CashAccount.create!(business_entity_id: 134, name: "Cash_#{user.id}", alias_name: 'Cash - Veena N Hegde', reserved: true)
user.update_attributes!(cash_account_id: account.id)
user.update_attributes!(password: 'invhae007', password_confirmation: 'invhae007')

user = User.create!(name: 'Jayanthi S', city_id: 1, email: 'injsaa152@kanha.org', contact_number_primary: '8105586333', active: true, membership_number: 'KAN000012')
userrole = UserRole.create!(user: user, role_id: 5, business_entity_location_id: 158, active: true)
account = Account::CashAccount.create!(business_entity_id: 134, name: "Cash_#{user.id}", alias_name: 'Cash - Jayanthi S', reserved: true)
user.update_attributes!(cash_account_id: account.id)
user.update_attributes!(password: 'injsaa152', password_confirmation: 'injsaa152')

user = User.create!(name: 'Suresh Kumar ', city_id: 1, email: 'inssaa336@kanha.org', contact_number_primary: '8105364333', active: true, membership_number: 'KAN000013')
userrole = UserRole.create!(user: user, role_id: 5, business_entity_location_id: 158, active: true)
account = Account::CashAccount.create!(business_entity_id: 134, name: "Cash_#{user.id}", alias_name: 'Cash - Suresh Kumar ', reserved: true)
user.update_attributes!(cash_account_id: account.id)
user.update_attributes!(password: 'inssaa336', password_confirmation: 'inssaa336')

user = User.create!(name: 'Prashanth ', city_id: 1, email: 'usppaa020@kanha.org', contact_number_primary: '9900013537', active: true, membership_number: 'KAN000014')
userrole = UserRole.create!(user: user, role_id: 5, business_entity_location_id: 158, active: true)
account = Account::CashAccount.create!(business_entity_id: 134, name: "Cash_#{user.id}", alias_name: 'Cash - Prashanth ', reserved: true)
user.update_attributes!(cash_account_id: account.id)
user.update_attributes!(password: 'usppaa020', password_confirmation: 'usppaa020')

user = User.create!(name: 'Arathi R', city_id: 1, email: 'inarae004@kanha.org', contact_number_primary: '9844182686', active: true, membership_number: 'KAN000015')
userrole = UserRole.create!(user: user, role_id: 5, business_entity_location_id: 158, active: true)
account = Account::CashAccount.create!(business_entity_id: 134, name: "Cash_#{user.id}", alias_name: 'Cash - Arathi R', reserved: true)
user.update_attributes!(cash_account_id: account.id)
user.update_attributes!(password: 'inarae004', password_confirmation: 'inarae004')

