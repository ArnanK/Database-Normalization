Queens College Course Catalog Database
Overview
Welcome to the Queens College Course Catalog Database project! This repository contains the codebase for a database normalization project that transforms the raw data from the Queens College course catalog into a structured database. The database is designed using the principles of normalization, specifically achieving Third Normal Form (3NF). It includes various tables such as professors, departments, classes, courses, and more. Additionally, the database incorporates bridge tables, foreign keys (FK), and primary keys (PK) to establish relationships between different entities. The technology used for this project is T-SQL in Microsoft SQL Server.

Project Description
The Queens College Course Catalog Database project aims to organize the raw data from the Queens College course catalog into a well-structured database. By normalizing the database to 3NF, redundant data is minimized, and data integrity is improved. The database schema includes multiple tables representing different entities such as professors, departments, classes, and courses. Relationships between these entities are established using foreign keys, ensuring data consistency and integrity.

Technologies Used
T-SQL (Transact-SQL) in Microsoft SQL Server: The primary technology used for developing the database schema, stored procedures, and user-defined data types.
Docker: Used for containerizing the application environment, providing consistency across different development and deployment environments.
Azure: Utilized for hosting the Microsoft SQL Server database, enabling scalability and accessibility.
Data Visualizations: Utilized tools within Microsoft SQL Server Management Studio (SSMS) for data visualization and analysis.
Database Structure
The database is designed to be in Third Normal Form (3NF), adhering to the following principles:

Each table represents a single subject area or entity.
Data redundancy is minimized by eliminating repeating groups and storing data in separate tables.
Relationships between entities are established using foreign keys, ensuring referential integrity.
Installation
To set up the Queens College Course Catalog Database project, follow these steps:

Clone this repository to your local machine:

bash
Copy code
git clone https://github.com/your-username/queens-college-catalog-db.git
[Add any specific installation instructions or prerequisites needed to run the project, such as setting up the development environment, configuring Docker, or connecting to Azure.]

Usage

Contributing
Contributions to the Queens College Course Catalog Database project are welcome! If you'd like to contribute, please follow these guidelines:

Fork the repository and create your branch from main.
Make your changes, ensuring they adhere to the project's coding conventions and standards.
Test your changes thoroughly.
Open a pull request, describing the changes you've made and any relevant context.
We appreciate your contributions to improving the Queens College Course Catalog Database project!
