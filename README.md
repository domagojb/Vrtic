Vrtic
=====

Webaplikacija za vođenje vrtića.

TESTIRANJE/POKRETANJE
=====================

Za testiranje odnosno pokretanje aplikacije potreban je webserver apache tomcat. Preuzmite najnoviju verziju: http://tomcat.apache.org/

Uz to vam je potreban mysql server: http://dev.mysql.com/downloads/mysql/
Skinite si database i workbench za jednostavan rad. Za trenutne potrebe
napravite bazu koja se zove 'mysqldb', a user i pass su 'user' i 'passwd'. Port ak nije zadan mora biti 3306 (default od mysql).

Mysql server mora raditi da bi app radil. Kopirajte folder 'vrtic' koji se nalazi
u projektu od eclipsa pod Vrtic/web/ i prekopirajte ga tam gde ste skinuli apahce tomcat u folder 'webapps'. Sad odite u apache tomcat 'bin' direktorij i tam pokrenete (ovisno o OS-u) startup.sh ili startup. 

Otiđete na localhost:8080/IME_APLIKACIJE

IME_APLIKACIJE je ono kak se zove folder u 'webapps' folderu od tomcata.

Ak izostavite ime aplikacije otvoril se bude onaj koji se u tomcatu zove ROOT. Tak mozete odma probati jel vam tomcat radi.

Kad zavrsite pokrenite shutdown u 'bin' od tomcata da zaustavite server. Morate restartat server ak hocete novu verziju aplikacije pokrenut.
