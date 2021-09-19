CREATE TABLE [dbo].Transfer(
TransferId INT PRIMARY KEY IDENTITY(1,1), 
Date DATE,
Category VARCHAR(100), 
Name VARCHAR (100), 
VALUE decimal(7,2))