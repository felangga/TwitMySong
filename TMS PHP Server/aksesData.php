<?php
  	// fcomputer 10.4.2013
  	// 22.5.2013 -- Parsing LyricsWIKIA

	$db = mysql_connect ("mysql.3owl.com","u602374158_tms","juni1993")
	or die ("Gagal koneksi ke server, coba lagi");
	
	mysql_select_db("u602374158_tms")
	or die ("Koneksi Gagal, database gagal dibuka");

	$p				= $_GET ['p'];     // perintah
	$artis			= $_GET ['artis']; // input artis
	$lagu			= $_GET ['lagu'];  // input lagu
	$lagu			= str_replace('.', '', $lagu);
	$artis  		= str_replace('.', '', $artis);
	$artis      	= strtolower($artis);
	$lagu	    	= strtolower($lagu);
	$input 			= "Not found";
	$sebelum		= "Lyrics not found.";
	
	
	if (!file_exists("Lirik/$artis/$lagu.txt")) {

		// parsing dari azlyrics.com
		$get_Lagu   = str_replace(' ', '', $lagu);
		$get_Artis  = str_replace(' ', '', $artis);

		$alamat		= "http://www.azlyrics.com/lyrics/$get_Artis/$get_Lagu.html";
		$hasil		= file_get_contents($alamat);
		if (strpos($hasil, "lyrics that you didn't find here. ") <= 0) {
			// pemotongan 
			$awal		= strpos($hasil, '<!-- start of lyrics -->')+strlen('<!-- start of lyrics -->') + 2;
			$akhir 		= strpos($hasil, '<!-- end of lyrics -->');
			$parsing 	= substr($hasil, $awal, $akhir - $awal);
			$sebelum	= str_replace("<br />", " ", $parsing);
			$input 		= str_replace("<br />", '%', $parsing);	
			//echo $input;
			
		} 

		if ($input == "Not found") {
			// parsing dari lyricsreg.com
			$alamat		= "http://www.lyricsreg.com/lyrics/$artis/$lagu";
			$alamat		= str_replace (' ', '+', $alamat);
			$hasil		= file_get_contents($alamat);
			if (strpos($hasil, "Page not Found") <= 0) {
				// pemotongan 
			//	$awal		= strpos($hasil, 'border="0" /></a><br /><br />')+strlen('border="0" /></a><br /><br />
		    //');
			//	$akhir 		= strpos($hasil, '<br />


		      //                      <a href="http://www.ring');

				$awal		= strpos($hasil, 'border="0" /></a><br /><br />
    ')+strlen('border="0" /></a><br /><br />
    ');
				$akhir		= strpos($hasil, "    <br />


                            <a href");
				$parsing 	= substr($hasil, $awal, $akhir - $awal);
				$sebelum	= str_replace("<br />", " ", $parsing);
				$input 		= str_replace("<br />", '%', $parsing);	
				
			} 
		}
	

		if ($input == "Not found") {
			// parsing dari lyrics.wikia.com
			$alamat		= "http://lyrics.wikia.com/api.php?func=getSong&fmt=json&artist=$artis&song=$lagu";		// web servis lyrics
			$alamat 	= str_replace(' ', '%20', $alamat);
			$page 		= file_get_contents($alamat);
			$alamat		= substr($page, strpos($page, "'url'")+7, strpos($page, "}")-(strpos($page,"'url'")+7)-2)."?action=edit";
			$page       = file_get_contents($alamat);
			if (strpos($page, "This page needs content") <= 0) {
				$input 		= substr($page, strpos($page, "lyrics>")+8, (strpos($page, "&lt;/lyrics>") - (strpos($page,"lyrics>")+8)));
				$sebelum	= str_replace("\\n", ' ', $input);		
				$input 		= str_replace("\n", '%', $input);			
			}
			
		}


		/*if ($input == "Not found") {
			$jajal = file_get_contents("http://lyrics.wikia.com/".$get_Artis.":".$get_Lagu."?action=edit");
			echo "http://lyrics.wikia.com/".$get_Artis.":".$get_Lagu."?action=edit";
			$jajal = substr($jajal, strpos($jajal, "&lt;lyrics>")+12, (strpos($jajal, "&lt;/lyrics>")-strpos($jajal, "&lt;lyrics>"))-12);
			echo $jajal;
		}*/
	} else {

		$input   = file_get_contents("Lirik/$artis/$lagu.txt", "r");
		$sebelum = $input;
		$input 	 = str_replace('\n', '%', $input);	
		
	}
	//$jajal = file_get_contents("http://lyrics.wikia.com/".$get_Artis.":".$get_Lagu."?action=edit");
	//echo "http://lyrics.wikia.com/".$get_Artis.":".$get_Lagu."?action=edit";
	//jajal = substr($jajal, strpos($jajal, "&lt;lyrics>")+12, (strpos($jajal, "&lt;/lyrics>")-strpos($jajal, "&lt;lyrics>"))-12);
	

	$potong 	= explode ('%', $input);

	$bobotSenang 	= 0;
	$indexSenang 	= -1;
	$bobotSedih  	= 0;
	$indexSedih  	= -1;
	


	if (strpos($input, "Not found") !== false) {
		echo "Tidak Ketemu";
	} else if ($p == 'lirik') {
		echo $sebelum;
	} else if ($p == 'text') {
		
		// ulangi sebanyak potongan text
		for ($i = 0; $i <=count($potong)-2; $i++){ 
			$sql 	= "SELECT * from tblsenang";
			
			$hasil 	= mysql_query($sql) or die ("Error 1. Data query failed");
			$jml	= mysql_num_rows($hasil);
			$temp 	= 0;
			if (strlen($potong[$i]) > 5) {
				while ($data = mysql_fetch_array($hasil)) {
					
					//echo strpos($potong[$i], $data["Kata"]);
					if (strpos($potong[$i], $data["Kata"]) > 0)  {
						$kata = $data["Kata"];
						$ambilBobot = mysql_fetch_array(mysql_query ("SELECT * from tblsenang WHERE Kata = '$kata'"));
						
						$temp += $ambilBobot["Bobot"];
						
						if ($temp > $bobotSenang) {
							$indexSenang = $i;
							$bobotSenang = $temp;
						}

					}
				}					
			}
			//echo "<br />index : $indexSenang<br />";
		}

		for ($i = 0; $i <=count($potong)-2; $i++){ 
			$sql 	= "SELECT * from tblsedih";
			
			$hasil 	= mysql_query($sql) or die ("Error 1. Data query failed");
			$jml	= mysql_num_rows($hasil);
			$temp 	= 0;
			if (strlen($potong[$i]) > 5) {
				while ($data = mysql_fetch_array($hasil)) {
					
					//echo strpos($potong[$i], $data["Kata"]);
					if (strpos($potong[$i], $data["Kata"]) > 0)  {
						$kata = $data["Kata"];
						$ambilBobot = mysql_fetch_array(mysql_query ("SELECT * from tblsedih WHERE Kata = '$kata'"));
						
						$temp += $ambilBobot["Bobot"];
						
						if ($temp > $bobotSenang) {
							$indexSedih = $i;
							$bobotSedih = $temp;
						}

					}
				}
			}
			//echo "<br />index : $indexSedih<br />";
		}

		if ($indexSenang > $indexSedih) {
			if ($potong[$indexSenang][0] == "\n") $potong[$indexSenang] = substr($potong[$indexSenang], 1);
			$out 	= str_replace('\\', '', $potong[$indexSenang]);
			$out    = str_replace("\n", '', $out);	
			echo $out.".";
			
		} else if ($indexSedih > $indexSenang) {
			if ($potong[$indexSedih][0] == "\n") $potong[$indexSedih] = substr($potong[$indexSedih], 1);
			$out 	= str_replace('\\', '', $potong[$indexSedih]);
			$out    = str_replace("\n", '', $out);	
			echo $out."`";
			
		} else {			

			while ($temp == "" or $temp == " ") {

				$temp = $potong[rand(0, count($potong)-2)];				
			}
			
			if ($temp[0] == "\n") $temp = substr($temp, 1);
			$out 	= str_replace('\\', '', $temp);
			$out    = str_replace("\n", '', $out);	
			echo $out."'";
		}
		
	} 
	
?>