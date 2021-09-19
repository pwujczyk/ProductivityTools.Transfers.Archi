<!--Category:Powershell--> 
 <p align="right">
    <a href="https://www.powershellgallery.com/packages/ProductivityTools.Transfers/"><img src="Images/Header/Powershell_border_40px.png" /></a>
    <a href="http://productivitytools.tech/transfers/"><img src="Images/Header/ProductivityTools_green_40px_2.png" /><a> 
    <a href="https://github.com/pwujczyk/ProductivityTools.Transfers/"><img src="Images/Header/Github_border_40px.png" /></a>
</p>
<p align="center">
    <a href="http://productivitytools.tech/">
        <img src="Images/Header/LogoTitle_green_500px.png" />
    </a>
</p>


#   Transfers

Project saves predefined transfers to the database.

<!--more-->

Following documentation is not enough for running application.

- **Print-AllTransfers** - Displays all transfers it has switch $SaveToDatabase. Which additionally do the same as Save-AllTransfersToDB
- **Save-AllTransfersToDB** - Saves all transfers to Database.

Module depends on the MasterConfiguration 3 keys are neded:

```json
"TransfersSqlInstance":".\\sql2019",
"TransfersDatabse":"Transfers",
"TransfersCategories":"Proxy,Accout"
```

In table unique constraint cosists of 
- Date
- Category
- Name

Before inserting data into the database, first rows according to unique constraint are removed.
