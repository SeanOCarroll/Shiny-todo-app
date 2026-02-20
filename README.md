# 📝 Shiny To-Do List App
Author: Seán O'Carroll


Contact Email: sean.ocarroll.2025@mumail.ie


Linkden: www.linkedin.com/in/seán-o-carroll-88babb327
## Website:

https://seanocarroll.shinyapps.io/my-shiny-app/

## 📌 Overview

This is a simple and interactive **To-Do List web application** built using R and the **Shiny** framework.
It allows users to add, manage, and track tasks in a clean and user-friendly interface.

---

## 🚀 Features

* ➕ Add new tasks (press **Enter** or click *Add Task*)
* ✅ Mark selected tasks as done/undone
* 🔁 Toggle all tasks as done or undone
* 🗑️ Delete selected tasks (supports multiple selection)
* ❌ Delete all tasks at once
* 📋 View all tasks in a structured table
* 🎨 Clean UI with improved spacing and styling

---

## 🛠️ Technologies Used

* R
* Shiny

---

## 📂 Project Structure

```
project-folder/
│
├── app.R       # Main Shiny application file
└── README.md   # Project documentation
```

---

## ▶️ How to Run the App

1. Open RStudio
2. Set your working directory to the project folder
3. Run the following command in the console:

```r
shiny::runApp()
```

👉 To open in your web browser instead of the RStudio viewer:

```r
shiny::runApp(launch.browser = TRUE)
```

---

## 🧠 How It Works

* Tasks are stored in a **reactive data frame**
* Each task has:

  * `id` (unique identifier)
  * `task` (text description)
  * `done` (TRUE/FALSE status)
* User selections are handled separately from task completion status
* Buttons control actions like marking tasks and deleting them

---

## 📸 Example Usage

1. Type a task (e.g., *Study for exam*)
2. Press **Enter**
3. Select one or more tasks
4. Click:

   * *Toggle Selected Done* → mark/unmark tasks
   * *Delete Selected* → remove tasks

---

## 🔮 Possible Improvements

* 💾 Save tasks (persistent storage)
* ✏️ Edit existing tasks
* 📅 Add due dates
* 🎯 Filter tasks (completed vs incomplete)
* 🌙 Dark mode toggle

Created as part of learning R Shiny.
