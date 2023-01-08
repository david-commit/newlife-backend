# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Start seeding..."

puts "1. seeding user..."
user1 = User.create!(
    username: "vincent",
    password: "vincent",
    email: "vincent@patient.com"
)

user2 = User.create!(
    username: "enock",
    password: "enock",
    email: "enock@patient.com"
)


puts "2. seeding order..."
order1 = Order.create!(
    user_id: user1.id,
    delivered: false
)


# puts "3. seeding payment..."
# payment1 = Payment.create!(payment_method: "mpesa", order_id: order1.id)


puts "4. seeding products..."
# https://www.drugs.com/medical_conditions.html
require 'json'

products = []

bpd_drugs = %w(Lamictal Lamotrigine Latuda Sero Abilify Vraylar)
bpd_drugs.length.times do |i|
    products << Product.create!(
        name: bpd_drugs[i],
        category: "Bipolar Disorder",
        price: rand(0..1000).round(2),
        image: "https://www.cphi-online.com/46/product/124/50/63/281Amitriptine-50-mg%20(1).jpg",
        quantity: 1,
        stock: rand(0..100),
        rating: rand(0..5),
        description: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
        dosage: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
        effects: "Constipation, Nausea, Drowsiness, Itching, Sweating"
    )
end

cancer_drugs = %w(Carboplatin Leukeran Chrolambucil Fluorouracil Doxorubicin Etoposide Cyclophosphamide Vincristine)
cancer_drugs.length.times do |i|
    products << Product.create!(
        name: cancer_drugs[i],
        category: "Cancer",
        price: rand(0..1000).round(2),
        image: "https://www.cphi-online.com/46/product/124/50/63/281Amitriptine-50-mg%20(1).jpg",
        quantity: 1,
        stock: rand(0..100),
        rating: rand(0..5),
        description: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
        dosage: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
        effects: "Constipation, Nausea, Drowsiness, Itching, Sweating"
    )
end

depression_drugs = %w(Bupropion Cymbalta Sertralie Zoloft Lexapro Prozac Citalopram Celexa)
depression_drugs.length.times do |i|
    products << Product.create!(
        name: depression_drugs[i],
        category: "Depression",
        price: rand(0..1000).round(2),
        image: "https://www.cphi-online.com/46/product/124/50/63/281Amitriptine-50-mg%20(1).jpg",
        quantity: 1,
        stock: rand(0..100),
        rating: rand(0..5),
        description: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
        dosage: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
        effects: "Constipation, Nausea, Drowsiness, Itching, Sweating"
    )
end

anxiety_drugs = %w(Xanax Clonazepam Alprazolam Lorazepam Buspirone Diazepam Ativan Hydroxyzine)
anxiety_drugs.length.times do |i|
    products << Product.create!(
        name: anxiety_drugs[i],
        category: "Anxiety",
        price: rand(0..1000).round(2),
        image: "https://www.cphi-online.com/46/product/124/50/63/281Amitriptine-50-mg%20(1).jpg",
        quantity: 1,
        stock: rand(0..100),
        rating: rand(0..5),
        description: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
        dosage: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
        effects: "Constipation, Nausea, Drowsiness, Itching, Sweating"
    )
end

gastrointestinal_surgery_drugs = %w(Entereg Alvimopan Lidocaine Glydo)
gastrointestinal_surgery_drugs.length.times do |i|
    products << Product.create!(
        name: gastrointestinal_surgery_drugs[i],
        category: "Gastrointestinal Surgery",
        price: rand(0..1000).round(2),
        image: "https://www.cphi-online.com/46/product/124/50/63/281Amitriptine-50-mg%20(1).jpg",
        quantity: 1,
        stock: rand(0..100),
        rating: rand(0..5),
        description: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
        dosage: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
        effects: "Constipation, Nausea, Drowsiness, Itching, Sweating"
    )
end

erectile_dysfunction_drugs = %w(Cialis Sildenafil Viagra Taladafil Staxyn Verdenafil Alprostadil Edex)
erectile_dysfunction_drugs.length.times do |i|
    products << Product.create!(
        name: erectile_dysfunction_drugs[i],
        category: "Erectile Dysfunction",
        price: rand(0..1000).round(2),
        image: "https://www.cphi-online.com/46/product/124/50/63/281Amitriptine-50-mg%20(1).jpg",
        quantity: 1,
        stock: rand(0..100),
        rating: rand(0..5),
        description: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
        dosage: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
        effects: "Constipation, Nausea, Drowsiness, Itching, Sweating"
    )
end

diabetes_1_drugs = %w(Humalog Lantus Novolog Lyumjev)
diabetes_1_drugs.length.times do |i|
    products << Product.create!(
        name: diabetes_1_drugs[i],
        category: "Diabetes Type 1",
        price: rand(0..1000).round(2),
        image: "https://www.cphi-online.com/46/product/124/50/63/281Amitriptine-50-mg%20(1).jpg",
        quantity: 1,
        stock: rand(0..100),
        rating: rand(0..5),
        description: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
        dosage: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
        effects: "Constipation, Nausea, Drowsiness, Itching, Sweating"
    )
end


puts "5. seeding shopping_cart..."
5.times do
    ShoppingCart.create!(order_id: order1.id, product_id: products.sample.id)
end


puts "6. seeding department..."
department_names = ["Mental Health", "Diabetes", "Cancer"]
departments = []

department_names.length.times do |i|
    departments << Department.create(name: department_names[i])
end



puts "7. seeding practitioners..."
practitioner1 = Practitioner.create!(
    username: "david",
    password: "david",
    email: "david@david.com",
    department_id: departments.sample.id
)


other_practitioners = []
10.times do |i|
    other_practitioners << Practitioner.create!(
        username: Faker::Internet.username,
        password: Faker::Internet.password,
        email: Faker::Internet.email,
        department_id:  departments.sample.id
    )
end


puts "8. seeding patient_profile"
vincent_profile = PatientProfile.create!(
    user_id: user1.id,
    first_name: "Vincent",
    last_name: "Makokha",
    bio: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
    dob: "2022-12-20",
    location: "Nairobi",
    blood_group: "0-",
    height: (rand()+1).round(2),
    weight: (rand()+rand(50..100)).round(2),
    phone_number: "0701807557",
    bmi: (rand()+rand(15..30)).round(2)
)

enock_profile = PatientProfile.create!(
    user_id: user2.id,
    first_name: "Enock",
    last_name: "Mokua",
    bio: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
    dob: "2022-12-20",
    location: "Nairobi",
    blood_group: "A+",
    height: (rand()+1).round(2),
    weight: (rand()+rand(50..100)).round(2),
    phone_number: "0721409448",
    bmi: (rand()+rand(15..30)).round(2)
)


puts "9. seeding appointment..."
appointment1 = Appointment.create!(
    user_id: user1.id,
    practitioner_id: practitioner1.id,
    date: "2022-12-20",
    approved: true,
    appointment_type: "Normal"
)

appointment2 = Appointment.create!(
    user_id: user1.id,
    practitioner_id: practitioner1.id,
    date: "2022-12-20",
    approved: false,
    appointment_type: "Normal"
)

appointment3 = Appointment.create!(
    user_id: user1.id,
    practitioner_id: other_practitioners.sample.id,
    date: "2022-12-20",
    approved: true,
    appointment_type: "Normal"
)


puts "10. seeding messages..."
5.times do
    sender = [user1, practitioner1].sample
    receiver = (sender.class.to_s == "User")? practitioner1 : user1
    Message.create!(
        appointment_id: appointment1.id,
        sender_id: sender.id,
        sender_class: sender.class.to_s,
        receiver_id: receiver.id,
        receiver_class: receiver.class.to_s,
        content: Faker::Lorem.paragraph(sentence_count: rand(1..3))
    )
end


puts "11. seeding practitioner_profile..."
david_profile = PractitionerProfile.create!(
    practitioner_id: practitioner1.id,
    first_name: "David",
    last_name: "Ondiege",
    bio: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
    dob: "2022-12-20",
    location: "Nairobi",
    blood_group: "B-",
    weight: (rand()+rand(50..100)).round(2),
    phone_number: "0756291474",
    bmi: (rand()+rand(15..30)).round(2)
)

10.times do |i|
    PractitionerProfile.create!(
        practitioner_id: other_practitioners[i].id,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        bio: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
        dob: "2022-12-20",
        location: Faker::Address.city,
        blood_group: "B-",
        weight: (rand()+rand(50..100)).round(2),
        phone_number: "0756291474",
        bmi: (rand()+rand(15..30)).round(2)
    )
end

puts "Seeding completed!"

