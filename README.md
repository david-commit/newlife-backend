# NewLife Hospital App

## Introduction

Newlife Hospital App is an application that looks to simplify healthcare processes for both practitioners eg doctors, nurses, surgeons, nutritionists, caregivers etc and the patients themselves

## Problem Statement

As a result of lack of proper management systems in the healthcare institutions, many patients succumb to their illnesses due to irregular checkups and appointments. Practitioners have a lot of patients to cater for making it easy to lose track of duties they are to attend to in a timely manner.
Lack of proper planning can lead to dire consequences to both the medical institution and the practitioners themselves

## Deployments

deployed link https://newlife-production.up.railway.app

## MVP

Done:

1. A user is able to sign up as a patient
2. A user is able to log in as a patient
3. A patient is able to book an appointment with a practitioner of their choice
4. A user is able to see a list of all practitioners
5. A patient is able to delete(descendant destroy) his/her account
6. A user is able to view all and single shop products
7. A user can post, show & delete their cart data to the DB
8. CRUD a practitioner
9. A practitioner is able to log in to an existing account (created by Admin)

Doing:

11. A practitioner can has access to all patient records/details
12. A practitioner can CRUD an appointment with a patient
13. A user can log in as an admin
14. An admin can CRUD a shop product
15. An Admin can see the hospital's dashboard
16. An Admin can see a list of all patients
17. An Admin can log in and out

# API Documentation

## Users (Patients)

1. INDEX - List of all users (patients), can only be queried by practitioner or admin roles

   GET: `/users`

   Response:

```json
[
  {
    "id": 1,
    "username": "vincent",
    "email": "vincent@patient.com",
    "first_name": "David",
    "last_name": "Ondiege",
    "orders": [
      {
        "id": 1,
        "delivered": false
      }
    ],
    "appointments": [
      {
        "id": 1,
        "date": "2022-12-20",
        "approved": true,
        "appointment_type": "Consultation",
        "appointment_info": "blah blah blah",
        "time": "11:56"
      }
    ],
    "patient_profiles": [
      {
        "id": 1,
        "first_name": "Vincent",
        "last_name": "Makokha",
        "bio": "Neque earum at.",
        "dob": "2022-12-20",
        "location": "Nairobi",
        "blood_group": "0-",
        "height": 1.61,
        "weight": 83.94,
        "phone_number": "0701807557",
        "bmi": 15.76
      }
    ]
  },
  {
    "id": 2,
    "username": "enock",
    "email": "enock@patient.com",
    "first_name": "Venessa",
    "last_name": "Smith",
    "orders": [],
    "appointments": [],
    "patient_profiles": [
      {
        "id": 2,
        "first_name": "Enock",
        "last_name": "Mokua",
        "bio": "Odit asperiores amet. Optio totam quidem. Optio accusamus eos. In repellat quibusdam. Quod error sed.",
        "dob": "2022-12-20",
        "location": "Nairobi",
        "blood_group": "A+",
        "height": 1.54,
        "weight": 86.2,
        "phone_number": "0721409448",
        "bmi": 20.08
      }
    ]
  }
]
```

2. LOGIN - Creates a session that enables auto-login for an already pre-existing user

   POST: `/login`

   Post data:

```json
{
  "username": "vincent",
  "email": "vincent@patient.com",
  "password": "Vincent111"
}
```

Response:

```json
[
  {
    "user": {
      "id": 1,
      "username": "vincent",
      "email": "vincent@patient.com",
      "orders": [
        {
          "id": 1,
          "user_id": 1,
          "created_at": "2023-/signup01-12T07:21:34.017Z",
          "updated_at": "2023-01-12T07:21:34.017Z",
          "delivered": false
        }
      ],
      "appointments": [
        {
          "id": 1,
          "user_id": 1,
          "practitioner_id": 1,
          "date": "2022-12-20",
          "approved": true,
          "appointment_type": "Normal",
          "created_at": "2023-01-12T07:21:37.532Z",
          "updated_at": "2023-01-12T07:21:37.532Z"
        }
      ],
      "patient_profiles": [
        {
          "id": 1,
          "user_id": 1,
          "first_name": "Vincent",
          "last_name": "Makokha",
          "bio": "Libero ea autem. Eum laudantium voluptas. Rerum nihil et. Labore ipsum quos.",
          "dob": "2022-12-20",
          "location": "Nairobi",
          "blood_group": "0-",
          "height": 1.8,
          "weight": 64.35,
          "phone_number": "0701807557",
          "bmi": 30.81,
          "created_at": "2023-01-12T07:21:37.493Z",
          "updated_at": "2023-01-12T07:21:37.493Z",
          "image": null
        }
      ]
    },
    "jwt": "eyJhb ... HM5aDI"
  }
]
```

3. SIGNUP - Creare a new patient account

   POST: `/signup`

   Post data:

```json
{
  "username": "cynthia",
  "password": "Cynthia111",
  "password_confirmation": "Cynthia111",
  "email": "cynthia@patient.com"
}
```

Response:

```json
[
  {
    "user": {
      "id": 3,
      "username": "cynthia",
      "email": "cynthia@patient.com",
      "orders": [],
      "appointments": [],
      "patient_profiles": []
    },
    "jwt": "eyJV ... cxRc"
  }
]
```

4. PATEINT PROFILE DATA - Adds user data to an already signed in patient's profile.

   POST: `/patient_profiles`

Post data:

```json
{
  "user_id": "3",
  "first_name": "Mary",
  "last_name": "Wangari",
  "bio": "Lorem qwertyui qwertyu qwert",
  "dob": "2022-12-20",
  "location": "Nairobi",
  "blood_group": "A+",
  "height": "3",
  "weight": "56",
  "phone_number": "1234567890",
  "bmi": "45"
}
```

Response:

```json
[
  {
    "id": 3,
    "first_name": "Mary",
    "last_name": "Wangari",
    "bio": "Lorem qwertyui qwertyu qwert",
    "dob": "2022-12-20",
    "location": "Nairobi",
    "blood_group": "A+",
    "height": 3.0,
    "weight": 56.0,
    "phone_number": "1234567890",
    "bmi": 45.0,
    "user": {
      "id": 3,
      "username": "Mary",
      "email": "mary@patient.com"
    }
  }
]
```

5. BOOK AN APPOINTMENT - Patient can book an appointment with a practitioner

   POST: `/appointments`

   Post data:

```json
{
  "user_id": "3",
  "practitioner_id": 1,
  "date": "2022-12-20",
  // "approved": true,
  "appointment_type": "Normal"
}
```

Response:

```json
[
  {
    "id": 4,
    "date": "2022-12-20",
    "approved": null,
    "appointment_type": "Normal",
    "user": {
      "id": 3,
      "username": "cynthia",
      "email": "cynthia@patient.com"
    },
    "practitioner": {
      "id": 1,
      "username": "david",
      "email": "david@david.com"
    }
  }
]
```

6. UPDATE AN APPOINTMENT - A patient is able to update an existing appointment

   PATCH: `/appointments/:id`

   Post data:

```json
{
  "date": "2023-01-20",
  "approved": true
}
```

Response:

```json
[
  {
    "id": 4,
    "date": "2023-01-20",
    "approved": true,
    "appointment_type": "Normal",
    "user": {
      "id": 3,
      "username": "cynthia",
      "email": "cynthia@patient.com"
    },
    "practitioner": {
      "id": 1,
      "username": "david",
      "email": "david@david.com"
    }
  }
]
```

7. DELETE USER - A parient is able to delete his/her account together with all associated records

   DELETE: `/users/:id`

   No response

8. USER'S ORDERS (INDEX & SHOW) - A patient can see all his/her orders

   GET: `/users/:id/orders` & `/users/:id/orders/:id`

   Response:

```json
[
  {
    "id": 1,
    "delivered": false,
    "user": {
      "id": 1,
      "username": "vincent",
      "email": "vincent@patient.com"
    },
    "payment": {
      "id": 1,
      "business_short_code": 0,
      "password": null,
      "transaction_type": null,
      "party_A": null,
      "party_B": null,
      "phone_number": null,
      "callback_url": null,
      "account_reference": null,
      "transaction_desc": null,
      "amount": null
    },
    "products": [
      {
        "id": 16,
        "name": "Cymbalta",
        "category": "Depression",
        "price_in_2dp": 33.86,
        "description": null,
        "image": "https://www.cphi-online.com/46/product/124/50/63/281Amitriptine-50-mg%20(1).jpg",
        "dosage": null,
        "stock": 9
      },
      {
        "id": 18,
        "name": "Zoloft",
        "category": "Depression",
        "price_in_2dp": 16.52,
        "description": null,
        "image": "https://www.cphi-online.com/46/product/124/50/63/281Amitriptine-50-mg%20(1).jpg",
        "dosage": null,
        "stock": 73
      }
    ]
  }
]
```

<hr />

## Practitioners

1. INDEX - List of all practitioners, anyone can view

   GET: `/practitioner_profiles`

   Response:

```json
[
  {
    "id": 1,
    "first_name": "David",
    "last_name": "Ondiege",
    "bio": "Qui vero omnis. Excepturi ut quia. Voluptatem et cupiditate. Veniam sit quae.",
    "dob": "2022-12-20",
    "phone_number": "0756291474",
    "location": "Nairobi",
    "blood_group": "B-",
    "weight": 57.26,
    "bmi": 17.77,
    "practitioner": {
      "id": 1,
      "username": "david",
      "email": "david@david.com"
    }
  },
  {
    "id": 2,
    "first_name": "Roderick",
    "last_name": "Stracke",
    "bio": "Commodi animi quia. In aspernatur numquam. Quam ea qui. Numquam amet doloribus. Modi occaecati blanditiis.",
    "dob": "2022-12-20",
    "phone_number": "0756291474",
    "location": "South Arica",
    "blood_group": "B-",
    "weight": 86.37,
    "bmi": 21.21,
    "practitioner": {
      "id": 2,
      "username": "kathey",
      "email": "kelli@larson.io"
    }
  }
]
```

2. SHOW - Returns a single practitioner

   GET: `/practitioner_profiles/:id`

   Response:

```json
[
  {
    "id": 7,
    "first_name": "Jerrold",
    "last_name": "Schuster",
    "bio": "Ut autem velit. Neque sequi ex. Saepe animi officiis. Dolores vero voluptatem. Dolor laudantium minima.",
    "dob": "2022-12-20",
    "phone_number": "0756291474",
    "location": "Port Hunghaven",
    "blood_group": "B-",
    "weight": 56.94,
    "bmi": 26.14,
    "practitioner": {
      "id": 7,
      "username": "faustino.hickle",
      "email": "armando_nicolas@dooley.name"
    }
  }
]
```

3. SIGNUP / CREATE - Add a new practitioner

   POST: `practitioner_profiles`

   Post data:

```json
{
  "username": "mike",
  "password": "MikeMike111",
  "email": "mike@patient.com",
  "department_id": 1
}
```

Response:

```json
[
  {
    "practitioner": {
      "id": 12,
      "username": "mike",
      "email": "mike@patient.com",
      "appointments": [],
      "practitioner_profiles": []
    },
    "jwt": "eyJh ... lWc"
  }
]
```

4. LOGIN - Create browser session for a practitioner that enables auto-login. An already existing practitioner.

   POST: `/practitioner/login`

   Post data:

```json
{
  "username": "mikw",
  "email": "mike@patient.com",
  "password": "MikeMike111"
}
```

Response:

```json
[
  {
    "practitioner": {
      "id": 12,
      "username": "mike",
      "email": "mike@patient.com",
      "appointments": [],
      "practitioner_profiles": []
    },
    "jwt": "eyJh ... lWc"
  }
]
```

5. LOGOUT - Deletes an active practitioner's session

   DELETE: `/practitioner/logout`

   No response

<hr />

## Administrator

1. LOGIN - Creates a session to enable auto-login

   POST: `/admin/login`

   Post data:

```json
{
  "username": "admin",
  "password": "Admin111"
}
```

Response:

```json
[
  {
    "admin": {
      "id": 1,
      "username": "admin",
      "email": "admin@newlife.com"
    },
    "jwt": "eyJhbGciOiJIUzI1NiJ9.eyJhZG1pbl9pZCI6MX0.RfiiVDDCOCd1TXdGycazUDirDiQ_5fYBlesoKBaUsJ8"
  }
]
```
