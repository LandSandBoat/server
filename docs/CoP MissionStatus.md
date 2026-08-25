`player:setMissionStatus(log id, value, index)`

uint32 at 0x14 in the 0x56 packet (CQuestMissionLogPacket)

MISSIONSTATUS INDEX FOR COP LOG (log id 6)
```
  76543210   Index
0x00000000
  ||||||||_0 = 3-3 San d'Oria Bits
  |||||||__1 = 3-3 Windurst Bits
  ||||||___2 = 5-3 Louverance's Path Bits
  |||||____3 = 5-3 Tenzen's Path Bits
  ||||_____4 = 5-3 Ulmia's Path Bits
  |||______5 = 1-2/3 Promyvion Bits
  ||_______6 = 7-4 3 NM Bits
  |________7 = 8-1 Rubious Crystals Bits
```

>index 0 = 3-3 San d'Oria Bits
`player:setMissionStatus(COP, 0, x)`
```
0x1 - SAN D'ORIA CS #1 (Northern San d'Oria)
0x2 - SAN D'ORIA CS #2 (Arnau)
0x5 - SAN D'ORIA CS #3 (Chasalvige)
0x9 - SAN D'ORIA CS #4 (Guilloud)
0xE - SAN D'ORIA CS #5 (Hinaree)
```

>index 1 = 3-3 Windurst Bits
`player:setMissionStatus(COP, 1, x)`
```
0x1 - WINDURST CS #1 (Windurst Waters)
0x2 - WINDURST CS #2 (Ohbiru-Dohbiru)
0x3 - WINDURST CS #3 (Yoran-Oran)
0x5 - WINDURST CS #4 (Kyume-Romeh)
0x6 - WINDURST CS #5 (Honoi-Gomoi)
0x8 - WINDURST CS #6 (Yoran-Oran - BEFORE MIMEO FEATHERS)
0x9 - WINDURST CS #7 (Yoran-Oran - AFTER MIMEO FEATHERS)
0xB - WINDURST CS #8 (Yujuju)
0xC - WINDURST CS #9 (Tosuka-Porika)
0xE - WINDURST CS #10 (Yoran-Oran)
```

>index 2 = 5-3 Louverance's Path Bits
`player:setMissionStatus(COP, 2, x)`
```
0x2 - LOUVERANCE PATH CS #1 (Despachiaire)
0x3 - LOUVERANCE PATH CS #2 (Perih Vashai)
0x6 - LOUVERANCE PATH CS #3 (Warmachine)
0x8 - LOUVERANCE PATH CS #4 (Oldton)
0x9 - LOUVERANCE PATH CS #5 (Moblin Battle)
0xB - LOUVERANCE PATH CS #6 (Cid)
0xC - LOUVERANCE PATH CS #7 (Shaft Entrance)
0xE - LOUVERANCE PATH CS #8 (Cid) - FINAL
```

>index 3 = 5-3 Tenzen's Path Bits
`player:setMissionStatus(COP, 3, x)`
```
0x2 - TENZEN PATH CS #1 (La Theine ???)
0x3 - TENZEN PATH CS #2 (Avatar Gate)
0x5 - TENZEN PATH CS #3 (Monberaux)
0x6 - TENZEN PATH CS #4 (Pherimociel)
0x8 - TENZEN PATH CS #5 (Batallia ???)
0x9 - TENZEN PATH CS #6 (Cermet Door)
0xB - TENZEN PATH CS #7 (Pso'Xja - ON ZONE IN (before cs))
0xC - TENZEN PATH CS #8 (Avatar Gate)
0xE - TENZEN PATH CS #9 (Cid) - FINAL
```

>index 4 = 5-3 Ulmia's Path Bits
`player:setMissionStatus(COP, 4, x)`
```
0x2 - ULMIA PATH CS #1 (Hinaree)
0x3 - ULMIA PATH CS #2 (Port San d'Oria)
0x4 - ULMIA PATH CS #3 (Chasalvige)
0x6 - ULMIA PATH CS #4 (Kerutoto)
0x7 - ULMIA PATH CS #5 (Yoran-Oran)
0x8 - ULMIA PATH CS #6 (Shikaree Battle)
0x9 - ULMIA PATH CS #7 (Snoll Tzar Battle)
0xE - ULMIA PATH CS #8 (Cid) - FINAL
```

>index 5 = 1-2/3 Promyvion Bits
`player:setMissionStatus(COP, 5, x)`
```
x = y IF player:getMissionStatus(COP, 5) == 0
x = bit.lshift(y, 2) IF 0 < player:getMissionStatus(COP, 5) < 4
x = bit.bor(player:getMissionStatus(COP, 5), z) IF player:getMissionStatus(COP, 5) >= 4
y = current crag
z = crag WHERE z != bit.rshift(player:getMissionStatus(COP, 5), 2) AND z != y

Crags:
0x1 = Holla
0x2 = Dem
0x3 = Mea

Example:
0x1 Holla -> 0xC Mea -> 0xD Dem (0001, 1100, 1101)
0x2 Dem -> 0x4 Holla -> 0x6 Mea (0010, 0100, 0110)
```

>index 6 = 7-4 3 NM Bits
`player:setMissionStatus(COP, 6, bit.bor(player:getMissionStatus(COP, 6), x))`
```
0x1 = Boggelmann CS
0x2 = Cryptonberry Executor CS
0x4 = Dalham CS
0xF = first rubious crystal (8-1)
```

>index 7 = 8-1 Rubious Crystals Bits
`player:setMissionStatus(COP, 6, x)`
```
0x2 - second rubious crystal
0x3 - third rubious crystal
```

FINAL VALUE
0x3FpEEEEE where p is dependent on order promys done in
