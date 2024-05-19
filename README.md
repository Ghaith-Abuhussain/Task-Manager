<<<<<<< HEAD
# task_managing

Task Manager Application (Demo App)
This application is built using Flutter 3.19.0. The main purpose is to achieve many Key Features like:
1. User Authentication: Implemented using the  https://dummyjson.com/docs/auth endpoint from dummyJSON. Just Login functionality is implemented using Retrofit package. The remember user functionality is also implemented.
2. Task Management: VIEW, ADD, EDIT, and DELETE functionalities are implemented using https://dummyjson.com/docs/todos endpoint and Retrofit package.
3. Pagination: This is done using Retrofit and ListView Scroll Listener.
4. State Management: Bloc architectural pattern is used for state management.
5. Local Storage: Floor Database is used to store the tasks after fetching them from the endpoint and after the update and deletion of any task.
6. Unit Testing: many unit tests are written using Mockito to test the CRUD operations and User Authentication logic in many situations like (no internet connection, and error fetching data from the server).

The project is structured into data, domain, and presentation layers using Clean Architecture. The presentation layer is responsible for displaying the data and contains many Screens:
-LoginScreen.
-HomeScreen.
each screen is connected to a Bloc Provider which runs the business logic (accepting events and emitting states).
The domain layer contains the models (the requests, the responses, and the local database entities) it also contains the interfaces of the app repositories.
the data layer contains the implementations of the local and remote repositories. It is responsible for fetching the data from the database and the remote endpoints.

How the app works:
when the user runs the app a screen will show up and the user must login. If the user clicks The Login Button the app will transfer him to a login screen and there he must enter the email (one of the predefined emails in reqres API only) and the password then hit Login. On the login page, the user can check the Remember me 
checkbox to remember the email and the password if the login was successful. Note that the user can login only with user's credentials from https://dummyjson.com/users .
After login, the user will be transferred to the HomeScreen where he will be able to view the tasks (when we use https://dummyjson.com/todos?limit=3&skip=10 Get API). The user can notice that there are only 10 in the begining tasks but if he scrolls down to the last one
the pagination will be activated and the app will fetch the second page until there is no data to fetch then the app will show a Toast to inform the user.
Each task card contains two buttons one to delete the task after calling the https://dummyjson.com/todos/{id} DELETE API. and another one shows the user a dialog to edit the info of the task using https://dummyjson.com/todos/{id} PUT api.
in the bottom right of the screen, there is a button that shows the user a dialog to enter new info to add a new task using the https://dummyjson.com/todos/add POST api.
If the user scrolls up to the first task the Refresh Indicator will update the tasks by calling the first page from the remote endpoint and after this call, the database will be empty and refulled with the new data.
To achieve Persisting tasks locally a Floor database is used and the database is updated after fetching the data, updating it, and adding new tasks. When the user exits the app without log out and runs the app again, the router will take him to the Home page imidiatelly without logging in.
A 17-unit tests are done using Mokito to test the Login logic and CRUD operations in many situations like (no internet connection, or error fetching data from the server). you can see them in login_unit_test.dart and crud_unit_test.dart files in the test folder.

You can watch a demo video of the application in the following Google Drive link:
https://drive.google.com/file/d/1bywJCIWIPIp-Zm0b35_GM4EJNCuBeohF/view?usp=sharing

To run the app just download the project from the GitHub repository:
https://github.com/Ghaith-Abuhussain/task_manager.git

and run the command:
flutter run -d [Targat Name]

 

samples, guidance on mobile development, and a full API reference.
=======
# Task-Manager
>>>>>>> e7295e5cef61d2dbeaddc17a891f2742432b513a
