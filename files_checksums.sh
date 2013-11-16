#! /bin/bash

sqlite3 files_checksums.sqlite3 <<EOF
.mode column
.headers on
.print
.print --> All Files
select * from files;
.print
.print --> All Checksums
select * from checksums;
EOF

sqlite3 files_checksums.sqlite3 <<EOF
.print
.print --> Get content attribute foo for every file 
.mode column
.headers on
.width 4 20 20
select f.id,f.file_path,x.foo
from files as f 
	inner join checksums as x on f.checksum=x.checksum;
EOF

sqlite3 files_checksums.sqlite3 <<EOF
.print
.print --> Get one file per checksum where foo IS NULL
.mode column
.headers on
.width 4 8 20 4 20
select a.id,a.checksum,a.foo,b.id,b.file_path 
from checksums as a 
	inner join files as b on a.checksum=b.checksum 
where a.foo IS NULL 
group by a.checksum;
EOF
