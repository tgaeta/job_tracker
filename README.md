<h1 align="left">
  <a href="#">
    <img src="https://github.com/user-attachments/assets/c5840b5d-efc9-4644-95ff-ac94c546a5d8" width="128px"/>
  </a>

  Job Tracker

  <p align="left">
    <a href="https://github.com/tgaeta/job_tracker/actions">
      <img alt="Build Status" src="https://github.com/tgaeta/job_tracker/actions/workflows/ci.yml/badge.svg"/>
    </a>
    <a href="https://github.com/tgaeta/job_tracker/blob/master/LICENSE.txt">
      <img alt="License" src="https://img.shields.io/badge/license-MIT-428F7E.svg"/>
    </a>
    <a href="https://codeclimate.com/github/tgaeta/job_tracker/maintainability"><img src="https://api.codeclimate.com/v1/badges/1cd4e3f1c0a4c5af29b1/maintainability" /></a>
  </p>
</h1>

## Introduction 📜

Job Tracker is a simple, powerful, and user-friendly web application designed to help job seekers efficiently manage their job search process. Built with Ruby on Rails and enhanced with modern web technologies, this tool streamlines the often overwhelming task of tracking multiple job applications.

<img alt="UI Screenshot" src="https://github.com/user-attachments/assets/1b4ec900-a670-4220-bf01-1df1cfba5914"/>

## Key Features

- **Intuitive Interface**: Easy-to-use dashboard for quick overview of all job applications.
- **Detailed Tracking**: Record essential information for each application, including:
  - Applied
  - Company
  - Position
  - Postion Type (Full-time, Part-time, Internship)
  - Contact Method
  - Point of Contact (P.o.C.)
  - Email
  - Website
- **Dynamic Filtering**: Quickly find specific applications using search and filter options.
- **Real-time Updates**: Leveraging Hotwire for seamless, dynamic content updates without full page reloads.
- **Responsive Design**: Fully functional on both desktop and mobile devices.

## Technical Stack

- **Backend**: Ruby on Rails 7
- **Frontend**:
  - Tailwind CSS for styling
  - Hotwire (Turbo and Stimulus) for dynamic interactions
  - Vite for modern JavaScript bundling
- **Database**: PostgreSQL

## Getting Started 🚀

### System Requirements
You will need the following to run the application.

- [**Ruby 3.3.1**](./docs/installing_prerequisites.md#ruby)
- [**PostgreSQL 16.3**](./docs/installing_prerequisites.md#postgresql)
- [**Bun**](./docs/installing_prerequisites.md#bun)

Refer [here](./docs/installing_prerequisites.md) to install these dependencies


### Running the application

Start your application

```bash
./bin/dev
```

This runs overmind or foreman using the Procfile.dev. It starts the rails server, solid queue background job process and vite server.

Visit `http://localhost:3000` to see the home page 🚀.

## Seed Data

To help you get started and test the application's features, I've included a seed file that generates 50 sample job applications. This data is designed to simulate a realistic job search scenario.

```bash
rails db:seed
```

### Running locally with docker
Job Tracker supports docker and docker compose for local development.
Install Docker and Docker desktop,

Once you have cloned the repository and have Docker installed, follow the following steps

- Run `docker compose build` to build. It will build the necessary images.
- Run `docker-compose run --rm web bin/setup` to create and set up the database.
- Run `docker compose up` to start the application.
Since the local code from your host machine is mounted in the docker container, any change made locally will be directly reflected. You don't need to rebuild the container.

## Deployment 📦
- Heroku
- Render

## Testing 🧪
Running all tests
```
./bin/rails test:all
```

## License 🔑
JobTracker is released under the [MIT License](./LICENSE.txt).


## Contributing 🤝

**Contributions Welcome:** I'm open to contributions! If you'd like to help improve this project:

1. Fork the repository
2. Create a new branch for your feature or bug fix
3. Make your changes and commit them with clear, descriptive messages
4. Push your changes to your fork
5. Create a pull request with a detailed description of your changes

I appreciate all contributions, big or small. Let's build something great together! 🚀

🚧 **Note:** This project is currently under active development and is very much a work in progress. Features may change.

## Acknowledgements

This project was built upon the foundation provided by [Shore](https://github.com/yatish27/shore), a Ruby on Rails template with a modern stack for starting new projects. I express my gratitude to the Shore project for providing an excellent starting point.

> Shore is a Ruby on Rails template with modern stack to start your new project.

I highly recommend checking out the Shore project for anyone looking to kickstart their Ruby on Rails development with a modern, well-structured template.
