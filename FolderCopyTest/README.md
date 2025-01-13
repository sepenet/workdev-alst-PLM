# Catia folder copy test

open powershell as administrator and execute the following command line

```powershell
get-date -format "dd-MMM-HH-mm-ss"
copy-item -path "c:\CATIA_V6_21X_FD14" -destination "CATIA_V6_21X_FD14-new" -Recurse
get-date -format "dd-MMM-HH-mm-ss"

```

to start PLM https://preprod-plm4a-3ddashboard.alstom.com/AddressBook/PLM_4A_Address_Book.htm
