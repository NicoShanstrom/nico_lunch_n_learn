# Nico_lunch_n_learn

**Learning Goals**
*Expose an API that aggregates data from multiple external APIs
*Expose an API that requires an authentication token
*Use TDD to ensure code reliability and functionality.
*Utilize poros for data preparation making it ready for use in serializer
*Utlilize serializers for format JSON responses
*Keep controllers as simple as possible
*Implement Basic User Authentication
*Handle errors gracefully and provide meaningful error messages.
*Expose an API for CRUD functionality
*Determine completion criteria based on the needs of other developers
*Test both API consumption and exposure, making use of at least one mocking tool *(VCR, Webmock, etc).

**Project Setup**
* Ruby version
  - Ruby: 3.2.2
* Rails version
  - Rails: 7.1.3.4
* Installation
  - Clone the repo to your machine
    - git clone <github_repo_url>
    - cd <repo_directory>
  - Install dependencies
    - bundle install
  - Set up the database
    - rails db:create
    - rails db:migrate
  - Run the tests
    - bundle exec rspec
  - Start the server
    - rails server
**API Keys**
*Edamam Recipe API
  - Sign up: https://www.edamam.com/
  - Get your keys: Follow the instructions to obtain your APP_ID and APP_KEY
*YouTube API
  - Sign up: https://console.cloud.google.com/
  - Create a new project.
  - On the new project dashboard, click Explore & Enable APIs.
  - In the library, navigate to YouTube Data API v3 under YouTube APIs.
  - Enable the API.
  - Create a credential.
  - A screen will appear with the API key.
*UpSplash API (or other image api)
  - Sign up: https://unsplash.com/developers
  - Follow instructions to get API key
*RestCountries API
  - Does not need an api key
  - Application also works without this API if it times out or has a connection error
    - Uses COUNTRIES config/countries.yml file
*Places API
  - This is a nico_lunch_n_learn extension, not necessary for the functionality of nico_lunch_n_learn
  - Sign up: https://apidocs.geoapify.com/docs/places/#about follow directions on page
**Configuration**
* Create a config/credentials.yml.enc file to store your API keys securely
  - Example format:
    EDAMAM:
      APP_ID: <your_edamam_app_id>
      APP_KEY: <your_edamam_app_key>

    YOUTUBE:
      API_KEY: <your_youtube_api_key>

    UNSPLASH:
      ACCESS_KEY: <your_unsplash_access_key>
**ENDPOINTS**
  - Get Recipes for a particular country
    - Request example:
    GET /api/v1/recipes?country=thailand
    Content-Type: application/json
    Accept: application/json
  - Get learning resources for a particular country
    - Request example:
    GET /api/v1/learning_resources?country=laos
    Content-Type: application/json
    Accept: application/json
  - User Registration
    - Request example:
    POST /api/v1/users
    Content-Type: application/json
    Accept: application/json

    {
      "name": "Odell",
      "email": "goodboy@ruffruff.com",
      "password": "treats4lyf",
      "password_confirmation": "treats4lyf"
    }
  - Log in user
    - Request example:
    POST /api/v1/sessions
    Content-Type: application/json
    Accept: application/json

    {
      "email": "goodboy@ruffruff.com",
      "password": "treats4lyf"
    }
  - Add favorite recipes
    - Request example:
    POST /api/v1/favorites
    Content-Type: application/json
    Accept: application/json

    {
      "api_key": "valid_user_api_key",
      "country": "thailand",
      "recipe_link": "https://www.tastingtable.com/.....",
      "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
    }
  - Get a User's Favorites
    - Request example:
    GET /api/v1/favorites?api_key=valid_user_api_key
    Content-Type: application/json
    Accept: application/json
**Refactor/Additions ideas**
*Create facades for services and associated facade spec
*Create error serializer for organization of error handling
*Create a log out endpoint
*Create tokens or caching to keep user logged in for longer
*For the recipes and learning resources endpoints, use the REST Countries API to validate that the country parameter passed in is in fact a valid country. If it isn’t, return an appropriate 400-level status code.
*Add an endpoint to DELETE a favorite ( DELETE ‘/api/v1/favorites’)
*Utilize caching OR background workers to optimize API calls.

