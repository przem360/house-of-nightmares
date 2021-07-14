 rem ************************************************************************
 rem House of Nightmares by Przemyslaw Wolski 
 rem v 0.1: 2017/02/14
 rem v 0.2: 2021/07/14
 rem ************************************************************************

 rem set kernel_options pfheights
 set tv ntsc
 set romsize 8k
 set smartbranching on
reset
 c{1}=0
 c{2}=0
 c{3}=0
 c{4}=1
 c{5}=0
 c{6}=0
 c{7}=0
 c{0}=0
 e=20  
 g=0
 w=0    
 x=255
 y=255
 v=255
 w=255
 t=0
 z=3
 j{1}=0
 l{2}=0
 l{3}=0
 l{4}=0
 l{5}=0
 l{6}=0
 l{7}=0
 f=0
 k=0
 n=1
 dim duration=b
 dim rand16=d
 dim sounda = f
 dim soundb = g

 rem n{1} to zycie przeciwnika
 rem m jest chyba powiazany ze scianami
 rem z to zycie gracza
 rem l{2} to numer pomieszczenia
 rem k to numer pomieszczenia
 rem l{3} 0 pierwsze wejscie na nowy lewel 1 - level byl odwiedzony i przeciwnik zabity
 rem nowy lewel gdy player0x>140
 rem j{1} - czy joy ruszony
 rem g - licznik uderzen przy rozbijaniu sciany  w lvl1

 rem  *  Volume off
 AUDV0=0
 AUDV1=0

 lifecolor = $40

 duration = 1
 goto MusicSetup

 rem pfheights was here

 playfield:
 .X.X............................
 .X.X..X..X.X.X..X.XXX.XX.XX.....
 .XXX.X.X.X.X.XX.X..X..X..X.X....
 .X.X.XXX.X.X.XXXX..X..XX.X..X...
 .X.X.X.X.X.X.X.XX..X..X..X.X....
 .X.X.X.X.XXX.X..X..X..XX.XX.....
 .............................XX.
 .............X.X..X..X.X..XX.X..
 .............XXX.X.X.X.X..X..XX.
 .............X.X.X.X.X.X..X..X..
 .............X.X..X..XXX.XX..XX.
end

title
 COLUBK = $F2
 COLUPF = $06
 goto GetMusic
GotMusic

 gosub titledrawscreen bank2

 drawscreen
 if joy0fire || joy1fire then AUDV0=0: AUDV1=0: goto skiptitle
 goto title
skiptitle
 rem level_0 tutaj
 x=50
 y=20
 v=50
 w=70
 player0color:
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
end


 rem oryg player0

 player1color:
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
end
 lives=96
 rem oryg player1

 COLUBK = $F2
 missile0height = 4  : missile0y = 255
 NUSIZ0 = $16
 score = 0 :  scorecolor = $40
 m = 0
main
 COLUP1 = $00
 COLUP0 = $90
 COLUPF = $06
 player0y=y:player0x=x
 if n>0 then player1y=w:player1x=v
 if n<=0 then player1y=255:player1x=255

 if k=0 then gosub level_0
 if k=1 then gosub level_1
 if k=2 then gosub level_2
 if k=3 then gosub level_3
 if k=4 then gosub level_4_secret
 if k=5 then gosub level_5
 if k=6 then gosub final_screen
checkfire
 if missile0y>240 then goto skip
 rem missile0y = missile0y - 2 : goto draw
skip
 if sounda > 0 then sounda = sounda - 1 : AUDC0 = 8 : AUDV0 = 4 : AUDF0 = sounda else AUDV0 = 0
 if soundb > 0 then soundb = soundb - 1 : AUDC1 = 2 : AUDV1 = 14 : AUDF1 = soundb else AUDV1 = 0
 if joy0fire then sounda = 50
 if joy0up then soundb = 50
 rem if joy0fire then missile0y=player0y-2:missile0x=player0x+4
 if !joy0fire then missile0x=0:missile0y=0:e=0
 rem znikanie pocisku
 if joy0fire && c{3} then missile0x=player0x-10-e:missile0y=player0y-5:missile0height=1
 rem strzal w lewo
 if joy0fire && c{4} then missile0x=player0x+12+e:missile0y=player0y-5:missile0height=1
 rem strzal w prawo
 if joy0fire && c{1} then missile0x=player0x+5:missile0y=player0y-10-e
 if joy0fire && c{2} then missile0x=player0x+5:missile0y=player0y+3+e

draw drawscreen
 a=a+1
 lives:
 %00001000
 %00011100
 %00111110
 %01111111
 %11111111
 %10111111
 %01100110
 %00000000
end
 if k=2&&a=10 then player1:
 %01000010
 %01011010
 %01011010
 %10011001
 %10100101
 %11111111
 %01011010
 %00111100
end
 if k=2&&a=20 then player1:
 %10000001
 %10100101
 %10100101
 %10011001
 %10100101
 %11111111
 %01011010
 %00111100
end
 if k=0&&a=10 then player1:
 %10101010
 %11111110
 %11111110
 %11111110
 %11111110
 %11010110
 %01111100
 %00111000
end
 if k=0&&a=20 then player1:
 %01010100
 %11111110
 %11111110
 %11111110
 %11111110
 %11010110
 %01111100
 %00111000
end
 if k=1&&a=10 then player1:
 %10100101
 %10100101
 %01010010
 %01111110
 %01111111
 %11000000
 %11000000
 %00100000
end
 if k=1&&a=20 then player1:
 %01001011
 %01001011
 %01010010
 %01111110
 %11111110
 %01000001
 %11000000
 %00100000
end

 if k=4 then player1:
 %00110
 %00100
 %00110
 %00100
 %00100
 %01110
 %11111
 %01110
end

 if !j{1} then player0:
 %0001110
 %0001100
 %0001100
 %0101101
 %0101101
 %0011110
 %0000000
 %0001100
 %0001100
end

 if j{1}&&a=10 then player0:
 %00011100
 %00011000
 %00011000
 %01011010
 %01011010
 %00111100
 %00000000
 %00011000
 %00011000
end

 if j{1}&&a=20 then player0:
 %00100100
 %00110100
 %00001000
 %00111010
 %01011010
 %00111100
 %00000000
 %00011000
 %00011000
end

 if k=5&&a=10 then player1:
 %01010100
 %01010100
 %01010100
 %01111100
 %11111110
 %01010100
 %01111100
 %00111000
end

 if k=5&&a=20 then player1:
 %10101010
 %10010010
 %01010100
 %01111100
 %11111110
 %01010100
 %01111100
 %00111000
end

 if a=20 then a=0
 e=e+1
 if e>120 then e=0
 rem l{3} - czy zabity?
 if collision(missile0,player1) then gosub scored
 if collision(missile0,player1) && k=0 && n>0 then n=n-1
 if collision(missile0,player1) && k=0 && n<=0 then l{3}=1:v=255:w=255:player1x=255:player1y=255:missile0y=255
 if collision(missile0,player1) && k=1 && n>0 then n=n-1
 if collision(missile0,player1) && k=1 && n<=0 then l{4}=1:v=255:w=255:player1x=255:player1y=255:missile0y=255
 if collision(missile0,player1) && k=2 && n>0 then n=n-1
 if collision(missile0,player1) && k=2 && n<=0 then l{5}=1:v=255:w=255:player1x=255:player1y=255:missile0y=255
 if collision(missile0,player1) && k=3 && n>0 then n=n-1
 if collision(missile0,player1) && k=3 && n<=0 then l{5}=1:v=255:w=255:player1x=255:player1y=255:missile0y=255
 if collision(missile0,player1) && k=5 && n>0 then n=n-1
 if collision(missile0,player1) && k=5 && n<=0 then l{6}=1:v=255:w=255:player1x=255:player1y=255:missile0y=255
 if collision(player0,player1) && k<>4 then v=50:w=70:lives=lives-32:z=z-1
 if collision(player0,player1) && k=4 && n>0 then score=score+1000:v=255:w=255:n=n-1:l{7}=1
 if n<=0 then v=255: w=255

 if z<1 then goto you_died

 if m = 1 && collision(player0,playfield) then y = y + 5 : goto skipmove
 rem gorna sciana

 if m = 2 && collision(player0,playfield) then x = x + 5  : goto skipmove
 rem lewa sciana

 if m = 3 && collision(player0,playfield) then y = y - 5 : goto skipmove
 rem dolna sciana

 if m = 4 && collision(player0,playfield) then x = x - 5 : goto skipmove
 rem prawa sciana: zwiekszenie odbicia o 1px ze wzgledu na glicz

 if !joy0up && !joy0down && !joy0left && !joy0right then j{1}=0
 if joy0up && !collision(player0,playfield) then y = y - 1 : m = 1 : c{1}=1:c{2}=0:c{3}=0:c{4}=0:c{5}=0:c{6}=0:c{7}=0:c{0}=0 : j{1}=1: goto skipmove
 if joy0left  && !collision(player0,playfield) then x = x - 1 :  REFP0 = 8 : m = 2 :c{1}=0:c{2}=0:c{3}=1:c{4}=0:c{5}=0:c{6}=0:c{7}=0:c{0}=0: j{1}=1: goto skipmove
 if joy0down  && !collision(player0,playfield) then y = y + 1  : m = 3 :c{1}=0:c{2}=1:c{3}=0:c{4}=0:c{5}=0:c{6}=0:c{7}=0:c{0}=0: j{1}=1: goto skipmove
 if joy0right  && !collision(player0,playfield) then x = x + 1 :  m = 4 : REFP0 = 0 :c{1}=0:c{2}=0:c{3}=0:c{4}=1:c{5}=0:c{6}=0:c{7}=0:c{0}=0: j{1}=1: goto skipmove

 rem jezeli x>140 to nowe pomieszczenie - nowa pozycja przeciwnika - nowe zycie przeciwnika
 if k=0 && x>140 then k=1:x=20:y=20:v=50:w=70
 if k=1 && l{4} then n=0: v=255: w=255
 if k=1 && !l{4} then n=1
 if k=1 && x<10 then x=120:y=70:k=0: gosub level_0
 if k=1 && x>140 then k=2:x=20:y=70:n=3:w=50:v=70: gosub level_2
 if k=2 && !l{5} then n=3
 if k=2 && l{5} then n=0: v=255: w=255
 if k=2 && x<20 then k=1:x=120:y=20:gosub level_1
 if k=2 && player0y<=15 && player0x>100 then k=5:y=70:x=120: v=30: w=30: gosub level_5
 if k=3 && player0y<=15 && player0x>100 then k=5:y=70:x=120: v=30: w=30: gosub level_5
 if k=3 && !l{5} then n=3
 if k=3 && l{5} then n=0: v=255: w=255
 if k=4 && !l{7} then n=1: v=30: w=30
 if k=4 && l{7} then n=0: v=255: w=255
 if k=5 && !l{6} then n=3
 if k=5 && l{6} then n=0: v=255: w=255
 if k=5 && player0y>70 then k=2: x=120: y=30: gosub level_2
 if k=5 && player0y<=15 && player0x<=100 && !l{7} then y=70: x=120
 if k=5 && player0y<=15 && player0x<=100 && l{7} then k=6:v=255:w=255:x=255:y=255: AUDV0=0: AUDV1=0: gosub final_screen
 rem y dla przeciwnika w lvl 2 ok. 20

 rem rozbijanie sciany
 if k=2 && x<30 && y<40 && joy0fire then g=g+1
 if k=2 && g>=3 && x<40 && y<40 then k=3: score=score+500: gosub level_3
 if k=3 && y>40 && x<20 then k=1:x=120:y=20:gosub level_1
 if k=3 && y<35 && x<20 then k=4:v=30:w=30:x=120:y=20:gosub level_4_secret
 if k=4 && joy0fire then k=3:x=30:y=30: gosub level_3
 if k=4 && x>140 then k=3: x=20: y=30: gosub level_3

 rem end rozbijanie sciany
 t=t+1
 if t>10 then t=1
 if v < x && n>0 && k<>4 then v=v+1
 if v > x && n>0 && k<>4 then v=v-1
 if w < y && n>0 && k<>4 then w=w+1
 if w > y && n>0 && k<>4 then w=w-1
 if n<=0 && k<>4 then v=255: w=255
skipmove
 goto main

scored
 missile0y=255
 score=score+10
 n=n-1 
 if n<=0 then v=255: w=255
 return
 

level_0
 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X..............................X
 X..............................X
 XXXXXXXXXXXXXXXXXXXX...........X
 X..............................X
 X..............................X
 X.......XXXXXXXXXXXXXXXXXXXXXXXX
 X..............................X
 X...............................
 X...............................
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 return


level_1
 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 ....X.............X.............
 ....X.............X.............
 X...X.............X............X
 X...X.............X............X
 X...X...X.........X............X
 X.......X.........X............X
 X.......X......................X
 X.......X......................X
 X.......X......................X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 return 

level_2
 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXX....X
 X.........................X....X
 X..............................X
 X..........XXXXXXXX............X
 X..........XXXXXXXX............X
 X..........XXXXXXXX............X
 X..........XXXXXXXX............X
 X..........XXXXXXXX............X
 ...............................X
 ...............................X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 return

level_3
 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXX....X
 ..........................X....X
 ...............................X
 X..........XXXXXXXX............X
 X..........XXXXXXXX............X
 X..........XXXXXXXX............X
 X..........XXXXXXXX............X
 X..........XXXXXXXX............X
 ...............................X
 ...............................X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 return 

level_4_secret
 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X...............................
 X...............................
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 return

level_5
 playfield:
 XXXXXXXXXXXXX....XXXXXXXXXXXXXXX
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 XXXXXXXXXXXXXXXXXXXXXXXXXXX....X
end
 return

you_died

you_died_loop
  x=255:y=255:v=255:w=255
 playfield:
 ................................
 .X.X............................
 .X.X..X..X..X...................
 .X.X.X.X.X..X...................
 ..X..X.X.X..X.XX................
 ..X..X.X.X..X.X.X.X.XX.XX.......
 ..X...X...XX..X.X.X.X..X.X......
 ..............X.X.X.XX.X.X......
 ..............X.X.X.X..X.X......
 ..............XX..X.XX.XX.......
 ................................
end
 drawscreen
 if joy0fire || joy1fire then goto reset
 goto you_died_loop
 return

final_screen
 playfield:
 .X.X.XXX.X.X...X.X.XXX.X.X.XXX..
 .XXX.X.X.X.X...X.X.X.X.X.X.X....
 ..X..X.X.X.X...XXX.XXX.X.X.XX...
 ..X..X.X.X.X...X.X.X.X.X.X.X....
 ..X..XXX.XXX...X.X.X.X..X..XXX..
 ................................
 .XXX.XXX.XXX.XXX.XXX.XXX.XX..X..
 .X...X...X...X.X.X.X.X...X.X.X..
 .XX..XXX.X...XXX.XXX.XX..X.X.X..
 .X.....X.X...X.X.X...X...X.X....
 .XXX.XXX.XXX.X.X.X...XXX.XX..X..
end
 if joy0fire || joy1fire then goto reset
 return

GetMusic

   rem  *  Check for end of current note
   duration = duration - 1
   if duration>0 then GotMusic


   rem  *  Retrieve channel 0 data
   temp4 = sread(musicData)
   temp5 = sread(musicData)
   temp6 = sread(musicData)


   rem  *  Check for end of data
   if temp4=255 then duration = 1 : goto MusicSetup


   rem  *  Play channel 0
   AUDV0 = temp4
   AUDC0 = temp5
   AUDF0 = temp6


   rem  *  Retrieve channel 1 data
   temp4 = sread(musicData)
   temp5 = sread(musicData)
   temp6 = sread(musicData)


   rem  *  Play channel 1
   AUDV1 = temp4
   AUDC1 = temp5
   AUDF1 = temp6


   rem  *  Set duration
   duration = sread(musicData)
   goto GotMusic

MusicSetup
   sdata musicData=p
  8,4,13
  0,0,0
  11
  8,4,17
  0,0,0
  6
  8,4,14
  0,0,0
  6
  8,4,13
  0,0,0
  11
  8,4,17
  0,0,0
  6
  8,4,14
  0,0,0
  11
  8,4,13
  0,0,0
  6
  8,4,17
  0,0,0
  11
  8,4,14
  0,0,0
  6
  8,4,13
  0,0,0
  11
  8,4,17
  0,0,0
  6
  8,4,14
  0,0,0
  6
  0,0,0
  0,0,0
  6
  8,4,20
  0,0,0
  11
  8,4,23
  0,0,0
  6
  8,4,19
  0,0,0
  6
  8,4,20
  0,0,0
  6
  8,4,23
  0,0,0
  6
  8,4,19
  0,0,0
  6
  8,4,20
  0,0,0
  6
  8,4,23
  0,0,0
  6
  8,4,19
  0,0,0
  6
  8,4,20
  0,0,0
  11
  8,4,23
  0,0,0
  6
  8,4,19
  0,0,0
  6
  0,0,0
  0,0,0
  6
  255
end
   goto GotMusic
 bank 2
 asm
 include "titlescreen/asm/titlescreen.asm"
end
 inline 6lives.asm
