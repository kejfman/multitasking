package body stosPackage is 
 	procedure wstaw(s:Access stosStruktura; x:in Integer) is
	begin
		s.wsk:=s.wsk+1;
		s.St(s.wsk):=x;
	end wstaw;
	procedure pobierz(s:Access stosStruktura; x:out Integer) is
	begin
		x:=s.St(s.wsk);
		s.wsk:=s.wsk-1;
	end pobierz;
	function pelny(S:Access stosStruktura) return boolean is 
	begin
		return(s.wsk>(s.pojemnosc-1));
	end pelny;
	function Pusty(S:Access stosStruktura) return boolean is
	begin
		return(s.wsk<1);
	end Pusty;
end stosPackage;
