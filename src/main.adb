with Text_IO; use Text_IO;
with stosPackage; use stosPackage;
with Semafory; use Semafory;
with Ada.Calendar;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;


procedure Main is
   pojemnosc:Integer:=50;          --deklaracja zmiennej przechowujacej pojemnosc buforow
   task type Serwer(id: Integer);  --deklaracja zadania serwer z parametrem
   task type Klient(id:Integer);   --deklaracja zadania klient z parametrem


   Buff:Access stosStruktura;  -- deklaracja pointera dla bufora
   Sem:Access Semafor_Binarny; -- deklaracja piontera dla semafora glownego
   SemE:Access Semafor_Binarny; -- deklaracja piontera dla semafora Pusty
   SemF:Access Semafor_Binarny; -- deklaracja piontera dla semafora Pelnego

   B11:Aliased stosStruktura(pojemnosc);
   Sem11:Aliased Semafor_Binarny(1);
   Sem11Empty:Aliased Semafor_binarny(1);
   Sem11Full:Aliased Semafor_binarny(1);

   B12:Aliased stosStruktura(pojemnosc);
   Sem12:Aliased Semafor_Binarny(1);
   Sem12Empty:Aliased Semafor_binarny(1);
   Sem12Full:Aliased Semafor_binarny(1);

   B13:Aliased stosStruktura(pojemnosc);
   Sem13:Aliased Semafor_Binarny(1);
   Sem13Empty:Aliased Semafor_binarny(1);
   Sem13Full:Aliased Semafor_binarny(1);

   B14:Aliased stosStruktura(pojemnosc);
   Sem14:Aliased Semafor_Binarny(1);
   Sem14Empty:Aliased Semafor_binarny(1);
   Sem14Full:Aliased Semafor_binarny(1);

   B15:Aliased stosStruktura(pojemnosc);
   Sem15:Aliased Semafor_Binarny(1);
   Sem15Empty:Aliased Semafor_binarny(1);
   Sem15Full:Aliased Semafor_binarny(1);

   --  B21:Aliased stosStruktura(pojemnosc);
   --  Sem21:Aliased Semafor_Binarny(1);
   --  Sem21Empty:Aliased Semafor_binarny(1);
   --  Sem21Full:Aliased Semafor_binarny(1);
   --
   --  B22:Aliased stosStruktura(pojemnosc);
   --  Sem22:Aliased Semafor_Binarny(1);
   --  Sem22Empty:Aliased Semafor_binarny(1);
   --  Sem22Full:Aliased Semafor_binarny(1);
   --
   --  B23:Aliased stosStruktura(pojemnosc);
   --  Sem23:Aliased Semafor_Binarny(1);
   --  Sem23Empty:Aliased Semafor_binarny(1);
   --  Sem23Full:Aliased Semafor_binarny(1);
   --
   --  B24:Aliased stosStruktura(pojemnosc);
   --  Sem24:Aliased Semafor_Binarny(1);
   --  Sem24Empty:Aliased Semafor_binarny(1);
   --  Sem24Full:Aliased Semafor_binarny(1);

   -- probability of send to or receive from buffer
   T: array (1..9, 1..9) of Float := ((0.1,0.15,0.2,0.25,0.3,0.0,0.0,0.0,0.0),
                                      (0.01,0.09,0.15,0.25,0.5,0.0,0.0,0.0,0.0),
                                      (0.05,0.15,0.2,0.25,0.35,0.0,0.0,0.0,0.0),
                                      (0.02,0.22,0.28,0.3,0.18,0.1,0.2,0.3,0.4),
                                      (0.1,0.15,0.2,0.25,0.3,0.09,0.19,0.29,0.43),
                                      (0.01,0.09,0.15,0.25,0.5,0.11,0.18,0.2,0.51),
                                      (0.08,0.22,0.31,0.39,0.0,0.0,0.0,0.0,0.0),
                                      (0.1,0.2,0.3,0.4,0.0,0.0,0.0,0.0,0.0),
                                      (0.09,0.19,0.29,0.43,0.0,0.0,0.0,0.0,0.0));

   task body Serwer is
      idw, z, x:Integer;
      p:Float;  -- zmienna przechowujaca prawdopodobienstwo
      G:Generator;
      time:Float;
      --y:Short_Float;

   begin
      idw:=id;
      Reset(G,idw);
      loop
         x:=Integer(Random(G)*100.0);
         --Put_Line("<<--- Serwer "&Integer'Image(idw)&" wygenerowal liczbe: "&Integer'Image(x));
         Time:=Random(G) * 1.0;
         Delay(Duration(Time));
         p:=Random(G);

         if idw = 1 then
            if p <= T(1,1) then
               Buff:=B11'Access;
               Sem:=Sem11'Access;
               SemE:=Sem11Empty'Access;
               SemF:=Sem11Full'Access;
               z:=1;

            elsif p<=(T(1,1) + T(1,2)) then
               Buff:=B12'Access;
               Sem:=Sem12'Access;
               SemE:=Sem12Empty'Access;
               SemF:=Sem12Full'Access;
               z:=2;

            elsif p<=(T(1,1) + T(1,2) + T(1,3)) then
               Buff:=B13'Access;
               Sem:=Sem13'Access;
               SemE:=Sem13Empty'Access;
               SemF:=Sem13Full'Access;
               z:=3;

            elsif p<=(T(1,1) + T(1,2) + T(1,3) + T(1,4)) then
               Buff:=B14'Access;
               Sem:=Sem14'Access;
               SemE:=Sem14Empty'Access;
               SemF:=Sem14Full'Access;
               z:=4;

            else
               Buff:=B15'Access;
               Sem:=Sem15'Access;
               SemE:=Sem15Empty'Access;
               SemF:=Sem15Full'Access;
               z:=5;
            end if;

         elsif idw = 2 then
            if p <= T(2,1) then
               Buff:=B11'Access;
               Sem:=Sem11'Access;
               SemE:=Sem11Empty'Access;
               SemF:=Sem11Full'Access;
               z:=1;

            elsif p<=(T(2,1) + T(2,2)) then
               Buff:=B12'Access;
               Sem:=Sem12'Access;
               SemE:=Sem12Empty'Access;
               SemF:=Sem12Full'Access;
               z:=2;

            elsif p<=(T(2,1) + T(2,2) + T(2,3)) then
               Buff:=B13'Access;
               Sem:=Sem13'Access;
               SemE:=Sem13Empty'Access;
               SemF:=Sem13Full'Access;
               z:=3;

            elsif p<=(T(2,1) + T(2,2) + T(2,3) + T(2,4)) then
               Buff:=B14'Access;
               Sem:=Sem14'Access;
               SemE:=Sem14Empty'Access;
               SemF:=Sem14Full'Access;
               z:=4;

            else
               Buff:=B15'Access;
               Sem:=Sem15'Access;
               SemE:=Sem15Empty'Access;
               SemF:=Sem15Full'Access;
               z:=5;
            end if;
      elsif idw = 3 then
            if p <= T(3,1) then
               Buff:=B11'Access;
               Sem:=Sem11'Access;
               SemE:=Sem11Empty'Access;
               SemF:=Sem11Full'Access;
               z:=1;

            elsif p<=(T(3,1) + T(3,2)) then
               Buff:=B12'Access;
               Sem:=Sem12'Access;
               SemE:=Sem12Empty'Access;
               SemF:=Sem12Full'Access;
               z:=2;

            elsif p<=(T(3,1) + T(3,2) + T(3,3)) then
               Buff:=B13'Access;
               Sem:=Sem13'Access;
               SemE:=Sem13Empty'Access;
               SemF:=Sem13Full'Access;
               z:=3;

            elsif p<=(T(3,1) + T(3,2) + T(3,3) + T(3,4)) then
               Buff:=B14'Access;
               Sem:=Sem14'Access;
               SemE:=Sem14Empty'Access;
               SemF:=Sem14Full'Access;
               z:=4;

            else
               Buff:=B15'Access;
               Sem:=Sem15'Access;
               SemE:=Sem15Empty'Access;
               SemF:=Sem15Full'Access;
               z:=5;
            end if;

      end if;

      --Put_line("<<-->> Serwer"&integer'image(idw)& " wybral bufor " &integer'image(z));

      if pelny(Buff) then
              Put_line("<<--x Serwer "&integer'image(idw)&", zawieszony na semaforze bufora ["&integer'image(z)&"]");
              SemF.PB;
            else
              Sem.PB;
              wstaw(Buff,x);
              Put_line("<<--- Serwer "&integer'image(idw)&" wstawil do bufora liczbe "&Integer'image(x)&", odwiesza semafor w buforze ["&integer'image(z)&"]");
              Sem.VB;
              SemE.VB;
            end if;
   Reset(G);
   end loop;
end Serwer;

task body Klient is
idw, z:Integer;
x:Integer;
p:Float;
G:Generator;
time:Float;
begin
  idw:=id;
  Reset(G,idw);
  loop
    Time:=Random(G) * 5.0;
    Delay(Duration(Time));
    p:=Random(G);
    if idw = 1 then
          if p <= T(7,1) then
               Buff:=B11'Access;
               Sem:=Sem11'Access;
               SemE:=Sem11Empty'Access;
               SemF:=Sem11Full'Access;
               z:=1;

            elsif p<=(T(7,1) + T(7,2)) then
               Buff:=B12'Access;
               Sem:=Sem12'Access;
               SemE:=Sem12Empty'Access;
               SemF:=Sem12Full'Access;
               z:=2;

            elsif p<=(T(7,1) + T(7,2) + T(7,3)) then
               Buff:=B13'Access;
               Sem:=Sem13'Access;
               SemE:=Sem13Empty'Access;
               SemF:=Sem13Full'Access;
               z:=3;

            elsif p<=(T(7,1) + T(7,2) + T(7,3) + T(7,4)) then
               Buff:=B14'Access;
               Sem:=Sem14'Access;
               SemE:=Sem14Empty'Access;
               SemF:=Sem14Full'Access;
               z:=4;

            else
               Buff:=B15'Access;
               Sem:=Sem15'Access;
               SemE:=Sem15Empty'Access;
               SemF:=Sem15Full'Access;
               z:=5;
            end if;

         elsif idw = 2 then
            if p <= T(8,1) then
               Buff:=B11'Access;
               Sem:=Sem11'Access;
               SemE:=Sem11Empty'Access;
               SemF:=Sem11Full'Access;
               z:=1;

            elsif p<=(T(8,1) + T(8,2)) then
               Buff:=B12'Access;
               Sem:=Sem12'Access;
               SemE:=Sem12Empty'Access;
               SemF:=Sem12Full'Access;
               z:=2;

            elsif p<=(T(8,1) + T(8,2) + T(8,3)) then
               Buff:=B13'Access;
               Sem:=Sem13'Access;
               SemE:=Sem13Empty'Access;
               SemF:=Sem13Full'Access;
               z:=3;

            elsif p<=(T(8,1) + T(8,2) + T(8,3) + T(8,4)) then
               Buff:=B14'Access;
               Sem:=Sem14'Access;
               SemE:=Sem14Empty'Access;
               SemF:=Sem14Full'Access;
               z:=4;

            else
               Buff:=B15'Access;
               Sem:=Sem15'Access;
               SemE:=Sem15Empty'Access;
               SemF:=Sem15Full'Access;
               z:=5;
            end if;

         elsif idw = 3 then
            if p <= T(9,1) then
               Buff:=B11'Access;
               Sem:=Sem11'Access;
               SemE:=Sem11Empty'Access;
               SemF:=Sem11Full'Access;
               z:=1;

            elsif p<=(T(9,1) + T(9,2)) then
               Buff:=B12'Access;
               Sem:=Sem12'Access;
               SemE:=Sem12Empty'Access;
               SemF:=Sem12Full'Access;
               z:=2;

            elsif p<=(T(9,1) + T(9,2) + T(9,3)) then
               Buff:=B13'Access;
               Sem:=Sem13'Access;
               SemE:=Sem13Empty'Access;
               SemF:=Sem13Full'Access;
               z:=3;

            elsif p<=(T(9,1) + T(9,2) + T(9,3) + T(9,4)) then
               Buff:=B14'Access;
               Sem:=Sem14'Access;
               SemE:=Sem14Empty'Access;
               SemF:=Sem14Full'Access;
               z:=4;

            else
               Buff:=B15'Access;
               Sem:=Sem15'Access;
               SemE:=Sem15Empty'Access;
               SemF:=Sem15Full'Access;
               z:=5;
            end if;
    end if;

    Put_line("--->> Klient "&integer'image(idw)&" wybral bufor ["&integer'image(z)&"]");

        if Pusty(Buff) then
          Put_line("--->> Klient "&integer'image(idw)&" zawieszony na semaforze bufora ["&integer'image(z)&"]");
          SemE.PB;
        else
          Sem.PB;
          pobierz(Buff,x);
          Put_line("--->> Klient "&integer'image(idw)&" pobral do bufora liczbe "&Integer'image(x)&", odwiesza semafor w buforze ["&integer'image(z)&"]");
          Sem.VB;
          SemF.VB;
        end if;
    Reset(G);
    end loop;
end Klient;

S1:Serwer(id=>1);
S2:Serwer(id=>2);
S3:Serwer(id=>3);
K1:Klient(id=>1);
K2:Klient(id=>2);
K3:Klient(id=>3);
begin
   null;
end Main;
