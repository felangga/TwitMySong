<php
  
	$db = mysql_connect ("localhost","root","")
	or die ("Gagal koneksi ke server, coba lagi");
	
	mysql_select_db("analisaLirik")
	or die ("Koneksi Gagal, database gagal dibuka");

?>