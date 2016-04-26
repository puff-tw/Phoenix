#!/bin/bash

FILE=bandara_users.csv
K=1
while read line; do
   #echo "Line is $line"
   name=`echo $line | cut -d',' -f1`
   idCard=`echo $line | cut -d',' -f2 | tr "A-Z" "a-z"`
   mobile=`echo $line | cut -d',' -f3`
   email=`echo $line | cut -d',' -f4 | tr "A-Z" "a-z"`
   #echo "name is ${name}"
   idNumber="$(printf 'KAN%06d'  $k)"
   ((k++))

   cat <<USER_RECORD
ActiveRecord::Base.transaction do

user = User.create!(name: '${name}', city_id: 1, email: '${idCard}@kanha.org', contact_number_primary: '${mobile}', active: true, membership_number: '${idNumber}')
userrole = UserRole.create!(user: user, role_id: 5, business_entity_location_id: 160, active: true)
account = Account::CashAccount.create!(business_entity_id: 134, name: "Cash_#{user.id}", alias_name: 'Cash - ${name}', reserved: true)
user.update_attributes!(cash_account_id: account.id)
user.update_attributes!(password: '${idCard}', password_confirmation: '${idCard}')

end
USER_RECORD

done < $FILE

#for i in `cat bandara_users.csv`
#do
#  name=`echo $i | cut -f1 -d','`
#  echo "name is ${name}"
#  cat <<USER_RECORD
#     user = User.create!(name: \'${name}\', city_id: 1, email: 'nagadeesh@gmail.com', contact_number_primary: '9966451161', active: true, membership_number: 'INNTAE044')
#     userrole = UserRole.create!(user: user, role_id: 5, business_entity_location_id: 154, active: true)
#     account = Account::CashAccount.create!(business_entity_id: 1, name: "Cash_#{user.id}", alias_name: 'Cash - Nagarjuna T.', reserved: true)
#     user.update_attributes!(cash_account_id: account.id)
#USER_RECORD
#
#done


