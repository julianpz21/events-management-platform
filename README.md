# README

# **Event Management Application**

## **Description**
This application allows users to register and manage events. Users can create an account, log in, and manage their profiles. There are two roles in the system:
- **Admin**: Can manage all users and events.
- **User**: Can show, register and unregister to events.

---

## **Features**
### **Authentication**
- Secure user authentication implemented using Devise.
- Users can register, log in, log out, and update their profiles.

### **Roles**
- **Admin**: Has access to all resources in the system.
- **User**: Limited to managing their own events.

### **Event Management**
- Users can create, edit, and delete their own events.
- Admins can manage all events in the system.

---

## **Getting Started**

### **Prerequisites**
- Ruby `>= 3.0.0`
- Rails `>= 7.0`
- PostgreSQL `>= 12`
- Bundler

### **Installation**
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/event-management-app.git
   cd event-management-app
   ```
### **Install dependencies**
1. bundle install
### **Set up the database**
1. configure .env file
  ```bash
  POSTGRES_HOST=localhost
  POSTGRES_USERNAME=your-postgres-username
  POSTGRES_PASSWORD=your-postgres-password
  ```
2. rails db:create
3. rails db:migrate

### **Start the Rails server**
rails server

### **Usage**

This application allows users to register and manage events. Users can create an account, log in, and manage their profiles. There are two roles in the system:


## **Features**

### **Authentication**

Secure user authentication implemented using Devise.
Users can register, log in, log out, and update their profiles.

### **Roles**

Admin: Has access to all resources in the system.
User: Limited to managing their own events (view events, register events and unregister events).

### **Event Management**

Admins can create, edit, archive and delete their own events.
users can view events, register events and unregister events

### **Email Notifications**

This application implements an event to sends emails to users two days before an event occurs. The system uses a background job that runs every night at midnight to check which events have users assigned to them and sends the email notifications.

The email is only sent once per user per event.

---

#### Features
- Background job that runs every night at midnight.
- Sends email notifications to users 2 days before the event.
- Ensures the email is only sent once per user per event.
- Email notifications are sent for events with users assigned to them.

---

## Database Structure

The application uses three tables: users, events, and enrollments

### **1. Users Table**
The `users` table stores information about the users of the platform. Each user can register for events, and the role can be either an `admin` or a `user`.

### **2. Events Table**
The `events` table stores information about the events. Each event has a date and other relevant details.

### **3. Enrollments Table**
The `enrollments` table acts as a join table between the `users` and `events` tables. It tracks which users are enrolled in which events.

#### **Relationships:**
- Each **user** can enroll in many **events**.
- Each **event** can have many **users** enrolled.
- The `enrollments` table links users and events, indicating the users who are registered for each event.


## API (api/v1) Endpoints

This application also provides an API (located in `/api/v1`) to handle requests and also includes GraphQL support in (located in `/graphql`). The following endpoints are available for interacting with the system:

### **1. User Authentication Endpoints**

[API and Endpoints documentation](https://documenter.getpostman.com/view/754743/2sAYBbd8zD)

The API provides endpoints for user authentication via Devise.

#### **POST /api/v1/login**
- **Description**: Log in a user.
- **Action**: Allows a user to log in and receive an authentication token for making further API requests.

#### **DELETE /api/v1/logout**
- **Description**: Log out a user.
- **Action**: Logs out the user and invalidates their authentication token.

### **2. Events Endpoints**

The API allows users to interact with events through the following actions (each request with **Authorization bearer Token**):

#### **GET /api/v1/events**
- **Description**: Fetch a list of all events.
- **Action**: Retrieve events available in the system.

#### **POST /api/v1/events**
- **Description**: Create a new event.
- **Action**: Create an event in the system by providing necessary details (e.g., name, date, description, etc.).

#### **PATCH /api/v1/events/:id**
- **Description**: Update an existing event.
- **Action**: Modify the details of an existing event (e.g., name, description, etc.).

#### **Event Member Actions:**
- **PATCH /api/v1/events/:id/archive**
  - **Description**: Archive an event.
  - **Action**: Mark an event as archived.

- **PATCH /api/v1/events/:id/delete**
  - **Description**: Delete an event.
  - **Action**: soft delete to remove an event from the system.

- **POST /api/v1/events/:id/register**
  - **Description**: Register a user for an event.
  - **Action**: A user can register for an event.

- **DELETE /api/v1/events/:id/unregister**
  - **Description**: Unregister a user from an event.
  - **Action**: A user can unregister from an event.

---

## GraphQL API

In addition to the RESTful API, this application also supports GraphQL for querying and mutating data. You can use GraphQL to interact with resources in a more flexible and efficient way.

### **GraphQL Endpoint**
- **URL**: `/graphql`
- **Description**: The GraphQL endpoint allows users to query and mutate data by sending GraphQL queries and mutations.
(each request with **Authorization bearer Token**)

#### **Get Events**
Description: Retrieves all events with their ID, name, date, and description.
##### **Example Request:**

```bash
{
  events {
    id
    name
    date
    description
  }
}

```
##### **Example Response:**
```bash
{
  "data": {
    "events": [
      {
        "id": "1",
        "name": "GraphQL Workshop",
        "date": "2024-12-10",
        "description": "Learn GraphQL basics"
      }
    ]
  }
}
```

#### **Get My Events**
Description: Retrieves all events I am registered for
##### **Example Request:**

```bash
{
  myEvents {
    id
    name
    date
    description
  }
}

```

#### **Create Event**
Description: Create Event
##### **Example Request:**

```bash
mutation {
    createEvent(
        input: {
            name: "event name new"
            date: "2024-12-23"
            description: "description"
            place: "place"
            capacity: 5
            category: 2
        }
    ) {
        event {
            id
            name
            status
        }
    }
}
```

#### **Update Event**
Description: Update Event
##### **Example Request:**

```bash
mutation {
  udpateEvent(
    input: {
      name: "event name updated",
      date: "2024-12-23",
      description: "description",
      place: "place",
      capacity: 5,
      category: 2
    }
  )
}
```

#### **Archive Event**
Description: archive a Event
##### **Example Request:**

```bash
mutation {
  archiveEvent(
    input: {
      id: 3
    }
  )
}
```

#### **delete Event**
Description: archive a Event
##### **Example Request:**

```bash
mutation {
  deleteEvent(
    input: {
      id: 3
    }
  )
}
```

#### **Register Event**
Description: register to a Event
##### **Example Request:**

```bash
mutation {
  registerEvent(
    input: {
      userId: 3,
      eventId: 5
    }
  )
}
```

#### **Unregister Event**
Description: Unregister to a Event
##### **Example Request:**

```bash
mutation {
  UnregisterEvent(
    input: {
      userId: 3,
      eventId: 5
    }
  )
}
```
