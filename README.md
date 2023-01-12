# NewLife Hospital App

## Introduction

Newlife Hospital App is an application that looks to simplify healthcare processes for both practitioners eg doctors, nurses, surgeons, nutritionists, caregivers etc and the patients themselves

## Problem Statement

As a result of lack of proper management systems in the healthcare institutions, many patients succumb to their illnesses due to irregular checkups and appointments. Practitioners have a lot of patients to cater for making it easy to lose track of duties they are to attend to in a timely manner.
Lack of proper planning can lead to dire consequences to both the medical institution and the practitioners themselves

## MVP

Doing:

1. A user is able to sign up as a patient
2. A user is able to log in as a patient
3. A patient is able to book an appointment with a practitioner of their choice
4. A patient is able to update & delete(descendant destroy) his/her account
5. A practitioner is able to log in to an existing account (created by Admin)
6. A practitioner can has access to all client records/details
7. A practitioner can CRUD an appointment with a patient
8. A user is able to view all and single shop products
9. A user can log in as an admin
10. An admin can CRUD a shop product
11. An admin can CRUD a practitioner
12. A user can post, show & delete their cart data to the DB
13. An Admin can see the hospital's dashboard
14. An Admin can see a list of all patients
15. An Admin can log in and out

# API Documentation

## Users (Patients)

1. INDEX - List of all users (patients)b, can only be queried by practitioner or admin roles

   GET: `/users`

   Response:

```json

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

3. CREATE - Add a new practitioner

   POST: `practitioner_profiles`

   Post data:

```json
[
  {
    "username": "mike",
    "password": "MikeMike111",
    "email": "mike@patient.com",
    "department_id": 1
  }
]
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
   [
     {
       "username": "mikw",
       "email": "mike@patient.com",
       "password": "MikeMike111"
     }
   ]
   ```

   Response:

   ```json
   [
    
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

```

Response:

```json

```
