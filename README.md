# 📚 Trash Treasure

Traveling in Japan is fun. You are visiting all the famous spots in Tokyo and you get hungry. You buy snacks and drinks at the convenience store. You're happy and full, but now you have empty wrappers and PET bottles. There isn't a trash bin nearby and you don't want to carry trash with you while exploring Tokyo. Trash Treasure fixes that problem. It will show you the nearest trash bin and guides you to it. Now, throwing away trash is no longer a problem!

Screenshots:
<br>
![IMG_7324](https://github.com/msam4/trash_treasure/assets/137851066/be03ac77-f5e6-4db2-9c4d-5869c711c402)
<br>
![IMG_7325](https://github.com/msam4/trash_treasure/assets/137851066/c091b959-6ef3-4f7d-b513-b8f5ebf15416)
<br>
![IMG_7327](https://github.com/msam4/trash_treasure/assets/137851066/06c47e8a-767f-47ad-9f23-3a9e39f41ee1)
<br>
![IMG_7328](https://github.com/msam4/trash_treasure/assets/137851066/38c3f9ae-d176-4fa7-aeff-e44dafa23e70)
<br>
![IMG_7330](https://github.com/msam4/trash_treasure/assets/137851066/05ab0457-60e1-42ae-8217-4b376398e159)


<br>

   

## Getting Started
### Setup

Install gems
```
bundle install
```

### ENV Variables
Create `.env` file
```
touch .env
```
Inside `.env`, set these variables. For any APIs, see group Slack channel.
```
CLOUDINARY_URL=your_own_cloudinary_url_key
MAPBOX_API_KEY=your_own_mapbox_api_key
```

### DB Setup
```
rails db:create
rails db:migrate
rails db:seed
```

### Run a server
```
rails s
```

## Built With
- [Rails 7](https://guides.rubyonrails.org/) - Backend / Front-end
- [Stimulus JS](https://stimulus.hotwired.dev/) - Front-end JS
- [Heroku](https://heroku.com/) - Deployment
- [PostgreSQL](https://www.postgresql.org/) - Database
- [Bootstrap](https://getbootstrap.com/) — Styling
- [Figma](https://www.figma.com) — Prototyping

## Team Members
- [Michael Sam](https://github.com/msam4)
- [Vincci Leung](https://github.com/elysianysus)
- [Guillermo Corral](https://github.com/GCM1120)

