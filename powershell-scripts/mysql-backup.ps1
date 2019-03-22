.\mysqldump.exe --routines -u... -p... db1 | .\mysql.exe -u... -p... -Ddb2 ;
.\mysql.exe -u... -p... -Ddb1 -e 'show tables;' | foreach { 
    $command = '.\mysqldump.exe -u... -p... --max_allowed_packet=512M db1 '+$_+' | .\mysql.exe -u... -p... -Ddb2 ;'
    iex $command
}