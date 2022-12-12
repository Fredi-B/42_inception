-- FLUSH PRIVILIGES  maybe not needed (see https://stackoverflow.com/questions/36463966/mysql-when-is-flush-privileges-in-mysql-really-needed)
CREATE DATABASE wordpress;
CREATE USER 'fbechtol'@'%' IDENTIFIED BY '123';
GRANT ALL PRIVILEGES ON wordpress.* TO 'fbechtol'@'%';
FLUSH PRIVILEGES;

-- ALTER USER        give root a password. (root is the admin)
ALTER USER 'root'@'localhost' IDENTIFIED BY '123';
