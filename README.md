# TaskMaster


User
To do App built using flutter with following features:
Users can add a new task.
Users can mark a task as complete.
Users can edit existing tasks.
Users can delete tasks.

Additional Features :
Swipe animation for deletion of user task.

Convert this to github readme file
ChatGPT
Memory updated
Here's how you can convert your To-Do App features into a GitHub README file:

To-Do App
A simple To-Do App built using Flutter with the following features:

Basic Features
Add New Task: Users can add a new task to their to-do list.
Mark as Complete: Users can mark a task as complete when they finish it.
Edit Existing Tasks: Users can edit the details of existing tasks.
Delete Tasks: Users can delete tasks from their to-do list.
Additional Features
Swipe Animation: Implemented swipe animation for deleting tasks. Users can swipe left on a task to delete it.
Screenshots


Getting Started
To run the app locally:

Clone this repository.
Open the project in your preferred IDE.
Run flutter pub get to install dependencies.
Connect your device or emulator.
Run flutter run to launch the app.
Contributing
Contributions are welcome! Please fork the repository and submit a pull request.

License
This project is licensed under the MIT License.

Feel free to customize the README with your app's specific details, screenshots, and instructions for running the app locally.

User
give source code for this text
ChatGPT
Here's an example of how you can structure your Flutter To-Do App along with the basic source code for the functionality you described:

dart
Copy code
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ToDoScreen(),
    );
  }
}

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  List<String> tasks = ['Task 1', 'Task 2', 'Task 3']; // Initial tasks list

  void addTask(String task) {
    setState(() {
      tasks.add(task);
    });
  }

  void markAsComplete(int index) {
    setState(() {
      // Toggle task completion status
      // You can implement a Task class for better management
      // This is a basic example
      tasks[index] = tasks[index] + ' (Completed)';
    });
  }

  void editTask(int index, String newTask) {
    setState(() {
      tasks[index] = newTask;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do App'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(tasks[index]), // Unique key for each task
            onDismissed: (direction) {
              deleteTask(index);
            },
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete),
              alignment: Alignment.centerRight,
            ),
            child: ListTile(
              title: Text(tasks[index]),
              trailing: Checkbox(
                value: tasks[index].endsWith('(Completed)'),
                onChanged: (value) {
                  markAsComplete(index);
                },
              ),
              onTap: () {
                // Implement task editing functionality
                // For simplicity, just show a dialog to edit task
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    TextEditingController controller =
                        TextEditingController(text: tasks[index]);
                    return AlertDialog(
                      title: Text('Edit Task'),
                      content: TextField(
                        controller: controller,
                        onChanged: (value) {
                          // Update task when text changes
                          editTask(index, value);
                        },
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        FlatButton(
                          onPressed: () {
                            // Save edited task
                            editTask(index, controller.text);
                            Navigator.of(context).pop();
                          },
                          child: Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show dialog to add new task
          showDialog(
            context: context,
            builder: (BuildContext context) {
              TextEditingController controller = TextEditingController();
              return AlertDialog(
                title: Text('Add Task'),
                content: TextField(
                  controller: controller,
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  FlatButton(
                    onPressed: () {
                      // Add new task
                      addTask(controller.text);
                      Navigator.of(context).pop();
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
This code provides a basic implementation of a To-Do App in Flutter with the functionalities you described. You can further enhance it with customizations, error handling, and more features as per your requirements.

User
give me latex code for above github desc
ChatGPT
Certainly! Below is the LaTeX code for the GitHub README description of your To-Do App:

latex
Copy code
\documentclass{article}
\usepackage{graphicx}
\usepackage{hyperref}

\title{To-Do App}
\author{Your Name}
\date{\today}

\begin{document}
\maketitle

\section{Introduction}
A simple To-Do App built using Flutter with the following features:

\section{Basic Features}
\begin{enumerate}
  \item \textbf{Add New Task}: Users can add a new task to their to-do list.
  \item \textbf{Mark as Complete}: Users can mark a task as complete when they finish it.
  \item \textbf{Edit Existing Tasks}: Users can edit the details of existing tasks.
  \item \textbf{Delete Tasks}: Users can delete tasks from their to-do list.
\end{enumerate}

\section{Additional Features}
\begin{itemize}
  \item \textbf{Swipe Animation}: Implemented swipe animation for deleting tasks. Users can swipe left on a task to delete it.
\end{itemize}

\section{Screenshots}
\begin{figure}[h]
  \centering
  \includegraphics[width=0.4\textwidth]{screenshots/screenshot1.png}
  \caption{App Screenshot 1}
\end{figure}

\begin{figure}[h]
  \centering
  \includegraphics[width=0.4\textwidth]{screenshots/screenshot2.png}
  \caption{App Screenshot 2}
\end{figure}

\section{Getting Started}
To run the app locally:
\begin{enumerate}
  \item Clone this repository.
  \item Open the project in your preferred IDE.
  \item Run \texttt{flutter pub get} to install dependencies.
  \item Connect your device or emulator.
  \item Run \texttt{flutter run} to launch the app.
\end{enumerate}

\section{Contributing}
Contributions are welcome! Please fork the repository and submit a pull request.

\section{License}
This project is licensed under the \href{https://opensource.org/licenses/MIT}{MIT License}.

\end{document}
