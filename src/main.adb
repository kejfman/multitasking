with Text_IO; use Text_IO;
with stosPackage; use stosPackage;
with Semafory; use Semafory;
with Ada.Calendar;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;


procedure Main is
   pojemnosc:Integer:=10;          --deklaracja zmiennej przechowujacej pojemnosc buforow
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


   task body Serwer is
      idw, z, x:Integer;
      p:Float;  -- zmienna przechowujaca prawdopodobienstwo
      G:Generator;
      time:Float;
   begin
      idw:=id;
      Reset(G,idw);
      loop
         x:=Integer(Random(G)*100.0);
         Put_Line("Serwer "&Integer'Image(idw)&" wygenerowal liczbe: "&Integer'Image(x));
         Time:=Random(G) * 1.0;
         Delay(Duration(Time));

         p:=Random(G);
         if idw = 1 then
            if p < 0.15 then
               Buff:=B11'Access;
               Sem:=Sem11'Access;
               SemE:=Sem11Empty'Access;
               SemF:=Sem11Full'Access;
               z:=1;

            else
               Buff:=B12'Access;
               Sem:=Sem12'Access;
               SemE:=Sem12Empty'Access;
               SemF:=Sem12Full'Access;
               z:=2;

            end if;
         elsif idw = 2 then
            if p < 0.5 then
               Buff:=B11'Access;
               Sem:=Sem11'Access;
               SemE:=Sem11Empty'Access;
               SemF:=Sem11Full'Access;
               z:=1;

            else
               Buff:=B12'Access;
               Sem:=Sem12'Access;
               SemE:=Sem12Empty'Access;
               SemF:=Sem12Full'Access;
               z:=2;

            end if;
         end if;


         Put_line(" Serwer"&integer'image(idw)& " wybral bufor " &integer'image(z));

         if pelny(Buff) then
            Put_line("Serwer"&integer'image(idw)& " zawieszony na semaforze bufora ("&integer'image(z)&")");
            SemF.PB;
         else
            Sem.PB;
            wstaw(Buff,x);
            Put_line("Serwer"&integer'image(idw)&" wstawil do bufora liczbe "&Integer'image(x)&" odwiesza semafor w buforze - "&integer'image(z));
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

         --   x:=Random(G);
         -- Put_Line("Serwer "&Integer'Image(idw)&" wygenerowal liczbe: "&Float'Image(x));
         Time:=Random(G) * 1.0;
         Delay(Duration(Time));

         p:=Random(G);
         if idw = 1 then
            if p < 0.15 then
               Buff:=B11'Access;
               Sem:=Sem11'Access;
               SemE:=Sem11Empty'Access;
               SemF:=Sem11Full'Access;
               z:=1;

            else
               Buff:=B12'Access;
               Sem:=Sem12'Access;
               SemE:=Sem12Empty'Access;
               SemF:=Sem12Full'Access;
               z:=2;

            end if;
         elsif idw = 2 then
            if p < 0.5 then
               Buff:=B11'Access;
               Sem:=Sem11'Access;
               SemE:=Sem11Empty'Access;
               SemF:=Sem11Full'Access;
               z:=1;

            else
               Buff:=B12'Access;
               Sem:=Sem12'Access;
               SemE:=Sem12Empty'Access;
               SemF:=Sem12Full'Access;
               z:=2;

            end if;
         end if;


         Put_line(" Klient "&integer'image(idw)& " wybral bufor " &integer'image(z));



         if Pusty(Buff) then
            Put_line("Klient "&integer'image(idw)& " zawieszony na semaforze bufora ("&integer'image(z)&")");
            SemE.PB;
         else
            Sem.PB;
            pobierz(Buff,x);
            Put_line("Klient "&integer'image(idw)&" pobral do bufora liczbe "&Integer'image(x)&" odwiesza semafor w buforze - "&integer'image(z));
            Sem.VB;
            SemF.VB;
         end if;
         Reset(G);
      end loop;

   end Klient;

   S1:Serwer(id=>1);
   S2:Serwer(id=>2);
   K1:Klient(id=>1);
   K2:Klient(id=>2);
begin
   null;
end Main;
