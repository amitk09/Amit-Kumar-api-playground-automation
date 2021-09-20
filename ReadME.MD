# Below is the Tools and Technology used in this project:

* Java 11
* Rest Assured
* Cucumber BDD 
* Maven 3.3.9
* Junit

# Below is the steps to run this project on your local machine :
* Install Java 11 and setup Environment variables
* Download Maven 3.3.9 (to run project using command line) and setup Environment variables
* Install NodeJS 8 
* Install git Bash
* git clone https://github.com/bestbuy/api-playground/
* cd api-playground
* npm install
* npm start
* git clone https://github.com/amitk09/Amit-Kumar-api-playground-automation.git
* cd api-playground-automation
* open command prompt or git bash and run ‘mvn clean install’
* Report will be available in “reports/advance-reports/cucumber-html-report” as  ‘overview-features’ once the execution is completed.

## Explanation: 
* Rest assured is made to automate API’s and is very powerful tool. Along with this it has very good support with Java. 
* Java 11 is used so that I can use some of the latest feature like Optional.Of, Filtering List or map using Stream API's etc.  
* Cucumber BDD is used so that non technical person like BA, PO or People Manager can look into the feature file and number of actual test cases in Jira or Rally, so that its easier for them to calculate the test automation coverage. 
* Maven is powerful build tool to install, packaging, verify, running test using command line. It has very good support with plugin and is very easy to maintain dependecies. 
* JSON files are used to generate request payload. it is easy to understand and manipulate the values according to test cases. 
* JSON schema is used to validate the response schema like fields present in response, type of fields in response etc. 
* src/test/features folders is having all the features files which contains scenario. feature directory is created based on resources and feature files are created based on operation like GET, POST etc.


