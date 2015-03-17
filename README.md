# JobTeaser
JobTeaser search web app

1. About JobTeaser search engine:
  
  This application allows you to search a job using a set of parameters
  
  Name and description parameters
    - Title
    - Description
    - Location
    - Who may apply (Eg: Citizens)
    - WorkType (Eg: Permanent)
    - Schedule (Eg: Part time)
  Salary details
    - Min Salary (Eg: 50000)
    - Max Salary
    - Salary Basis (Eg: Per year)
    - Pay Plan (Eg: GS)
  Organization and agencies
    - Organization (Eg: Department Of Energy)
    - Agency (Eg: Power Administration)

    At least one search criteria has to be used. if not, no search will be performed

    The search results include:
      
      Stats
        - Number of found jobs
        - Number of found jobs and agencies if agency parameter was precised by the user
        - Number of found jobs and organizations if organization criteria was precised by the user
        - Number of found jobs, organizations and agencies if organization and agency criterias were precised by the user
      
      Found job details
        - A list of the found jobs with their descriptions and geolocalization based on gmap

2. How to get JobTeaser application up and running

  # rake db:migrate
  # rake db:seed [dataset_file]
  # rails s

3. The time spent to build the App
  - A first basic version took about 4 hours to be up and running
  - Optimizing the app, testing it and making it looking like it looks now took about 10 hour

4. Models design

   ______________                   ________                  _____
  |              |                 |        |                |     |
  | Organization |______________ * | Agency |_______________*| Job |
  |______________|                 |________|                |_____|

5. Enhancement
  - Add pagination if the number of found jobs exxeeds some limit (5 jobs for example)
  - Add Accordion (jQuery) to display the job details only when the title is clicked
  - Add a general gmap view to display all the found jobs (this sould be place next to the search form) 
  - Highlight the search strings in the results


