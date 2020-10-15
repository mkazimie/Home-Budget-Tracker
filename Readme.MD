## Budgetary
### Home Budget Tracker with Spring Boot and MySQL

This app helps you keep track of your home expenses.

####How does it work?
Create new budgets (weekly, monthly, or however you wish) and fill them with categories.
Register your expenses for each category and get an overview of where your money is going.





### Technology:
* Java - v.8
* Spring Boot -v.2.3.4
* Spring Data JPA
* Spring MVC
* Spring Security
* JSP
* Lombok
* MySQL
* Maven
* Bootstrap




### Run the Application Locally:

* Download the project.

#### DB setup:

* Connect to MySQL using your credentials and create an empty database.

* Go to `src/main/resources/application.properties` and update the datasource url, username and password according to
 your MySQL configuration. The table schema will be created for you in your database.

#### Run:

* Execute the `$ mvn spring-boot:run` command in our project root folder. The app will start running at http
://localhost:8080.