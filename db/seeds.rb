# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Start seeding..."
puts "0. seeding admin..."
admin1 =
  Admin.create!(
    username: "admin",
    password: "Admin111",
    email: "admin@newlife.com"
  )

puts "1. seeding user..."
users = []

user1 =
  User.create!(
    username: "vincent",
    password: "Vincent111",
    email: "vincent@patient.com"
  )
users << user1

user2 =
  User.create!(
    username: "enock",
    password: "Enock111",
    email: "enock@patient.com"
  )
users << user2

#Other users
10.times do |i|
  users << User.create!(
    username: Faker::Internet.username,
    password:
      Faker::Internet.password(min_length: 9, max_length: 14, mix_case: true) +
        i.to_s,
    email: Faker::Internet.email
  )
end

puts "2. seeding order..."
order1 = Order.create!(user_id: user1.id, delivered: false)

puts "3. seeding payment..."
payment1 = Payment.create!(business_short_code: "whatever", order_id: order1.id)

puts "4. seeding products..."
# https://www.drugs.com/medical_conditions.html

products = []

product_images = %w[
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/garden-of-life-sport-certified-grass-fed-whey-protein-vanilla-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/muscle-core-100-whey-platinum-standard-10-lb-chocolate-flavor-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/muscle-core-100-whey-platinum-standard-chocolate-2lb-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/muscle-core-100-whey-platinum-standard-chocolate-5lb-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/detour-lm-cookie-dough-caramel-crisp-90g-12ct-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/detour-lower-sugar-caramel-peanut-85-g-box-of-12-pieces-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/detour-lower-sugar-chocolate-chip-caramel-85-g-box-of-12-pieces-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/muscle-core-high-protein-wafer-bar-dark-chocolate-12x40g-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/bio-nutrition-100-natural-raspberry-ketone-60-caps-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/bio-nutrition-activated-coconut-charcoal-520mg-90-capsules-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/bio-nutrition-b-12-sublingual-6000-mcg-50-tablets-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/bio-nutrition-bee-propolis-1000mg-60-capsules-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/bio-nutrition-bio-krill-500mg-45-softgels-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/bio-nutrition-bio-n-raspberry-ketone-diet-60-vegicaps-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/bio-nutrition-bio-n-saffron-extract-50-vegicaps-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/bio-nutrition-bio-n-super-konjac-diet-90-vegicaps-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/bio-nutrition-black-seed-oil-1000mg-90-capsules-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/bio-nutrition-black-seed-oil-8-oz-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/bio-nutrition-caraway-seed-60-capsules-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/bio-nutrition-gout-out-60s-vcaps-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/bio-nutrition-graviolla-60-veg-capsules-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/bio-nutrition-green-coffee-bean-800-mg-50-capsules-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/bio-nutrition-kidney-bladder-wellness-60-capsules-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/gaia-herbs-kids-black-elderberry-syrup-3-oz-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/gaia-herbs-kids-bronchial-wellness-3-oz-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/carlson-chewable-calcium-60-tablets-for-kids-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/carlson-kids-chewable-vit-c-60-softgels-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/garden-of-life-dr-formulated-probiotics-organic-for-kids-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/garden-of-life-multivitamin-code-supplement-for-kids-60-chewable-bear-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/good-day-chocolate-calm-supplement-8-ct-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/good-day-chocolate-kids-calm-supplement-50-ct-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/good-day-chocolate-kids-multivitamin-50-ct-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/barleans-flaxseed-powder-14-oz-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/bio-nutrition-moringa-5000-liquid-4-oz-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/kiki-health-organic-aloe-ferox-juice-500ml.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/kiki-health-organic-wheatgrass-powder-100g-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/natures-aid-organic-ultimate-superfood-60-caps-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/fitness-bull-carb-blocker-60-capsules-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/garden-of-life-organic-fit-weight-loss-bar-chocolate-fudge-55g-12ct-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/ener-c-cranberry-30-pks-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/ener-c-orange-30-pks-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/ener-c-peach-mango-30-pks-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/ener-c-pineapple-coconut-30-pks-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/ener-c-raspberry-30-pks-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/keto-science-keto-burn-60-caps-247x247.jpg
  https://www.medicaltradehub.com/wp-content/uploads/2022/12/ketoscience-ketogenic-meal-shake-nat-choco-14-serve-539g-247x247.jpg
]

bpd_drugs = %w[Lamictal Lamotrigine Latuda Sero Abilify Vraylar]
bpd_drugs.length.times do |i|
  products << Product.create!(
    name: bpd_drugs[i],
    category: "Bipolar Disorder",
    price: rand() * rand(1..1000),
    image:
      product_images[products.length] ||
        "https://www.cphi-online.com/46/product/124/50/63/281Amitriptine-50-mg%20(1).jpg",
    stock: rand(0..100)
  )
end

cancer_drugs = %w[
  Carboplatin
  Leukeran
  Chrolambucil
  Fluorouracil
  Doxorubicin
  Etoposide
  Cyclophosphamide
  Vincristine
]
cancer_drugs.length.times do |i|
  products << Product.create!(
    name: cancer_drugs[i],
    category: "Cancer",
    price: rand() * rand(1..1000),
    image:
      product_images[products.length] ||
        "https://www.cphi-online.com/46/product/124/50/63/281Amitriptine-50-mg%20(1).jpg",
    stock: rand(0..100)
  )
end

depression_drugs = %w[
  Bupropion
  Cymbalta
  Sertralie
  Zoloft
  Lexapro
  Prozac
  Citalopram
  Celexa
]
depression_drugs.length.times do |i|
  products << Product.create!(
    name: depression_drugs[i],
    category: "Depression",
    price: rand() * rand(1..1000),
    image:
      product_images[products.length] ||
        "https://www.cphi-online.com/46/product/124/50/63/281Amitriptine-50-mg%20(1).jpg",
    stock: rand(0..100)
  )
end

anxiety_drugs = %w[
  Xanax
  Clonazepam
  Alprazolam
  Lorazepam
  Buspirone
  Diazepam
  Ativan
  Hydroxyzine
]
anxiety_drugs.length.times do |i|
  products << Product.create!(
    name: anxiety_drugs[i],
    category: "Anxiety",
    price: rand() * rand(1..1000),
    image:
      product_images[products.length] ||
        "https://www.cphi-online.com/46/product/124/50/63/281Amitriptine-50-mg%20(1).jpg",
    stock: rand(0..100)
  )
end

gastrointestinal_surgery_drugs = %w[Entereg Alvimopan Lidocaine Glydo]
gastrointestinal_surgery_drugs.length.times do |i|
  products << Product.create!(
    name: gastrointestinal_surgery_drugs[i],
    category: "Gastrointestinal Surgery",
    price: rand() * rand(1..1000),
    image:
      product_images[products.length] ||
        "https://www.cphi-online.com/46/product/124/50/63/281Amitriptine-50-mg%20(1).jpg",
    stock: rand(0..100)
  )
end

erectile_dysfunction_drugs = %w[
  Cialis
  Sildenafil
  Viagra
  Taladafil
  Staxyn
  Verdenafil
  Alprostadil
  Edex
]
erectile_dysfunction_drugs.length.times do |i|
  products << Product.create!(
    name: erectile_dysfunction_drugs[i],
    category: "Erectile Dysfunction",
    price: rand() * rand(1..1000),
    image:
      product_images[products.length] ||
        "https://www.cphi-online.com/46/product/124/50/63/281Amitriptine-50-mg%20(1).jpg",
    stock: rand(0..100)
  )
end

diabetes_1_drugs = %w[Humalog Lantus Novolog Lyumjev]
diabetes_1_drugs.length.times do |i|
  products << Product.create!(
    name: diabetes_1_drugs[i],
    category: "Diabetes Type 1",
    price: rand() * rand(1..1000),
    image:
      product_images[products.length] ||
        "https://www.cphi-online.com/46/product/124/50/63/281Amitriptine-50-mg%20(1).jpg",
    stock: rand(0..100)
  )
end


# zero_price_drugs = %w[Masks WheelChair]
# zero_price_drugs.length.times do |i|
  products << Product.create!(
    name: "Masks",
    category: "Donation",
    price: 0,
    image: "https://i.postimg.cc/m2Z9qZff/free-size-100-3-layer-pharmaceutical-mask-100-pcs-surgical-mask-original-imagfutxyuhft6jp.jpg",
    stock: rand(0..100)
  )

    products << Product.create!(
    name: "Wheelchair",
    category: "Donation",
    price: 0,
    image: "https://i.postimg.cc/766vdTVJ/71w-EZky-Qc-YL.jpg",
    stock: rand(0..100)
  )
# end

puts "5. seeding product reviews..."
products.each do |product|
  rand(1..10).times do
    Review.create!(
      rating: rand(1..5),
      description_header: Faker::Lorem.sentence(word_count: rand(1..4)),
      description_content: Faker::Lorem.paragraph(sentence_count: rand(3..8)),
      product_id: product.id,
      user_id: users.sample.id
    )
  end
end

puts "6. seeding product dosage considerations..."
products.each do |product|
  rand(1..4).times do
    DosageConsideration.create!(
      consideration: Faker::Lorem.sentence(word_count: rand(1..4)),
      product_id: product.id
    )
  end
end

puts "7. seeding side effects..."
products.each do |product|
  rand(1..6).times do
    SideEffect.create!(
      side_effect: Faker::Lorem.sentence(word_count: rand(1..4)),
      product_id: product.id
    )
  end
end

puts "8. seeding shopping_cart..."
5.times do
  ShoppingCart.create!(order_id: order1.id, product_id: products.sample.id, quantity: rand(1..10))
end

puts "9. seeding department..."
department_names = ["Mental Health", "Diabetes", "Cancer"]
departments = []

department_names.length.times do |i|
  departments << Department.create(name: department_names[i])
end

puts "10. seeding practitioners..."
practitioner1 =
  Practitioner.create!(
    username: "david",
    password: "david",
    email: "david@david.com",
    department_id: departments.sample.id
  )

practitioner_images = %w[
  https://i.postimg.cc/j22dSzCb/black-female-nurse-smiling-face.png
  https://i.postimg.cc/LX6Zjghy/dark-female-doctor-face.png
  https://i.postimg.cc/RVCbqgMf/black-male-doc-with-tab-face.png
  https://i.postimg.cc/kMNg7g4G/black-canada-nurse-cropped.png
  https://i.postimg.cc/mrQ7RGFs/black-nurse-pointing-cropped.png
  https://i.postimg.cc/MpwQDFF3/Circilar-balck-male-focused.png
  https://i.postimg.cc/nrVWB2tX/circular-black-doc.png
  https://i.postimg.cc/V5Qb2GL6/dark-male-doctor.png
  https://i.postimg.cc/Xq3r8Z2G/black-male-doctor-smiling.png
  https://i.postimg.cc/FsrMt98j/black-female-doc-with-file-cropped.png
  https://i.postimg.cc/nrWR23zz/front-view-nurse-wearing-stethoscope.jpg
]

other_practitioners = []
practitioner_images.length.times do |i|
  other_practitioners << Practitioner.create!(
    username: Faker::Internet.username,
    password: Faker::Internet.password,
    email: Faker::Internet.email,
    department_id: departments.sample.id
  )
end

puts "11. seeding patient_profile"
vincent_profile =
  PatientProfile.create!(
    user_id: user1.id,
    first_name: "Vincent",
    last_name: "Makokha",
    bio: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
    dob: "2022-12-20",
    location: "Nairobi",
    blood_group: "0-",
    height: (rand() + 1).round(2),
    weight: (rand() + rand(50..100)).round(2),
    phone_number: "0701807557",
    bmi: (rand() + rand(15..30)).round(2)
  )

enock_profile =
  PatientProfile.create!(
    user_id: user2.id,
    first_name: "Enock",
    last_name: "Mokua",
    bio: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
    dob: "2022-12-20",
    location: "Nairobi",
    blood_group: "A+",
    height: (rand() + 1).round(2),
    weight: (rand() + rand(50..100)).round(2),
    phone_number: "0721409448",
    bmi: (rand() + rand(15..30)).round(2)
  )

puts "12. seeding appointment..."
appointment1 =
  Appointment.create!(
    user_id: user1.id,
    practitioner_id: practitioner1.id,
    date: "2022-12-20",
    time: "11:56",
    approved: true,
    appointment_type: "Consultation",
    appointment_info: "blah blah blah"
  )

appointment2 =
  Appointment.create!(
    user_id: user1.id,
    practitioner_id: practitioner1.id,
    date: "2022-12-20",
    time: "12:57",
    approved: false,
    appointment_type: "Consultation",
    appointment_info: "blah blah blah"
  )

appointment3 =
  Appointment.create!(
    user_id: user1.id,
    practitioner_id: other_practitioners.sample.id,
    date: "2022-12-20",
    approved: true,
    time: "18:40",
    appointment_type: "Paediatrics",
    appointment_info: "blah blah blah"
  )

puts "13. seeding messages..."
5.times do
  sender = [user1, practitioner1].sample
  receiver = (sender.class.to_s == "User") ? practitioner1 : user1
  Message.create!(
    appointment_id: appointment1.id,
    sender_id: sender.id,
    sender_class: sender.class.to_s,
    receiver_id: receiver.id,
    receiver_class: receiver.class.to_s,
    content: Faker::Lorem.paragraph(sentence_count: rand(1..3))
  )
end

puts "14. seeding practitioner_profile..."
david_profile =
  PractitionerProfile.create!(
    practitioner_id: practitioner1.id,
    first_name: "David",
    last_name: "Ondiege",
    bio: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
    dob: "2022-12-20",
    location: "Nairobi",
    blood_group: "B-",
    weight: (rand() + rand(50..100)).round(2),
    phone_number: "0756291474",
    bmi: (rand()+rand(15..30)).round(2),
    job_title: Faker::Job.title,
    image: "https://i.postimg.cc/pLQ1G3Xm/black-doc-cropped.png",
    height: (rand()+rand(50..200)).round(2)
)

other_practitioners.length.times do |i|
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
        bmi: (rand()+rand(15..30)).round(2),
        job_title: Faker::Job.title,
        image: practitioner_images[i],
        height: (rand()+rand(50..200)).round(2)
    )    
end

puts "Seeding completed!"
