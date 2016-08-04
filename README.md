heroku setup
wget -0- https://toolbelt.heroku.com/install-ubuntu.sh | sh
heroku version
heroku login
heroku keys:add
heroku create
git push heroku master
#create a new branch
git checkout -b static_pages
