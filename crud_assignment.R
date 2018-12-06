library("DBI")
library("RMySQL")

#setup to connect to mysql
mydb = dbConnect(MySQL(), user='root', password='rootpswd', host='localhost')

# Create database named thesis and use it.
dbSendQuery(mydb, "CREATE DATABASE thesis;")
dbSendQuery(mydb, "USE thesis;")

# Queries to create tables
student_tbl_query <- "CREATE TABLE Student (
    stud_id INT AUTO_INCREMENT,
    name VARCHAR(50),
    project_id INT NOT NULL,
    advisor_id INT,
    age INT NOT NULL,
    PRIMARY KEY (stud_id),
    FOREIGN KEY (project_id) REFERENCES Project(project_id) ON DELETE CASCADE,
    FOREIGN KEY (advisor_id) REFERENCES Advisor(advisor_id) ON DELETE CASCADE
);"
project_tbl_query = "CREATE TABLE Project (
    project_id INT AUTO_INCREMENT,
    title VARCHAR(50),
    PRIMARY KEY (project_id)
);"
advisor_tbl_query <- "CREATE TABLE Advisor (
    advisor_id INT AUTO_INCREMENT,
    name VARCHAR(20),
    project_id INT NOT NULL,
    PRIMARY KEY (advisor_id),
    FOREIGN KEY (project_id) REFERENCES Project(project_id) ON DELETE CASCADE
);"
dbSendQuery(mydb, project_tbl_query)
dbSendQuery(mydb, advisor_tbl_query)
dbSendQuery(mydb, student_tbl_query)

# CRUD operations
# Insert
dbSendQuery(mydb, "INSERT INTO Project(title) VALUES('hospital mngt system');")
dbSendQuery(mydb, "INSERT INTO Project(title) VALUES('online voting system');")
dbSendQuery(mydb, "INSERT INTO Project(title) VALUES('digital traffic control');")
dbSendQuery(mydb, "INSERT INTO Project(title) VALUES('scheduling system');")
dbSendQuery(mydb, "INSERT INTO Project(title) VALUES('face recognition system');")
dbSendQuery(mydb, "INSERT INTO Project(title) VALUES('clearance system');")

dbSendQuery(mydb, "INSERT INTO Advisor(name, project_id) VALUES('Fitsum', '5');")
dbSendQuery(mydb, "INSERT INTO Advisor(name, project_id) VALUES('Natenael', '2');")
dbSendQuery(mydb, "INSERT INTO Advisor(name, project_id) VALUES('Alazar', '4');")
dbSendQuery(mydb, "INSERT INTO Advisor(name, project_id) VALUES('Tigabu', '3');")
dbSendQuery(mydb, "INSERT INTO Advisor(name, project_id) VALUES('Daniel', '5');")
dbSendQuery(mydb, "INSERT INTO Advisor(name, project_id) VALUES('Amanuel', '6');")

dbSendQuery(mydb, "INSERT INTO Student(name,project_id,advisor_id, age) VALUES('Getasew', 3, 2, 24);")
dbSendQuery(mydb, "INSERT INTO Student(name,project_id, advisor_id, age) VALUES('Daniel',4, 6, 19);")
dbSendQuery(mydb, "INSERT INTO Student(name,project_id,advisor_id, age) VALUES('Tsegaye', 3, 2, 22);")
dbSendQuery(mydb, "INSERT INTO Student(name,project_id, advisor_id, age) VALUES('Melesew',3, 2, 24);")
dbSendQuery(mydb, "INSERT INTO Student(name,project_id,advisor_id, age) VALUES('Anteneh', 4, 6, 21);")
dbSendQuery(mydb, "INSERT INTO Student(name,project_id, advisor_id, age) VALUES('Solomon',1, 4, 27);")
dbSendQuery(mydb, "INSERT INTO Student(name,project_id, advisor_id, age) VALUES('Haylemikael',1, 5, 17);")
dbSendQuery(mydb, "INSERT INTO Student(name,project_id, advisor_id, age) VALUES('Selamawit',2, 4, 20);")

# read operation
tryl = fetch(dbSendQuery(mydb, "SELECT * FROM Student"))
tryl

#Update
dbSendQuery(mydb, "UPDATE Student SET name='Samuel' WHERE advisor_id = 4;")
tryl = fetch(dbSendQuery(mydb, "SELECT * FROM Student"))
tryl

#Delete
dbSendQuery(mydb, "DELETE FROM Student WHERE advisor_id =4;")
tryl = fetch(dbSendQuery(mydb, "SELECT * FROM Student"))
tryl

# Read rows from database and add another column to it by performing some vector operations.
data.frame <- as.data.frame(tryl)
data.frame

#data.frame$Examinor <- c('alazar','tigabu')
data.frame$young_age <- ifelse(data.frame$age <= 20, "under", data.frame$age)

#View the result frame
data.frame

#Write to database
dbWriteTable(mydb, value = data.frame, name = "Young_Students", append = TRUE )

#Show last and or first fiew lines and the summary of the data

# Last two rows
tail<-tail(tryl,2)
tail

# First two rows
head1<-head(tryl,2)
head1

summary<-summary(tryl)
summary
