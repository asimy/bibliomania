###Readme

This is a toy app that allows any user to search Google Books, display the results and mark books as a favorite. Searches are also saved and the user can click on any of the last 10 searches to redisplay the books that were found.

####Running the app locally
Note that this app uses a PostgreSQL database.
  1. `git clone` the app locally
  2. `cd` into the local directory
  2. Run `bundle install` at the app's root level the gems
  3. Run `rake db:create db:migrate`
  3. Run `rails s`

####Testing
The minimal test coverage for the app can be run by executing `rspec` at the app's root level.

####Current issues:
  - The pagination is broken
  - The favoriting gets squirrely when the pagination breaks
