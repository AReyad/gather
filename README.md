# Gather

an event management web application written in Ruby on Rails, allowing users to create, manage, and attend events.

## Features

- **Public & Private Events:**
  - **Public Events:** Visible to everyone and can be attended by any registered user.
  - **Private Events:** Hidden from public listings and can only be attended through invitations.
- **Event Management:**
  - Create, edit, and delete events you host.
  - Events become locked once they have ended and can no longer be edited or attended.
- **Attendance System:**
  - Join any public event.
  - Accept invitations to attend private events.
  - Leave an event at any time before it ends.
- **Host Controls:**
  - Invite users to private events.
  - Remove attendees from hosted events.
- **Event Status:**
  - Events are automatically categorized as **Upcoming** or **Past**.
  - Past events cannot be attended, edited, or left.
- **User Profiles:**
  - View events you've created.
  - View events you're attending.

---

## Installation

To run this project locally, ensure you have **Ruby** and **Ruby on Rails** installed.

1. Clone the repository:

```bash
git clone git@github.com:AReyad/gather.git
```

2. Navigate to the directory:

```bash
cd gather
```

3. Install dependencies:

```bash
bundle install
```

4. Set up the database:

```bash
bin/rails db:setup
```

5. Start the Rails server:

```bash
bin/rails server
```
