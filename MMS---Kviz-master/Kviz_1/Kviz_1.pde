import java.util.ArrayList;
import java.util.List;

//lista pitanja
ArrayList<Pitanje> listaPitanja = new ArrayList();
ArrayList<Pitanje> listaTocnihPitanja = new ArrayList();
int indeksPitanja = 0;
  int tocnoOdg;
int h =0;
ArrayList<Pitanje> pomocnaLista = new ArrayList();

//status programa, opcije:
final int uTijeku=0;
final int kraj=1;
final int odgovorenoPitanje=2;
final int pregledRezultata=3;
final int unosRezultata=4;
final int spremanjeRezultata=5;
//trenutni status označvam varijablom status
int status = uTijeku; 

String ime = "";

int najmanjiRez = 0;
//za gumbe
int rectX1, rectY1;
int rectX2, rectY2;
int rectX3, rectY3;
int rectX4, rectY4;

boolean rectOver1 = false;
boolean rectOver2 = false;
boolean rectOver3 = false;
boolean rectOver4 = false;

int vrijeme;
int cekaj = 1500;
boolean otkucaj = false;
//sva pitanja spremim u polje
 String[] poljePitanja = {"Kada počinje godišnje doba zima?", "21.12.", "21.3.","21.6.","23.9.", "Koliko stranica ima geometrijski lik pravokutnik?","2","3","4","5",
                           "Koji je glavni grad Hrvatske?", "Split", "Osijek", "Zadar", "Zagreb", "Kako se zove naše lijepo plavo more?", "Jonsko", "Talijansko", "Baltičko", "Jadransko",
                           "Čudnovate zgode šegrta hlapića napisao/napisala je:", "August Šenoa","Ivana Brlić-Mažuranić", "Dobriša Cesarić", "Marko Marulić",
                           "Grad ne ušću rijeke Cetine je:", "Omiš","Split", "Šibenik","Makarska",
                           "Navijači Hajduka nazivaju se: ", "Bad Blude Boysi", "Kohorta",  "Torcida", "Funcuti",
                           "Sport koji se igra na ledu nazivamo:", "Nogomoet", "Košarka", "Plivanje", "Hokej",
                           "Za koju životinju kažemo da je čovjekov vjerni prijatelj?", "Krokodil","Pas","Lav","Zlatna ribica",
                           "Izbaci uljeza! Što od navedenog nije padalina?", "Sijeg", "Kiša", "Mraz", "Sunce",
                           "Koje navedeno voće NE raste na stablu: ", "Lubenica", "Kruška","Jabuka", "Breskva",
                           "Grad u Istri je: ", "Dubrovnik", "Pula","Osijek","Rab",
                           "Koliko 1 sat ima minuta?","30","40","50","60",
                           "U jednadzbi 2x=16, x iznosi:", "4","6","8","10",
                           "Prijevod za 'Good morning' glasi...", "Dobro jutro!", "Dobar dan.", "Dobra večer.", "Laku noć...",
                           "Koja navedena životinja živi u moru:", "žaba", "dupin","ptica","mrav",
                           "Prve piramide izgrađe su u:", "Irskoj","Španjolskoj", "Egiptu", "Kini", 
                           "Što od naveenog nije marka automobila: ", "BMW", "Nokia", "Audi", "Mazda",
                           "Geometrijski lik je trokut a njemu slično geometrijsko tijelo je...", "Kocka","Valjak","Kvadar","Piramida",
                           "Izbaci uljeza među nebeskim tijelima!", "Zvijezda", "Oblak", "Sunce", "Mjesec",
                           "Što se nalazi na slici?", "Police", "Ribe", "Navijačice", "Borovnice",
                           "Što prikazuje ova fotografija?", "Mačku", "Psa", "Guštera", "Ljudsko biće",
                           "Koji je planet na ovoj slici?", "Jupiter", "Merkur", "Mars", "Zemlja"
                          };
  int[] tocniOdgovori={1,3,4,4,2,1,3,4,2,4,1,2,4,3,1,2,3,2,4,2,3,1,4};

void setup(){
  size(800,400);
  vrijeme = millis();
  tocnoOdg=0;

  int i2=0;
    for (int i=0; i<poljePitanja.length; i+=5)
    {
      Pitanje trenutnoPitanje = new Pitanje(poljePitanja[i], poljePitanja[i+1],poljePitanja[i+2], poljePitanja[i+3],poljePitanja[i+4], tocniOdgovori[i2], 30, 30);
      pomocnaLista.add(trenutnoPitanje);
      i2++;
    }
   //za shuffle arrayliste
   // Collections.shuffle(listaPitanja);
   
   while(listaPitanja.size()< 10)
   {
     int indeks = (int)random(pomocnaLista.size());
     listaPitanja.add(pomocnaLista.get(indeks));
     pomocnaLista.remove(indeks);
   }
    
    
}


void draw() {
  background(220);
  int brojTocnihPitanja = listaTocnihPitanja.size();
   int ukupnoPitanja= listaPitanja.size();
   
   
 
  
  switch(status) {
    case uTijeku:
      update(mouseX, mouseY);
      int redniBrojPitanja = indeksPitanja+1; 
      text("Nalazite se na pitanju : " + redniBrojPitanja + "/" + ukupnoPitanja , 30, 180);
      listaPitanja.get(indeksPitanja).display();
      break;
    case odgovorenoPitanje:
      
      //ako je tocno ----- inače ----
      if(listaPitanja.get(indeksPitanja).check(key))
      {
       fill(39,185,208);
       textSize(16);
       listaTocnihPitanja.add(listaPitanja.get(indeksPitanja));
       text("Točan odgovor", 100,50);
      h=1;
      }
      else
      {
        h=0;
        fill(39,185,208);
        textSize(16);
        text("Netočan odgovor", 100,50);
      }
      if(millis()-vrijeme >= cekaj)
      {
        otkucaj = true;
        status = uTijeku;
        indeksPitanja++;
        vrijeme = millis();
        if(h==1) tocnoOdg++;
      }
      otkucaj = false;
      if(indeksPitanja>listaPitanja.size()-1)
      {
        status = kraj;
      }
       break;
    case kraj:
   
      fill(11,138,6);
      textSize(18);
      text("Kviz je završio.Vaš rezultat je "+tocnoOdg+"/"+ukupnoPitanja+".", 100, 100);
      text("Kliknite R ili desnu tipku miša za ponovo igranje",100,150);
      text("Kliknite U za pregled najboljih rezultata",100,180);
      break;
    
    case pregledRezultata:
         String[] lines = loadStrings("list.txt");
         String [] nova = {};
         for (int i = 0 ; i < lines.length; i++) 
         {
           nova = append(nova, lines[i]);
         }
         
        fill(11,138,6);
        textSize(18);
        text("Top rezultati:", 50, 100);
        for(int i = 0; i < nova.length; ++i)
        text(nova[i], 100, 120 + i*20);
        
        String najmanjiRezStr = nova[2].substring(nova[2].indexOf(" ")+1);
         najmanjiRez = Integer.parseInt(najmanjiRezStr);
        
        if(tocnoOdg > najmanjiRez)
        {
          text("Kliknite Q ako želite unijeti svoj rezultat", 100, 250);
        }
        
        break;
     
     case unosRezultata:
        fill(11,138,6);
        textSize(18);
        text("Unesi ime:", 100, 100);
        
        break;
     
     case spremanjeRezultata:
         String[] linije = loadStrings("list.txt");
         String [] novaLista = {};
         for (int i = 0 ; i < linije.length; i++) 
         {
           novaLista = append(novaLista, linije[i]);
         }
         
         String rez1s = novaLista[0].substring(novaLista[0].indexOf(" ")+1);
         String rez2s = novaLista[1].substring(novaLista[1].indexOf(" ")+1);
         //String rez3s = novaLista[2].substring(novaLista[2].indexOf(" ")+1);
         // treci najbolji nit ne trebamo jer nebi mogli nit doć do ovog inače(nema pritiska Q u situaciji kada bi se trebao unijeti novi rezultat
         
         int rez1 = Integer.parseInt(rez1s);
         int rez2 = Integer.parseInt(rez2s);
         //int rez3 = Integer.parseInt(rez3s);
         
         String s1, s2, s3;
         if(tocnoOdg >= rez1)
         {
            s1 = ime + " " + tocnoOdg;
            s2 = novaLista[0];
            s3 = novaLista[1];
         }
         
         else if(tocnoOdg >= rez2)
         {
            s1 = novaLista[0];
            s2 = ime + " " + tocnoOdg;         
            s3 = novaLista[1];
           
         }
         
         else
         {
            s1 = novaLista[0];
            s2 = novaLista[1];
            s3 = ime + " " + tocnoOdg;         
           
         }
         
         String[] spremnaLista = {};
         spremnaLista = append(spremnaLista, s1);
         spremnaLista = append(spremnaLista, s2);
         spremnaLista = append(spremnaLista, s3);
         
         
        fill(11,138,6);
        textSize(18);
        text("Top rezultati:", 50, 100);
        for(int i = 0; i < novaLista.length; ++i)
        text(novaLista[i], 100, 120 + i*20);
        
        saveStrings("data/list.txt", spremnaLista);
        
        exit();
       
         break;
       
     
      

        //saveStrings("data/list.txt", nova);
      
  }
}

//za gumbe pronalazak misa
void update(int x, int y)
{
  if(overRect(rectX1,rectY1,200,20))
    {
      rectOver1 = true;
      rectOver2 = false;
      rectOver3 = false;
      rectOver4 = false;
    }
    
    else if(overRect(rectX2,rectY2,200,20))
    {
      rectOver1 = false;
      rectOver2 = true;
      rectOver3 = false;
      rectOver4 = false;
    }
    
    else if(overRect(rectX3,rectY3,200,20))
    {
      rectOver1 = false;
      rectOver2 = false;
      rectOver3 = true;
      rectOver4 = false;
    }
    
    else if(overRect(rectX4,rectY4,200,20))
    {
      rectOver1 = false;
      rectOver2 = false;
      rectOver3 = false;
      rectOver4 = true;
    }
    
    else 
    {
      rectOver1 = false;
      rectOver2 = false;
      rectOver3 = false;
      rectOver4 = false;
    }
  
  
  
  
}

boolean overRect(int x, int y, int width, int height)  
{
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void keyPressed()
{
  switch(status) {
    case uTijeku:
      if(key>='1' && key <='4' && otkucaj==false)
      {
        status = odgovorenoPitanje;
        vrijeme = millis();
      }
      break;
   /* case odgovorenoPitanje:
      status = uTijeku;
     // indeksPitanja++;
      if(indeksPitanja>listaPitanja.size()-1)
      {
        status = kraj;
      }
      
      break;*/
     case kraj:
       if(key=='r') {
         indeksPitanja=0;
         status=uTijeku;
         tocnoOdg=0;
         int i2=0;
         
        pomocnaLista= new ArrayList();
        listaPitanja= new ArrayList();
        for (int i=0; i<poljePitanja.length; i+=5)
        {
          Pitanje trenutnoPitanje = new Pitanje(poljePitanja[i], poljePitanja[i+1],poljePitanja[i+2], poljePitanja[i+3],poljePitanja[i+4], tocniOdgovori[i2], 30, 30);
          pomocnaLista.add(trenutnoPitanje);
          i2++;
          }

        while(listaPitanja.size()< 3)
        {
         int indeks = (int)random(pomocnaLista.size());
         listaPitanja.add(pomocnaLista.get(indeks));
         pomocnaLista.remove(indeks);
        }
       }
       if(key=='u')
       {
         status=pregledRezultata;
       }
       break;
       
     case pregledRezultata:
       if(key=='q' && (tocnoOdg > najmanjiRez)) status = unosRezultata;
       break;
     
     case unosRezultata:
       if(key=='.') status=spremanjeRezultata;
       else 
       {
         if(key >= 'a' && key <= 'z')
         ime+=key;
       }
         
       
       break;
       
       
     default:
       break;  
  }
  
}

void mousePressed()
{
   switch(status) {
    case uTijeku:
      if(rectOver1 || rectOver2 || rectOver3 || rectOver4)
      {
        status = odgovorenoPitanje;
        vrijeme = millis();
      }

      
      break;
    /*case odgovorenoPitanje:
      status = uTijeku;
     // indeksPitanja++;
      if(indeksPitanja>listaPitanja.size()-1)
      {
        status = kraj;
      }
      
      break;*/
     case kraj:
       if(mouseButton == RIGHT) {
         indeksPitanja=0;
         status=uTijeku;
         tocnoOdg=0;
         int i2=0;
         
        pomocnaLista= new ArrayList();
        listaPitanja= new ArrayList();
        for (int i=0; i<poljePitanja.length; i+=5)
        {
          Pitanje trenutnoPitanje = new Pitanje(poljePitanja[i], poljePitanja[i+1],poljePitanja[i+2], poljePitanja[i+3],poljePitanja[i+4], tocniOdgovori[i2], 30, 30);
          pomocnaLista.add(trenutnoPitanje);
          i2++;
          }

        while(listaPitanja.size()< 3)
        {
         int indeks = (int)random(pomocnaLista.size());
         listaPitanja.add(pomocnaLista.get(indeks));
         pomocnaLista.remove(indeks);
        }
       }
       
       break;
     default:
       break;  
  }
  
}

class Pitanje {
  String tekstPitanja;
  String odg1, odg2, odg3, odg4;
  int tocanOdgovor;
  int pozicijaX, pozicijaY;
  boolean jelSlika1, jelSlika2, jelSlika3;

  
  Pitanje(String tp, String o1, String o2, String o3, String o4, int tocan, int x, int y)
  {
    tekstPitanja = tp;
    if(tp == "Što se nalazi na slici?") { jelSlika1 = true; jelSlika2 = false; jelSlika3 = false;}
    else if(tp == "Što prikazuje ova fotografija?") { jelSlika1 = false; jelSlika2 = true; jelSlika3 = false;}
    else if(tp == "Koji je planet na ovoj slici?") { jelSlika1 = false; jelSlika2 = false; jelSlika3 = true;}
    else { jelSlika1 = false; jelSlika2 = false; jelSlika3 = false; }
    odg1 = o1;
    odg2 = o2;
    odg3 = o3;
    odg4 = o4;
    tocanOdgovor = tocan;
    pozicijaX = x;
    pozicijaY = y;
    tocnoOdg=0;
  }
  
  void display() {
    fill(210,7,7);
    textSize(20);
    text(tekstPitanja, pozicijaX, pozicijaY);
    fill(0,102,150);
    textSize(16); 
    fill(0,255,100); rect(pozicijaX,pozicijaY+10,200,20); rectX1 = 30; rectY1 = 40; fill(0,102,150); 
    text(" 1.) "+odg1, pozicijaX, pozicijaY+25); fill(0,255,100); rect(pozicijaX,pozicijaY+35,200,20); rectX2 = 30; rectY2 = 65; fill(0,102,150);
    text(" 2.) "+odg2, pozicijaX, pozicijaY+50); fill(0,255,100); rect(pozicijaX,pozicijaY+60,200,20); rectX3 = pozicijaX; rectY3 = 90; fill(0,102,150);
    text(" 3.) "+odg3, pozicijaX, pozicijaY+75); fill(0,255,100); rect(pozicijaX,pozicijaY+85,200,25); rectX4 = pozicijaX; rectY4 = 115; fill(0,102,150);
    text(" 4.) "+odg4, pozicijaX, pozicijaY+100);
    fill(0);
    textSize(13);
    text("Na tipkovnici odaberi broj uz točan odgovor.", pozicijaX, pozicijaY+130);
    
    if(jelSlika1)
    {
      PImage img;
      img = loadImage("cheer.png");
      image(img, 350, 50);
    }
    
    if(jelSlika2)
    {
      PImage img;
      img = loadImage("macka.png");
      image(img, 350, 50);
    }
    
    if(jelSlika3)
    {
      PImage img;
      img = loadImage("earth.png");
      image(img, 350, 50);
    }
  }
  
  boolean check(char keyToTest) {
    if((keyToTest=='1' || rectOver1) && tocanOdgovor==1)  return true;
    if((keyToTest=='2' || rectOver2) && tocanOdgovor==2)  return true; 
    if((keyToTest=='3' || rectOver3) && tocanOdgovor==3)  return true; 
    if((keyToTest=='4' || rectOver4) && tocanOdgovor==4)  return true; 
    return false;
  }
 
  
}
