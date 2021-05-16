package stosPackage is 
 	type stos is array(integer range<>)of Integer; 
	type stosStruktura(pojemnosc:Integer)is 
		record
			st:stos(1..pojemnosc);
			wsk:Integer:=0;
	    end record;
	 procedure wstaw(s: Access stosStruktura; x:in Integer);
	 procedure pobierz(s: Access stosStruktura; x:out Integer);
	 function pelny (S:Access stosStruktura) return boolean; 
	 function Pusty (S:Access stosStruktura) return boolean;
 end stosPackage; 
