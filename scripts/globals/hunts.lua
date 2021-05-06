-----------------------------------
-- Hunt Registry
-- https://www.bg-wiki.com/bg/Hunts
-- https://ffxiclopedia.fandom.com/wiki/Hunt_Registry
-- https://www.bg-wiki.com/bg/Hunt_Registry
-----------------------------------
require("scripts/globals/zone")
require("scripts/globals/msg")
require("scripts/globals/regimes")

xi = xi or {}
xi.hunts = xi.hunts or {}

local hunts =
{
    [147] = { bounty =  5, fee =   0 }, -- Fungus Beetle
    [148] = { bounty =  5, fee =   0 }, -- Jaggedy-Eared Jack
    [149] = { bounty =  5, fee =   0 }, -- Amanita
    [150] = { bounty =  5, fee =   0 }, -- Swamfisk
    [151] = { bounty =  5, fee =   0 }, -- Bigmouth Billy
    [152] = { bounty =  5, fee =   0 }, -- Rambukk
    [153] = { bounty =  5, fee =   0 }, -- Nihniknoovi
    [154] = { bounty =  5, fee =  15 }, -- Tumbling Truffle
    [155] = { bounty =  5, fee =  15 }, -- Slumbering Samwell
    [156] = { bounty = 10, fee =   0 }, -- Lumbering Lambert
    [157] = { bounty =  5, fee =   0 }, -- Panzer Percival
    [158] = { bounty =  5, fee =   0 }, -- Fraelissa
    [159] = { bounty = 10, fee =  40 }, -- Sappy Sycamore
    [160] = { bounty = 15, fee =  40 }, -- Supplespine Mujwuj
    [161] = { bounty = 10, fee =  25 }, -- Tottering Toby
    [162] = { bounty = 10, fee =  40 }, -- Skirling Liger
    [163] = { bounty = 20, fee =   0 }, -- Eyegouger
    [164] = { bounty = 20, fee =   0 }, -- Prankster Maverix
    [165] = { bounty = 10, fee =   0 }, -- Hercules Beetle
    [166] = { bounty = 10, fee =  30 }, -- Mycophile
    [167] = { bounty = 15, fee =   0 }, -- Orctrap
    [168] = { bounty = 10, fee =   0 }, -- Tempest Tigon
    [169] = { bounty =  5, fee =   0 }, -- Orcish Wallbreacher
    [170] = { bounty =  5, fee =   0 }, -- Thousandarm Deshglesh
    [171] = { bounty =  5, fee =   0 }, -- Orcish Barricader
    [172] = { bounty =  5, fee =  10 }, -- Hundredscar Hajwaj
    [173] = { bounty =  5, fee =   0 }, -- Kegpaunch Doshgnosh
    [174] = { bounty =  5, fee =   0 }, -- Chariotbuster Byakzak
    [175] = { bounty =  5, fee =   0 }, -- Barbastelle
    [176] = { bounty =  5, fee =   0 }, -- Ankou
    [177] = { bounty = 10, fee =   0 }, -- Gwyllgi
    [178] = { bounty = 25, fee =   0 }, -- Arioch
    [179] = { bounty = 30, fee =   0 }, -- Shii
    [180] = { bounty = 30, fee =   0 }, -- Manes
    [181] = { bounty = 15, fee =  40 }, -- Donggu
    [182] = { bounty = 10, fee =  40 }, -- Bombast
    [183] = { bounty = 20, fee =   0 }, -- Agar Agar
    [184] = { bounty = 25, fee =   0 }, -- Skull of Gluttony
    [185] = { bounty = 25, fee =   0 }, -- Skull of Greed
    [186] = { bounty = 25, fee =   0 }, -- Skull of Sloth
    [187] = { bounty = 25, fee =   0 }, -- Skull of Lust
    [188] = { bounty = 25, fee =   0 }, -- Skull of Pride
    [189] = { bounty = 25, fee =   0 }, -- Skull of Envy
    [190] = { bounty = 25, fee =   0 }, -- Skull of Wrath
    [191] = { bounty = 25, fee =   0 }, -- Cwn Cyrff
    [192] = { bounty = 10, fee =  25 }, -- Hawkeyed Dnatbat
    [193] = { bounty =  5, fee =   0 }, -- Tigerbane Bakdak
    [194] = { bounty =  5, fee =   0 }, -- Steelbiter Gudrud
    [195] = { bounty = 15, fee =  35 }, -- Poisonhand Gnadgad
    [196] = { bounty = 20, fee =   0 }, -- Blubbery Bulge
    [197] = { bounty =  5, fee =   0 }, -- Stinging Sophie
    [198] = { bounty =  5, fee =   0 }, -- Maighdean Uaine
    [199] = { bounty =  5, fee =   0 }, -- Bedrock Barry
    [200] = { bounty =  5, fee =   0 }, -- Leaping Lizzy
    [201] = { bounty =  5, fee =   0 }, -- Tococo
    [202] = { bounty =  5, fee =  10 }, -- Carnero
    [203] = { bounty =  5, fee =   0 }, -- Stray Mary
    [204] = { bounty =  5, fee =   0 }, -- Ghillie Dhu
    [205] = { bounty = 10, fee =   0 }, -- Rampaging Ram
    [206] = { bounty = 10, fee =  25 }, -- Highlander Lizard
    [207] = { bounty =  5, fee =   0 }, -- Metal Shears
    [208] = { bounty = 10, fee =   0 }, -- Golden Bat
    [209] = { bounty = 10, fee =   0 }, -- Valkurm Emperor
    [210] = { bounty = 10, fee =   0 }, -- Hippomaritimus
    [211] = { bounty =  5, fee =   0 }, -- Bloodpool Vorax
    [212] = { bounty = 10, fee =   0 }, -- Jolly Green
    [213] = { bounty = 15, fee =   0 }, -- Toxic Tamlyn
    [214] = { bounty = 15, fee =  40 }, -- Ni'Zho Bladebender
    [215] = { bounty = 10, fee =   0 }, -- Black Triple Stars
    [216] = { bounty = 15, fee =   0 }, -- Drooling Daisy
    [217] = { bounty = 10, fee =   0 }, -- Ravenous Crawler
    [218] = { bounty = 20, fee =   0 }, -- Eldritch Edge
    [219] = { bounty =  5, fee =   0 }, -- Bu'Ghi Howlblade
    [220] = { bounty =  5, fee =  15 }, -- Zi'Ghi Boneeater
    [221] = { bounty =  5, fee =   0 }, -- Qu'Vho Deathhurler
    [222] = { bounty =  5, fee =   0 }, -- Be'Hya Hundredwall
    [223] = { bounty =  5, fee =   0 }, -- Teporingo
    [224] = { bounty =  5, fee =   0 }, -- Chocoboleech
    [225] = { bounty = 10, fee =   0 }, -- Geyser Lizard
    [226] = { bounty = 10, fee =   0 }, -- Cargo Crab Colin
    [227] = { bounty = 10, fee =   0 }, -- Falcatus Aranei
    [228] = { bounty = 15, fee =   0 }, -- Dame Blanche
    [229] = { bounty = 10, fee =  40 }, -- Thoon
    [230] = { bounty = 15, fee =   0 }, -- Smothered Schmidt
    [231] = { bounty = 15, fee =   0 }, -- Crushed Krause
    [232] = { bounty = 15, fee =   0 }, -- Pulverized Pfeffer
    [233] = { bounty = 15, fee =   0 }, -- Burned Bergmann
    [234] = { bounty = 15, fee =   0 }, -- Wounded Wurfel
    [235] = { bounty = 15, fee =   0 }, -- Asphyxiated Amsel
    [236] = { bounty = 25, fee =   0 }, -- Demonic Tiphia
    [237] = { bounty = 20, fee =   0 }, -- Dynast Beetle
    [238] = { bounty = 30, fee =   0 }, -- Aqrabuamelu
    [239] = { bounty =  5, fee =  20 }, -- Bi'Gho Headtaker
    [240] = { bounty = 10, fee =   0 }, -- Ge'Dha Evileye
    [241] = { bounty = 10, fee =  25 }, -- Da'Dha Hundredmask
    [242] = { bounty = 15, fee =   0 }, -- Zo'Khu Blackcloud
    [243] = { bounty = 15, fee =  45 }, -- Ga'Bhu Unvanquished
    [244] = { bounty = 15, fee =  45 }, -- Bugbear Strongman
    [245] = { bounty = 20, fee =   0 }, -- Goblin Wolfman
    [246] = { bounty = 15, fee =  50 }, -- Bugbear Muscleman
    [247] = { bounty = 35, fee =  75 }, -- Swashstox Beadblinker
    [248] = { bounty = 35, fee =  75 }, -- Bugbear Matman
    [249] = { bounty = 35, fee =  80 }, -- Sword Sorcerer Solisoq
    [250] = { bounty =  5, fee =   0 }, -- Tom Tit Tat
    [251] = { bounty =  5, fee =   0 }, -- Nunyenunc
    [252] = { bounty =  5, fee =   0 }, -- Numbing Norman
    [253] = { bounty =  5, fee =   0 }, -- Spiny Spipi
    [254] = { bounty =  5, fee =   0 }, -- Sharp-Eared Ropipi
    [255] = { bounty =  5, fee =   0 }, -- Duke Decapod
    [256] = { bounty =  5, fee =  10 }, -- Yara Ma Yha Who
    [257] = { bounty =  5, fee =   0 }, -- Serpopard Ishtar
    [258] = { bounty =  5, fee =   0 }, -- Habrok
    [259] = { bounty = 10, fee =   0 }, -- Herbage Hunter
    [260] = { bounty =  5, fee =   0 }, -- Wake Warder Wanda
    [261] = { bounty = 10, fee =   0 }, -- Buburimboo
    [262] = { bounty = 10, fee =   0 }, -- Helldiver
    [263] = { bounty = 15, fee =  35 }, -- Backoo
    [264] = { bounty = 15, fee =   0 }, -- Serra
    [265] = { bounty = 15, fee =   0 }, -- Intulo
    [266] = { bounty = 15, fee =   0 }, -- Shankha
    [267] = { bounty = 30, fee =  65 }, -- Splacknuck
    [268] = { bounty = 10, fee =   0 }, -- Daggerclaw Dracos
    [269] = { bounty = 10, fee =   0 }, -- Patripatan
    [270] = { bounty = 10, fee =   0 }, -- Chonchon
    [271] = { bounty = 20, fee =  45 }, -- Naa Zeku the Unwaiting
    [272] = { bounty = 15, fee =   0 }, -- Deadly Dodo
    [273] = { bounty = 15, fee =   0 }, -- Bashe
    [274] = { bounty = 15, fee =   0 }, -- Thunderclaw Thuban
    [275] = { bounty = 20, fee =   0 }, -- Blighting Brand
    [276] = { bounty = 15, fee =   0 }, -- Sekhmet
    [277] = { bounty = 30, fee =   0 }, -- Ambusher Antlion
    [278] = { bounty = 30, fee =   0 }, -- Citipati
    [279] = { bounty = 35, fee =  75 }, -- Sargas
    [280] = { bounty =  5, fee =   0 }, -- Juu Duzu the Whirlwind
    [281] = { bounty =  5, fee =  15 }, -- Hoo Mjuu the Torrent
    [282] = { bounty =  5, fee =   0 }, -- Vuu Puqu the Beguiler
    [283] = { bounty =  5, fee =   0 }, -- Quu Xijo the Illusory
    [284] = { bounty = 30, fee =   0 }, -- Canal Moocher
    [285] = { bounty = 35, fee =  75 }, -- Konjac
    [286] = { bounty = 35, fee =   0 }, -- Brazen Bones
    [287] = { bounty =  5, fee =   0 }, -- Nocuous Weapon
    [288] = { bounty =  5, fee =   0 }, -- Maltha
    [289] = { bounty =  5, fee =   0 }, -- Slendlix Spindlethumb
    [290] = { bounty =  5, fee =   0 }, -- Desmodont
    [291] = { bounty = 10, fee =   0 }, -- Ah Puch
    [292] = { bounty = 10, fee =   0 }, -- Legalox Heftyhind
    [293] = { bounty = 15, fee =   0 }, -- Trembler Tabitha
    [294] = { bounty = 10, fee =   0 }, -- Lesath
    [295] = { bounty = 15, fee =   0 }, -- Gloombound Lurker
    [296] = { bounty = 25, fee =  60 }, -- Hellion
    [297] = { bounty = 25, fee =   0 }, -- Peg Powler
    [298] = { bounty = 30, fee =   0 }, -- Soulstealer Skullnix
    [299] = { bounty = 30, fee =  75 }, -- Narasimha
    [300] = { bounty = 25, fee =   0 }, -- Hazmat
    [301] = { bounty = 25, fee =   0 }, -- Hovering Hotpot
    [302] = { bounty = 25, fee =   0 }, -- Frogamander
    [303] = { bounty = 10, fee =  25 }, -- Moo Ouzi the Swiftblade
    [304] = { bounty = 10, fee =   0 }, -- Saa Doyi the Fervid
    [305] = { bounty = 15, fee =  40 }, -- Yaa Haqa the Profane
    [306] = { bounty = 10, fee =  40 }, -- Lii Jixa the Somnolist
    [307] = { bounty = 10, fee =   0 }, -- Trickster Kinetix
    [308] = { bounty = 15, fee =   0 }, -- Slippery Sucker
    [309] = { bounty = 15, fee =   0 }, -- Qoofim
    [310] = { bounty = 25, fee =   0 }, -- Atkorkamuy
    [311] = { bounty = 15, fee =   0 }, -- Kirata
    [312] = { bounty = 15, fee =   0 }, -- Gargantua
    [313] = { bounty = 20, fee =   0 }, -- Calcabrina
    [314] = { bounty = 25, fee =  60 }, -- Humbaba
    [315] = { bounty = 15, fee =   0 }, -- Shadow Eye
    [316] = { bounty = 15, fee =   0 }, -- Duke Focalor
    [317] = { bounty = 25, fee =   0 }, -- Timeworn Warrior
    [318] = { bounty = 30, fee =   0 }, -- Barbaric Weapon
    [319] = { bounty = 25, fee =   0 }, -- Bonnacon
    [320] = { bounty = 25, fee =  70 }, -- Frost Flambeau
    [321] = { bounty = 35, fee =  75 }, -- Skvader
    [322] = { bounty = 40, fee =   0 }, -- Magnotaur
    [323] = { bounty = 15, fee =   0 }, -- Elusive Edwin
    [324] = { bounty = 20, fee =   0 }, -- Keeper of Halidom
    [325] = { bounty = 25, fee =   0 }, -- Bastet
    [326] = { bounty = 25, fee =   0 }, -- Huwasi
    [327] = { bounty = 25, fee =   0 }, -- Nightmare Vase
    [328] = { bounty = 30, fee =   0 }, -- Rogue Receptacle
    [329] = { bounty = 25, fee =   0 }, -- Martinet
    [330] = { bounty = 35, fee =  75 }, -- Nargun
    [331] = { bounty = 15, fee =  35 }, -- Enkelados
    [332] = { bounty = 25, fee =   0 }, -- Ixtab
    [333] = { bounty = 35, fee =  85 }, -- Autarch
    [334] = { bounty = 10, fee =   0 }, -- Eurytos
    [335] = { bounty = 10, fee =   0 }, -- Polybotes
    [336] = { bounty = 10, fee =   0 }, -- Rhoitos
    [337] = { bounty = 10, fee =   0 }, -- Ophion
    [338] = { bounty = 10, fee =   0 }, -- Rhoikos
    [339] = { bounty = 10, fee =   0 }, -- Ogygos
    [340] = { bounty = 10, fee =   0 }, -- Epialtes
    [341] = { bounty = 10, fee =   0 }, -- Hippolytos
    [342] = { bounty = 10, fee =  30 }, -- Eurymedon
    [343] = { bounty = 10, fee =  40 }, -- Tyrant
    [344] = { bounty = 15, fee =   0 }, -- Hyakume
    [345] = { bounty = 15, fee =   0 }, -- Mucoid Mass
    [346] = { bounty = 30, fee =   0 }, -- Gloom Eye
    [347] = { bounty = 20, fee =   0 }, -- Mind Hoarder
    [348] = { bounty = 25, fee =   0 }, -- Jenglot
    [349] = { bounty = 35, fee =  75 }, -- Sluagh
    [350] = { bounty = 20, fee =   0 }, -- Marquis Naberius
    [351] = { bounty = 25, fee =   0 }, -- Likho
    [352] = { bounty = 30, fee =  70 }, -- Marquis Sabnock
    [353] = { bounty = 25, fee =   0 }, -- Baronet Romwe
    [354] = { bounty = 25, fee =   0 }, -- Baron Vapula
    [355] = { bounty = 25, fee =   0 }, -- Count Bifrons
    [356] = { bounty = 25, fee =  65 }, -- Viscount Morax
    [357] = { bounty = 25, fee =   0 }, -- Ellyllon
    [358] = { bounty = 25, fee =   0 }, -- Aquarius
    [359] = { bounty = 30, fee =   0 }, -- Unut
    [360] = { bounty = 35, fee =  75 }, -- Leshonki
    [361] = { bounty = 10, fee =   0 }, -- Koropokkur
    [362] = { bounty = 15, fee =   0 }, -- Mischievous Micholas
    [363] = { bounty = 25, fee =   0 }, -- Bayawak
    [364] = { bounty = 30, fee =   0 }, -- Pyuu the Spatemaker
    [365] = { bounty = 15, fee =  45 }, -- Powderer Penny
    [366] = { bounty = 20, fee =   0 }, -- Edacious Opo-opo
    [367] = { bounty = 25, fee =   0 }, -- Acolnahuacatl
    [368] = { bounty = 30, fee =   0 }, -- Hoar-knuckled Rimberry
    [369] = { bounty = 15, fee =   0 }, -- Namtar
    [370] = { bounty = 15, fee =   0 }, -- Wuur the Sandcomber
    [371] = { bounty = 20, fee =   0 }, -- Masan
    [372] = { bounty = 20, fee =  45 }, -- Fyuu the Seabellow
    [373] = { bounty = 20, fee =  45 }, -- Qull the Shellbuster
    [374] = { bounty = 15, fee =  45 }, -- Seww the Squidlimbed
    [375] = { bounty = 25, fee =   0 }, -- Pahh the Gullcaller
    [376] = { bounty = 20, fee =   0 }, -- Sea Hog
    [377] = { bounty = 20, fee =   0 }, -- Yarr the Pearleyed
    [378] = { bounty = 20, fee =   0 }, -- Voll the Sharkfinned
    [379] = { bounty = 20, fee =   0 }, -- Denn the Orcavoiced
    [380] = { bounty = 20, fee =  60 }, -- Mouu the Waverider
    [381] = { bounty = 25, fee =   0 }, -- Worr the Clawfisted
    [382] = { bounty = 30, fee =   0 }, -- Zuug the Shoreleaper
    [383] = { bounty = 25, fee =   0 }, -- Manipulator
    [384] = { bounty = 20, fee =   0 }, -- Flauros
    [385] = { bounty = 25, fee =   0 }, -- Death from Above
    [386] = { bounty = 25, fee =   0 }, -- Habetrot
    [387] = { bounty = 25, fee =   0 }, -- Beryl-footed Molberry
    [388] = { bounty = 20, fee =   0 }, -- Sozu Sarberry
    [389] = { bounty = 20, fee =   0 }, -- Sozu Terberry
    [390] = { bounty = 25, fee =   0 }, -- Sozu Rogberry
    [391] = { bounty = 30, fee =   0 }, -- Sacrificial Goblet
    [392] = { bounty = 30, fee =   0 }, -- Crimson-toothed Pawberry
    [393] = { bounty = 20, fee =   0 }, -- Sozu Bliberry
    [394] = { bounty = 30, fee =  65 }, -- Friar Rush
    [395] = { bounty = 30, fee =   0 }, -- Celeste-eyed Tozberry
    [396] = { bounty = 30, fee =   0 }, -- Tawny-fingered Mugberry
    [397] = { bounty = 30, fee =   0 }, -- Bistre-hearted Malberry
    [398] = { bounty = 35, fee =   0 }, -- Ogama
    [399] = { bounty = 30, fee =   0 }, -- Foreseer Oramix
    [400] = { bounty = 30, fee =   0 }, -- Tyrannic Tunnok
    [401] = { bounty = 30, fee =   0 }, -- Lindwurm
    [402] = { bounty = 35, fee =   0 }, -- Vouivre
    [403] = { bounty = 35, fee =  75 }, -- Tarasque
    [404] = { bounty = 25, fee =   0 }, -- Tegmine
    [405] = { bounty = 30, fee =  75 }, -- Frostmane
    [406] = { bounty = 35, fee =   0 }, -- Zmey Gorynych
    [407] = { bounty = 40, fee =  80 }, -- Killer Jonny
    [408] = { bounty = 15, fee =  40 }, -- Dune Widow
    [409] = { bounty = 15, fee =  45 }, -- Nandi
    [410] = { bounty =  5, fee =   0 }, -- Donnergugi
    [411] = { bounty = 25, fee =   0 }, -- Sabotender Corrido
    [412] = { bounty = 20, fee =   0 }, -- Cactuar Cantautor
    [413] = { bounty = 25, fee =   0 }, -- Dahu
    [414] = { bounty = 25, fee =   0 }, -- Picolaton
    [415] = { bounty = 30, fee =  70 }, -- Calchas
    [416] = { bounty = 25, fee =   0 }, -- Cancer
    [417] = { bounty = 30, fee =   0 }, -- Sabotender Mariachi
    [418] = { bounty = 25, fee =   0 }, -- Amemet
    [419] = { bounty = 25, fee =   0 }, -- Yowie
    [420] = { bounty = 25, fee =   0 }, -- Arachne
    [421] = { bounty = 30, fee =   0 }, -- Bloodthirster Madkix
    [422] = { bounty = 40, fee =   0 }, -- Pelican
    [423] = { bounty = 20, fee =   0 }, -- Goblinsavior Heronox
    [424] = { bounty = 35, fee =  75 }, -- Taxim
    [425] = { bounty = 30, fee =  75 }, -- Baobhan Sith
    [426] = { bounty = 25, fee =  55 }, -- Centurio X-I
    [427] = { bounty = 25, fee =  55 }, -- Sagittarius X-XIII
    [428] = { bounty = 30, fee =   0 }, -- Diamond Daig
    [429] = { bounty = 20, fee =   0 }, -- Antican Magister
    [430] = { bounty = 20, fee =   0 }, -- Antican Proconsul
    [431] = { bounty = 20, fee =   0 }, -- Antican Praefectus
    [432] = { bounty = 20, fee =   0 }, -- Antican Tribunus
    [433] = { bounty = 20, fee =   0 }, -- Sabotender Bailarin
    [434] = { bounty = 25, fee =   0 }, -- Tribunus VII-I
    [435] = { bounty = 30, fee =   0 }, -- Nussknacker
    [436] = { bounty = 30, fee =   0 }, -- Triarius X-XV
    [437] = { bounty = 25, fee =   0 }, -- Proconsul XII
    [438] = { bounty = 40, fee =  75 }, -- Sabotender Bailarina
    [439] = { bounty = 15, fee =   0 }, -- Megalobugard
    [440] = { bounty = 20, fee =   0 }, -- Yal-un Eke
    [441] = { bounty = 20, fee =  55 }, -- Sengann
    [442] = { bounty = 40, fee =  80 }, -- Flockbock
    [443] = { bounty = 15, fee =   0 }, -- Odqan
    [444] = { bounty = 15, fee =   0 }, -- Goaftrap
    [445] = { bounty = 20, fee =   0 }, -- Ziphius
    [446] = { bounty = 25, fee =   0 }, -- Okyupete
    [447] = { bounty = 25, fee =   0 }, -- Zoraal Ja's Pkuucha
    [448] = { bounty = 35, fee =   0 }, -- Jaded Jody
    [449] = { bounty = 35, fee =  75 }, -- Chelicerata
    [450] = { bounty = 35, fee =   0 }, -- Gharial
    [451] = { bounty = 25, fee =   0 }, -- Harvestman
    [452] = { bounty = 35, fee =  75 }, -- Emergent Elm
    [453] = { bounty = 35, fee =  75 }, -- Nis Puk
    [454] = { bounty = 40, fee =  75 }, -- Mahishasura
    [455] = { bounty = 35, fee =  75 }, -- Energetic Eruca
    [456] = { bounty = 40, fee =  75 }, -- Chary Apkallu
    [457] = { bounty = 40, fee =  80 }, -- Ignamoth
    [458] = { bounty = 35, fee =  85 }, -- Fahrafahr the Bloodied
    [459] = { bounty = 35, fee =  75 }, -- Venomfang
    [460] = { bounty = 35, fee =  80 }, -- Zizzy Zillah
    [461] = { bounty = 40, fee =  85 }, -- Firedance Magmaal Ja
    [462] = { bounty = 25, fee =   0 }, -- Lizardtrap
    [463] = { bounty = 30, fee =   0 }, -- Crystal Eater
    [464] = { bounty = 30, fee =  75 }, -- Bluestreak Gyugyuroon
    [465] = { bounty = 35, fee =  80 }, -- Copper Borer
    [466] = { bounty = 40, fee =  80 }, -- Big Bomb
    [467] = { bounty = 40, fee =  85 }, -- Flammeri
    [468] = { bounty = 25, fee =   0 }, -- Peallaidh
    [469] = { bounty = 35, fee =  75 }, -- Zikko
    [470] = { bounty = 35, fee =  80 }, -- Aynu-kaysey
    [471] = { bounty = 40, fee =  85 }, -- Vidhuwa the Wrathborn
    [472] = { bounty = 35, fee =  80 }, -- Bloody Bones
    [473] = { bounty = 40, fee =  80 }, -- Amikiri
    [474] = { bounty = 40, fee =  85 }, -- Euryale
    [475] = { bounty = 40, fee =  80 }, -- Ungur
    [476] = { bounty = 35, fee =  80 }, -- Boompadu
    [477] = { bounty = 40, fee =  85 }, -- Cookieduster Lipiroon
    [478] = { bounty = 45, fee = 100 }, -- Oupire
    [479] = { bounty = 15, fee =   0 }, -- Skogs Fru
    [480] = { bounty = 15, fee =   0 }, -- Myradrosh
    [481] = { bounty = 20, fee =   0 }, -- Goblintrap
    [482] = { bounty = 25, fee =   0 }, -- Melusine
    [483] = { bounty = 20, fee =   0 }, -- Boll Weevil
    [484] = { bounty = 35, fee =  80 }, -- Drumskull Zogdregg
    [485] = { bounty = 40, fee =  80 }, -- Vulkodlac
    [486] = { bounty = 40, fee =  85 }, -- Voirloup
    [487] = { bounty = 25, fee =   0 }, -- Warabouc
    [488] = { bounty = 35, fee =  75 }, -- Big Bang
    [489] = { bounty = 35, fee =  80 }, -- Pallas
    [490] = { bounty = 35, fee =  80 }, -- Judgmental Julika
    [491] = { bounty = 15, fee =   0 }, -- La Velue
    [492] = { bounty = 20, fee =   0 }, -- Chaneque
    [493] = { bounty = 25, fee =   0 }, -- Habergoass
    [494] = { bounty = 30, fee =   0 }, -- Burlibix Brawnback
    [495] = { bounty = 35, fee =  75 }, -- Laelaps
    [496] = { bounty = 45, fee = 100 }, -- Tethra
    [497] = { bounty = 45, fee = 100 }, -- Ethniu
    [498] = { bounty = 15, fee =   0 }, -- Gloomanita
    [499] = { bounty = 15, fee =   0 }, -- Olgoi-Khorkhoi
    [500] = { bounty = 20, fee =   0 }, -- Ankabut
    [501] = { bounty = 25, fee =   0 }, -- Peaseblossom
    [502] = { bounty = 25, fee =  70 }, -- Sarcopsylla
    [503] = { bounty = 35, fee =  80 }, -- Scitalis
    [504] = { bounty = 35, fee =  80 }, -- Kotan-kor Kamuy
    [505] = { bounty = 40, fee =  85 }, -- Vasiliceratops
    [506] = { bounty = 35, fee =   0 }, -- Croque-mitaine
    [507] = { bounty = 35, fee =  75 }, -- Kinepikwa
    [508] = { bounty = 35, fee =  80 }, -- Sugaar
    [509] = { bounty = 40, fee =  85 }, -- Nommo
    [510] = { bounty = 20, fee =   0 }, -- Lamina
    [511] = { bounty = 20, fee =   0 }, -- Dyinyinga
    [512] = { bounty = 25, fee =   0 }, -- Erle
    [513] = { bounty = 30, fee =   0 }, -- Delicieuse Delphine
    [514] = { bounty = 35, fee =  75 }, -- Abatwa
    [515] = { bounty = 35, fee =  80 }, -- Morille Mortelle
    [516] = { bounty = 45, fee = 100 }, -- Lugh
    [517] = { bounty =  5, fee =   0 }, -- Jeduah
    [518] = { bounty = 15, fee =   0 }, -- Belladonna
    [519] = { bounty = 20, fee =   0 }, -- Ramponneau
    [520] = { bounty = 25, fee =   0 }, -- Tiffenotte
    [521] = { bounty = 15, fee =   0 }, -- Emela-ntouka
    [522] = { bounty = 25, fee =   0 }, -- Ratatoskr
    [523] = { bounty = 20, fee =   0 }, -- Kirtimukha
    [524] = { bounty = 35, fee =  80 }, -- Demoiselle Desolee
    [525] = { bounty = 25, fee =   0 }, -- Muq Shabeel
    [526] = { bounty = 35, fee =  75 }, -- Bloodlapper
    [527] = { bounty = 35, fee =  80 }, -- Hemodrosophila
    [528] = { bounty = 40, fee =  85 }, -- Centipedal Centruroides
    [529] = { bounty = 15, fee =   0 }, -- Balam-Quitz
    [530] = { bounty = 20, fee =   0 }, -- Hyakinthos
    [531] = { bounty = 25, fee =   0 }, -- Herensugue
    [532] = { bounty = 30, fee =   0 }, -- Coquecigrue
    [533] = { bounty = 35, fee =  75 }, -- Citadel Pipistrelles
    [534] = { bounty = 45, fee = 100 }, -- Buarainech
    [535] = { bounty = 45, fee = 100 }, -- Elatha
    [536] = { bounty = 35, fee =  80 }, -- Came-cruse
    [537] = { bounty = 35, fee =  80 }, -- Becut
    [538] = { bounty = 40, fee =  85 }, -- Grand'Goule
    [539] = { bounty = 45, fee = 100 }, -- Scylla
    [540] = { bounty = 35, fee =  80 }, -- Tikbalang
    [541] = { bounty = 40, fee =  85 }, -- Prince Orobas
    [542] = { bounty = 40, fee =  85 }, -- Graoully
    [543] = { bounty = 45, fee = 100 }, -- Zirnitra
    [544] = { bounty = 50, fee = 125 }, -- Krabkatoa
    [545] = { bounty = 40, fee =   0 }, -- Yacumama
    [546] = { bounty = 40, fee =   0 }, -- Capricornus
    [547] = { bounty = 50, fee = 125 }, -- Blobdingnag
    [548] = { bounty = 40, fee =   0 }, -- Shoggoth
    [549] = { bounty = 40, fee =   0 }, -- Lamprey Lord
    [550] = { bounty = 50, fee = 125 }, -- Orcus
    [551] = { bounty = 40, fee =   0 }, -- Jyeshtha
    [552] = { bounty = 40, fee =   0 }, -- Farruca Fly
    [553] = { bounty = 50, fee = 125 }, -- Verthandi
    [554] = { bounty = 40, fee =   0 }, -- Urd
    [555] = { bounty = 40, fee =   0 }, -- Skuld
    [556] = { bounty = 50, fee = 125 }, -- Lord Ruthven
    [557] = { bounty = 40, fee =   0 }, -- Erebus
    [558] = { bounty = 40, fee =   0 }, -- Feuerunke
    [559] = { bounty = 60, fee = 150 }, -- Yilbegan
}

local zone =
{
    [xi.zone.RULUDE_GARDENS] =
    {
        -- these params display the correct number of hunts
        huntMenu =
        {
            [   1] =    2031616,
            [   9] = 2147483616,
            [  17] = 2147483616,
            [  25] = 2147483616,
            [  33] = 2147483616,
            [  41] = 2147483616,
            [  49] = 2147483616,
            [  57] = 2147483632,
            [  65] = 2147483520,
            [  73] = 2147483616,
            [  81] = 2147483632,
            [  89] = 2147483632,
            [  97] = 2147483632,
            [ 105] = 2147483616,
            [ 113] = 2147483616,
            [ 121] = 2147483392,
        },
        -- these params display info after hunt selection
        -- Qufim Island
        [ 266] = { params =  52531, huntId = 307 },
        [ 522] = { params =  69940, huntId = 308 },
        [ 778] = { params =  86325, huntId = 309 },
        [1034] = { params = 121142, huntId = 310 },
        -- Beaucedine Glacier
        [ 274] = { params =  69943, huntId = 311 },
        [ 530] = { params =  86328, huntId = 312 },
        [ 786] = { params =  88377, huntId = 313 },
        [1042] = { params = 105786, huntId = 314 },
        -- Xarcabard
        [ 282] = { params =  86331, huntId = 315 },
        [ 538] = { params =  86332, huntId = 316 },
        [ 794] = { params = 104765, huntId = 317 },
        [1050] = { params = 122174, huntId = 318 },
        -- Uleguerand Range
        [ 290] = { params = 120127, huntId = 319 },
        [ 546] = { params = 121152, huntId = 320 },
        [ 802] = { params = 139585, huntId = 321 },
        [1058] = { params = 158018, huntId = 322 },
        -- The Sanctuary of Zi'tah
        [ 298] = { params =  86339, huntId = 323 },
        [ 554] = { params = 103748, huntId = 324 },
        [ 810] = { params = 105797, huntId = 325 },
        [1066] = { params = 105798, huntId = 326 },
        -- Ro'Maeve
        [ 306] = { params = 120135, huntId = 327 },
        [ 562] = { params = 122184, huntId = 328 },
        [ 818] = { params = 121161, huntId = 329 },
        [1074] = { params = 139594, huntId = 330 },
        -- Upper Delkfutt's Tower
        [ 314] = { params =  69963, huntId = 331 },
        [ 570] = { params = 120140, huntId = 332 },
        [ 826] = { params = 155981, huntId = 333 },
        -- Middle Delkfutt's Tower
        [ 322] = { params =  52558, huntId = 334 },
        [ 578] = { params =  52559, huntId = 335 },
        [ 834] = { params =  52560, huntId = 336 },
        [1090] = { params =  52561, huntId = 337 },
        [1346] = { params =  52562, huntId = 338 },
        [1602] = { params =  52563, huntId = 339 },
        -- Lower Delkfutt's Tower
        [ 330] = { params =  52564, huntId = 340 },
        [ 586] = { params =  52565, huntId = 341 },
        [ 842] = { params =  52566, huntId = 342 },
        [1098] = { params =  68951, huntId = 343 },
        -- Ranguemont Pass
        [ 338] = { params =  69976, huntId = 344 },
        [ 594] = { params =  86361, huntId = 345 },
        [ 850] = { params = 122202, huntId = 346 },
        -- Fei'Yin
        [ 346] = { params = 103771, huntId = 347 },
        [ 602] = { params = 121180, huntId = 348 },
        [ 858] = { params = 140637, huntId = 349 },
        -- Castle Zvahl Baileys
        [ 354] = { params = 103774, huntId = 350 },
        [ 610] = { params = 121183, huntId = 351 },
        [ 866] = { params = 122208, huntId = 352 },
        -- Castle Zvahl Keep
        [ 362] = { params = 120161, huntId = 353 },
        [ 618] = { params = 120162, huntId = 354 },
        [ 874] = { params = 120163, huntId = 355 },
        [1130] = { params = 120164, huntId = 356 },
        -- The Boyahda Tree
        [ 370] = { params = 104805, huntId = 357 },
        [ 626] = { params = 122214, huntId = 358 },
        [ 874] = { params = 122215, huntId = 359 },
        [1130] = { params = 139624, huntId = 360 },
        -- Habitat Unknown (Ru'lude Gardens)
        [ 378] = { params = 157226, huntId = 554 },
        [ 634] = { params = 157227, huntId = 555 },
        [ 890] = { params = 157229, huntId = 557 },
        [1146] = { params = 157230, huntId = 558 },
        [1402] = { params = 174633, huntId = 553 },
        [1658] = { params = 174636, huntId = 556 },
        [1914] = { params = 174639, huntId = 559 },
    },

    [xi.zone.NORTHERN_SAN_DORIA] =
    {
        huntMenu =
        {
            [   1] =    2031616,
            [   9] = 2147483616,
            [  17] = 2147483616,
            [  25] = 2147483616,
            [  33] = 2147483632,
            [  41] = 2147483632,
            [  49] = 2147483632,
            [  57] = 2147483616,
            [  65] = 2147483632,
            [  73] = 2147483632,
            [  81] = 2147483632,
            [  89] = 2147483632,
            [  97] = 2147483632,
            [ 105] = 2147483136,
            [ 113] = 2147483584,
            [ 121] = 2147483632,
        },
        -- West Ronfaure
        [ 266] = { params =  17555, huntId = 147 },
        [ 522] = { params =  17556, huntId = 148 },
        [ 778] = { params =  17557, huntId = 149 },
        -- East Ronfaure
        [ 274] = { params =  17558, huntId = 150 },
        [ 530] = { params =  17559, huntId = 151 },
        [ 786] = { params =  17560, huntId = 152 },
        -- La Theine Plateau
        [ 282] = { params =  18585, huntId = 153 },
        [ 538] = { params =  34970, huntId = 154 },
        [ 794] = { params =  33947, huntId = 155 },
        [1050] = { params =  52380, huntId = 156 },
        -- Valkurm Dunes
        [ 290] = { params =  33999, huntId = 207 },
        [ 546] = { params =  52432, huntId = 208 },
        [ 802] = { params =  52433, huntId = 209 },
        [1058] = { params =  68818, huntId = 210 },
        -- Jugner Forest
        [ 298] = { params =  34973, huntId = 157 },
        [ 554] = { params =  51358, huntId = 158 },
        [ 810] = { params =  68767, huntId = 159 },
        [1066] = { params =  69792, huntId = 160 },
        -- Batallia Downs
        [ 306] = { params =  52385, huntId = 161 },
        [ 562] = { params =  69770, huntId = 162 },
        [ 818] = { params =  87203, huntId = 163 },
        [1074] = { params =  87204, huntId = 164 },
        -- Carpenters' Landing
        [ 314] = { params =  53413, huntId = 165 },
        [ 570] = { params =  53414, huntId = 166 },
        [ 826] = { params =  69799, huntId = 167 },
        [1082] = { params =  68776, huntId = 168 },
        -- Ghelsba Outpost
        [ 322] = { params =  18601, huntId = 169 },
        [ 578] = { params =  17578, huntId = 170 },
        [ 834] = { params =  34987, huntId = 171 },
        -- Fort Ghelsba
        [ 330] = { params =  17580, huntId = 172 },
        [ 586] = { params =  33965, huntId = 173 },
        [ 842] = { params =  36014, huntId = 174 },
        -- King Ranperre's Tomb
        [ 338] = { params =  34991, huntId = 175 },
        [ 594] = { params =  36016, huntId = 176 },
        [ 850] = { params =  52401, huntId = 177 },
        -- Bostaunieux Oubliette
        [ 346] = { params = 104626, huntId = 178 },
        [ 602] = { params = 123059, huntId = 179 },
        [ 858] = { params = 123060, huntId = 180 },
        -- Ordelle's Caves
        [ 354] = { params =  69813, huntId = 181 },
        [ 610] = { params =  68790, huntId = 182 },
        [ 866] = { params =  87223, huntId = 183 },
        -- The Eldieme Necropolis
        [ 362] = { params = 105656, huntId = 184 },
        [ 618] = { params = 105657, huntId = 185 },
        [ 874] = { params = 105658, huntId = 186 },
        [1130] = { params = 105659, huntId = 187 },
        [1386] = { params = 105660, huntId = 188 },
        [1642] = { params = 105661, huntId = 189 },
        [1898] = { params = 105662, huntId = 190 },
        [2154] = { params = 104639, huntId = 191 },
        -- Davoi
        [ 370] = { params =  52416, huntId = 192 },
        [ 626] = { params =  51393, huntId = 193 },
        [ 882] = { params =  51394, huntId = 194 },
        [1138] = { params =  69827, huntId = 195 },
        [1394] = { params =  88260, huntId = 196 },
        -- Habitat Unknown (Northern San d'Oria)
        [ 378] = { params = 157217, huntId = 545 },
        [ 634] = { params = 157218, huntId = 546 },
        [ 890] = { params = 174624, huntId = 544 },
    },

    [xi.zone.BASTOK_MINES] =
    {
        huntMenu =
        {
            [   1] =    2031616,
            [   9] = 2147483632,
            [  17] = 2147483632,
            [  25] = 2147483616,
            [  33] = 2147483616,
            [  41] = 2147483616,
            [  49] = 2147483616,
            [  57] = 2147483616,
            [  65] = 2147483632,
            [  73] = 2147483616,
            [  81] = 2147483520,
            [  89] = 2147483632,
            [  97] = 2147483584,
            [ 105] = 2147483632,
            [ 113] = 2147483632,
            [ 121] = 2147483632,
        },
        -- North Gustaberg
        [ 266] = { params =  17605, huntId = 197 },
        [ 522] = { params =  17606, huntId = 198 },
        [ 778] = { params =  17607, huntId = 199 },
        -- South Gustaberg
        [ 274] = { params =  17608, huntId = 200 },
        [ 530] = { params =  17609, huntId = 201 },
        [ 786] = { params =  17610, huntId = 202 },
        -- Konschtat Highlands
        [ 282] = { params =  35019, huntId = 203 },
        [ 538] = { params =  33996, huntId = 204 },
        [ 794] = { params =  52429, huntId = 205 },
        [1050] = { params =  52430, huntId = 206 },
        -- Valkurm Dunes
        [ 290] = { params =  33999, huntId = 207 },
        [ 546] = { params =  52432, huntId = 208 },
        [ 802] = { params =  52433, huntId = 209 },
        [1058] = { params =  68818, huntId = 210 },
        -- Pashhow Marshlands
        [ 298] = { params =  35027, huntId = 211 },
        [ 554] = { params =  52436, huntId = 212 },
        [ 810] = { params =  69845, huntId = 213 },
        [1066] = { params =  69846, huntId = 214 },
        -- Rolanberry Fields
        [ 306] = { params =  52439, huntId = 215 },
        [ 562] = { params =  69848, huntId = 216 },
        [ 818] = { params =  68825, huntId = 217 },
        [1074] = { params =  87258, huntId = 218 },
        -- Palborough Mines
        [ 314] = { params =  17627, huntId = 219 },
        [ 570] = { params =  35036, huntId = 220 },
        [ 826] = { params =  34013, huntId = 221 },
        [1082] = { params =  35038, huntId = 222 },
        -- Dangruf Wadi
        [ 322] = { params =  35039, huntId = 223 },
        [ 578] = { params =  36064, huntId = 224 },
        [ 834] = { params =  53473, huntId = 225 },
        -- Korroloka Tunnel
        [ 330] = { params =  53474, huntId = 226 },
        [ 586] = { params =  53475, huntId = 227 },
        [ 842] = { params =  54500, huntId = 228 },
        [1098] = { params =  68837, huntId = 229 },
        -- Gusgen Mines
        [ 338] = { params =  69862, huntId = 230 },
        [ 594] = { params =  69863, huntId = 231 },
        [ 850] = { params =  69864, huntId = 232 },
        [1106] = { params =  69865, huntId = 233 },
        [1362] = { params =  69866, huntId = 234 },
        [1618] = { params =  69867, huntId = 235 },
        -- Crawlers' Nest
        [ 346] = { params = 104684, huntId = 236 },
        [ 602] = { params = 103661, huntId = 237 },
        [ 858] = { params = 138478, huntId = 238 },
        -- Beadeaux
        [ 354] = { params =  35055, huntId = 239 },
        [ 610] = { params =  52464, huntId = 240 },
        [ 866] = { params =  52465, huntId = 241 },
        [1122] = { params =  69874, huntId = 242 },
        [1378] = { params =  86259, huntId = 243 },
        -- Oldton Movalpolos
        [ 362] = { params =  86260, huntId = 244 },
        [ 618] = { params =  88309, huntId = 245 },
        [ 874] = { params =  86262, huntId = 246 },
        -- Newton Movalpolos
        [ 370] = { params = 139511, huntId = 247 },
        [ 626] = { params = 140536, huntId = 248 },
        [ 882] = { params = 155897, huntId = 249 },
        -- Habitat Unknown (Bastok Mines)
        [ 378] = { params = 157220, huntId = 548 },
        [ 634] = { params = 157221, huntId = 549 },
        [ 890] = { params = 174627, huntId = 547 },
    },

    [xi.zone.PORT_WINDURST] =
    {
        huntMenu =
        {
            [   1] =    1835008,
            [   9] = 2147483632,
            [  17] = 2147483632,
            [  25] = 2147483616,
            [  33] = 2147483616,
            [  41] = 2147483616,
            [  49] = 2147483616,
            [  57] = 2147483616,
            [  65] = 2147483616,
            [  73] = 2147483616,
            [  81] = 2147483632,
            [  89] = 2147483632,
            [  97] = 2147483632,
            [ 105] = 2147483632,
            [ 113] = 2147483616,
            [ 121] = 2147483632,
            [ 129] = 2147483616,
            [ 137] = 2147483632,
        },
        -- West Sarutabaruta
        [ 266] = { params =  17658, huntId = 250 },
        [ 522] = { params =  17659, huntId = 251 },
        [ 778] = { params =  17660, huntId = 252 },
        -- East Sarutabaruta
        [ 274] = { params =  17661, huntId = 253 },
        [ 530] = { params =  17662, huntId = 254 },
        [ 786] = { params =  17663, huntId = 255 },
        -- Tahrongi Canyon
        [ 282] = { params =  18688, huntId = 256 },
        [ 538] = { params =  35073, huntId = 257 },
        [ 794] = { params =  36098, huntId = 258 },
        [1050] = { params =  52483, huntId = 259 },
        -- Buburimu Peninsula
        [ 290] = { params =  34052, huntId = 260 },
        [ 546] = { params =  52485, huntId = 261 },
        [ 802] = { params =  52486, huntId = 262 },
        [1058] = { params =  69895, huntId = 263 },
        -- Bibiki Bay
        [ 298] = { params =  69896, huntId = 264 },
        [ 554] = { params =  86281, huntId = 265 },
        [ 810] = { params =  86282, huntId = 266 },
        [1066] = { params = 122123, huntId = 267 },
        -- Meriphataud Mountains
        [ 306] = { params =  52492, huntId = 268 },
        [ 562] = { params =  52493, huntId = 269 },
        [ 818] = { params =  68878, huntId = 270 },
        [1074] = { params =  87311, huntId = 271 },
        -- Sauromugue Champaign
        [ 314] = { params =  69904, huntId = 272 },
        [ 570] = { params =  69905, huntId = 273 },
        [ 826] = { params =  86290, huntId = 274 },
        [1082] = { params =  87315, huntId = 275 },
        -- Attohwa Chasm
        [ 322] = { params =  86292, huntId = 276 },
        [ 578] = { params = 123157, huntId = 277 },
        [ 834] = { params = 123157, huntId = 278 },
        [1090] = { params = 139543, huntId = 279 },
        -- Giddeus
        [ 330] = { params =  17688, huntId = 280 },
        [ 586] = { params =  35097, huntId = 281 },
        [ 842] = { params =  35098, huntId = 282 },
        [1098] = { params =  34075, huntId = 283 },
        -- Toraimarai Canal
        [ 338] = { params = 122140, huntId = 284 },
        [ 594] = { params = 139549, huntId = 285 },
        [ 850] = { params = 155934, huntId = 286 },
        -- Inner Horutoto Ruins
        [ 346] = { params =  35103, huntId = 287 },
        [ 602] = { params =  36128, huntId = 288 },
        [ 858] = { params =  35105, huntId = 289 },
        -- Outer Horutoto Ruins
        [ 354] = { params =  35106, huntId = 290 },
        [ 610] = { params =  52515, huntId = 291 },
        [ 866] = { params =  52540, huntId = 292 },
        -- Maze of Shakhrami
        [ 362] = { params =  69925, huntId = 293 },
        [ 618] = { params =  68902, huntId = 294 },
        [ 874] = { params =  86311, huntId = 295 },
        -- Labyrinth of Onzozo
        [ 370] = { params = 104744, huntId = 296 },
        [ 626] = { params = 104745, huntId = 297 },
        [ 882] = { params = 122154, huntId = 298 },
        [1138] = { params = 137515, huntId = 299 },
        -- Garlaige Citadel
        [ 378] = { params = 104748, huntId = 300 },
        [ 634] = { params = 104749, huntId = 301 },
        [ 890] = { params = 121134, huntId = 302 },
        -- Castle Oztroja
        [ 386] = { params =  52527, huntId = 303 },
        [ 642] = { params =  68912, huntId = 304 },
        [ 898] = { params =  69937, huntId = 305 },
        [1154] = { params =  68914, huntId = 306 },
        -- Habitat Unknown (Port Windurst)
        [ 394] = { params = 157223, huntId = 551 },
        [ 650] = { params = 157224, huntId = 552 },
        [ 898] = { params = 174630, huntId = 550 },
    },

    [xi.zone.KAZHAM] =
    {
        huntMenu =
        {
            [   1] =    2097024,
            [   9] = 2147483616,
            [  17] = 2147483616,
            [  25] = 2147450880,
            [  33] = 2147481600,
            [  41] = 2147483520,
            [  49] = 2147483584,
        },
        -- Yuhtunga Jungle
        [ 266] = { params =  68969, huntId = 361 },
        [ 522] = { params =  86378, huntId = 362 },
        [ 778] = { params = 104811, huntId = 363 },
        [1034] = { params = 123244, huntId = 364 },
        -- Yhoator Jungle
        [ 274] = { params =  86381, huntId = 365 },
        [ 530] = { params =  88430, huntId = 366 },
        [ 786] = { params = 121199, huntId = 367 },
        [1042] = { params = 122224, huntId = 368 },
        -- Sea Serpent Grotto
        [ 282] = { params =  70001, huntId = 369 },
        [ 538] = { params =  71026, huntId = 370 },
        [ 794] = { params =  72051, huntId = 371 },
        [1050] = { params =  88436, huntId = 372 },
        [1306] = { params =  88437, huntId = 373 },
        [1562] = { params =  86390, huntId = 374 },
        [1818] = { params = 104823, huntId = 375 },
        [2074] = { params = 102776, huntId = 376 },
        [2330] = { params = 102777, huntId = 377 },
        [2586] = { params = 102778, huntId = 378 },
        [2842] = { params = 102779, huntId = 379 },
        [3098] = { params = 102780, huntId = 380 },
        [3354] = { params = 104829, huntId = 381 },
        [3610] = { params = 122238, huntId = 382 },
        -- Temple of Uggalepih
        [ 290] = { params = 104831, huntId = 383 },
        [ 546] = { params = 103808, huntId = 384 },
        [ 802] = { params = 105857, huntId = 385 },
        [1058] = { params = 105858, huntId = 386 },
        [1314] = { params = 105859, huntId = 387 },
        [1570] = { params = 102788, huntId = 388 },
        [1826] = { params = 102789, huntId = 389 },
        [2082] = { params = 105862, huntId = 390 },
        [2338] = { params = 123271, huntId = 391 },
        [2594] = { params = 123272, huntId = 392 },
        -- Den of Rancor
        [ 298] = { params = 102793, huntId = 393 },
        [ 554] = { params = 122250, huntId = 394 },
        [ 810] = { params = 122251, huntId = 395 },
        [1066] = { params = 122252, huntId = 396 },
        [1322] = { params = 122253, huntId = 397 },
        [1578] = { params = 139662, huntId = 398 },
        -- Ifrit's Cauldron
        [ 306] = { params = 122255, huntId = 399 },
        [ 562] = { params = 122256, huntId = 400 },
        [ 818] = { params = 122257, huntId = 401 },
        [1074] = { params = 139666, huntId = 402 },
        [1330] = { params = 140691, huntId = 403 },
    },

    [xi.zone.NORG] =
    {
        huntMenu =
        {
            [   1] =    2097024,
            [   9] = 2147483616,
            [  17] = 2147483616,
            [  25] = 2147450880,
            [  33] = 2147481600,
            [  41] = 2147483520,
            [  49] = 2147483584,
        },
        -- Yuhtunga Jungle
        [ 266] = { params =  68969, huntId = 361 },
        [ 522] = { params =  86378, huntId = 362 },
        [ 778] = { params = 104811, huntId = 363 },
        [1034] = { params = 123244, huntId = 364 },
        -- Yhoator Jungle
        [ 274] = { params =  86381, huntId = 365 },
        [ 530] = { params =  88430, huntId = 366 },
        [ 786] = { params = 121199, huntId = 367 },
        [1042] = { params = 122224, huntId = 368 },
        -- Sea Serpent Grotto
        [ 282] = { params =  70001, huntId = 369 },
        [ 538] = { params =  71026, huntId = 370 },
        [ 794] = { params =  72051, huntId = 371 },
        [1050] = { params =  88436, huntId = 372 },
        [1306] = { params =  88437, huntId = 373 },
        [1562] = { params =  86390, huntId = 374 },
        [1818] = { params = 104823, huntId = 375 },
        [2074] = { params = 102776, huntId = 376 },
        [2330] = { params = 102777, huntId = 377 },
        [2586] = { params = 102778, huntId = 378 },
        [2842] = { params = 102779, huntId = 379 },
        [3098] = { params = 102780, huntId = 380 },
        [3354] = { params = 104829, huntId = 381 },
        [3610] = { params = 122238, huntId = 382 },
        -- Temple of Uggalepih
        [ 290] = { params = 104831, huntId = 383 },
        [ 546] = { params = 103808, huntId = 384 },
        [ 802] = { params = 105857, huntId = 385 },
        [1058] = { params = 105858, huntId = 386 },
        [1314] = { params = 105859, huntId = 387 },
        [1570] = { params = 102788, huntId = 388 },
        [1826] = { params = 102789, huntId = 389 },
        [2082] = { params = 105862, huntId = 390 },
        [2338] = { params = 123271, huntId = 391 },
        [2594] = { params = 123272, huntId = 392 },
        -- Den of Rancor
        [ 298] = { params = 102793, huntId = 393 },
        [ 554] = { params = 122250, huntId = 394 },
        [ 810] = { params = 122251, huntId = 395 },
        [1066] = { params = 122252, huntId = 396 },
        [1322] = { params = 122253, huntId = 397 },
        [1578] = { params = 139662, huntId = 398 },
        -- Ifrit's Cauldron
        [ 306] = { params = 122255, huntId = 399 },
        [ 562] = { params = 122256, huntId = 400 },
        [ 818] = { params = 122257, huntId = 401 },
        [1074] = { params = 139666, huntId = 402 },
        [1330] = { params = 140691, huntId = 403 },
    },

    [xi.zone.RABAO] =
    {
        huntMenu =
        {
            [   1] =    2097024,
            [   9] = 2147483616,
            [  17] = 2147483616,
            [  25] = 2147483616,
            [  33] = 2147483392,
            [  41] = 2147483584,
            [  49] = 2147467264,
        },
        -- Cape Teriggan
        [ 266] = { params = 121236, huntId = 404 },
        [ 522] = { params = 137621, huntId = 405 },
        [ 778] = { params = 139670, huntId = 406 },
        [1034] = { params = 157079, huntId = 407 },
        -- Eastern Altepa Desert
        [ 274] = { params =  70040, huntId = 408 },
        [ 530] = { params =  86425, huntId = 409 },
        [ 786] = { params =  87450, huntId = 410 },
        [1042] = { params = 121243, huntId = 411 },
        -- Western Altepa Desert
        [ 282] = { params = 103836, huntId = 412 },
        [ 538] = { params = 103885, huntId = 413 },
        [ 794] = { params = 104862, huntId = 414 },
        [1050] = { params = 122271, huntId = 415 },
        -- Kuftal Tunnel
        [ 290] = { params = 105888, huntId = 416 },
        [ 546] = { params = 122273, huntId = 417 },
        [ 802] = { params = 120226, huntId = 418 },
        [1058] = { params = 120227, huntId = 419 },
        [1314] = { params = 120228, huntId = 420 },
        [1570] = { params = 122277, huntId = 421 },
        [1826] = { params = 141734, huntId = 422 },
        -- Gustav Tunnel
        [ 298] = { params =  88487, huntId = 423 },
        [ 554] = { params = 139688, huntId = 424 },
        [ 810] = { params = 137641, huntId = 425 },
        [1066] = { params = 157145, huntId = 473 },
        [1322] = { params = 157147, huntId = 475 },
        -- Quicksand Caves
        [ 306] = { params = 104874, huntId = 426 },
        [ 562] = { params = 104875, huntId = 427 },
        [ 818] = { params = 106924, huntId = 428 },
        [1074] = { params = 102829, huntId = 429 },
        [1330] = { params = 102830, huntId = 430 },
        [1586] = { params = 102831, huntId = 431 },
        [1842] = { params = 102832, huntId = 432 },
        [2098] = { params = 102833, huntId = 433 },
        [2354] = { params = 105906, huntId = 434 },
        [2610] = { params = 106931, huntId = 435 },
        [2866] = { params = 122292, huntId = 436 },
        [3122] = { params = 121269, huntId = 437 },
        [3378] = { params = 141750, huntId = 438 },
    },

    [xi.zone.TAVNAZIAN_SAFEHOLD] =
    {
        huntMenu =
        {
            [   1] =    2097114,
            [   9] = 2147483616,
            [  17] = 2147483616,
        },
        -- Lufaise Meadows
        [ 266] = { params =  86455, huntId = 439 },
        [ 522] = { params =  87480, huntId = 440 },
        [ 778] = { params = 103865, huntId = 441 },
        [1034] = { params = 158138, huntId = 442 },
        -- Misareaux Coast
        [ 274] = { params =  86459, huntId = 443 },
        [ 530] = { params =  86460, huntId = 444 },
        [ 786] = { params =  88509, huntId = 445 },
        [1042] = { params = 104894, huntId = 446 },
    },

    [xi.zone.AHT_URHGAN_WHITEGATE] =
    {
        huntMenu =
        {
            [   1] =    2097024,
            [   9] = 2147483616,
            [  17] = 2147483616,
            [  25] = 2147483616,
            [  33] = 2147483632,
            [  41] = 2147483632,
            [  49] = 2147483632,
        },
        -- Wajaom Woodlands
        [ 266] = { params = 120255, huntId = 447 },
        [ 522] = { params = 139712, huntId = 448 },
        [ 778] = { params = 139713, huntId = 449 },
        [1034] = { params = 156098, huntId = 450 },
        -- Bhaflau Thickets
        [ 274] = { params = 121283, huntId = 451 },
        [ 530] = { params = 137668, huntId = 452 },
        [ 786] = { params = 139717, huntId = 453 },
        [1042] = { params = 157126, huntId = 454 },
        -- Mount Zhayolm
        [ 282] = { params = 139719, huntId = 455 },
        [ 538] = { params = 141768, huntId = 456 },
        [ 794] = { params = 157129, huntId = 457 },
        [1050] = { params = 156106, huntId = 458 },
        -- Mamook
        [ 290] = { params = 139723, huntId = 459 },
        [ 546] = { params = 156108, huntId = 460 },
        [ 802] = { params = 173517, huntId = 461 },
        -- Aydeewa Subterrane
        [ 298] = { params = 121294, huntId = 462 },
        [ 554] = { params = 123343, huntId = 463 },
        [ 810] = { params = 137680, huntId = 464 },
        -- Halvung
        [ 306] = { params = 156113, huntId = 465 },
        [ 562] = { params = 157138, huntId = 466 },
        [ 818] = { params = 173523, huntId = 467 },
    },

    [xi.zone.NASHMAU] =
    {
        huntMenu =
        {
            [   1] =    2097136,
            [   9] = 2147483616,
            [  17] = 2147483640,
            [  25] = 2147483632,
        },
        -- Caedarva Mire
        [ 266] = { params = 120276, huntId = 468 },
        [ 522] = { params = 139733, huntId = 469 },
        [ 778] = { params = 156118, huntId = 470 },
        [1034] = { params = 173527, huntId = 471 },
        -- Arrapago Reef
        [ 274] = { params = 155096, huntId = 472 },
        [ 530] = { params = 173530, huntId = 474 },
        -- Alzadaal Undersea Ruins
        [ 282] = { params = 156124, huntId = 476 },
        [ 538] = { params = 173533, huntId = 477 },
        [ 794] = { params = 174558, huntId = 478 },
    },

    [xi.zone.SOUTHERN_SAN_DORIA_S] =
    {
        huntMenu =
        {
            [   1] =    2096896,
            [   9] = 2147483616,
            [  17] = 2147483616,
            [  25] = 2147483616,
            [  33] = 2147483616,
            [  41] = 2147483632,
            [  49] = 2147483616,
            [  57] = 2147483616,
        },
        -- East Ronfaure [S]
        [ 266] = { params =  86495, huntId = 479 },
        [ 522] = { params =  86496, huntId = 480 },
        [ 778] = { params =  87521, huntId = 481 },
        [1034] = { params = 121314, huntId = 482 },
        -- Jugner Forest [S]
        [ 274] = { params = 103907, huntId = 483 },
        [ 530] = { params = 156132, huntId = 484 },
        [ 786] = { params = 157157, huntId = 485 },
        [1042] = { params = 173542, huntId = 486 },
        -- Vunkerl Inlet [S]
        [ 282] = { params = 121319, huntId = 487 },
        [ 538] = { params = 139752, huntId = 488 },
        [ 794] = { params = 155113, huntId = 489 },
        [1050] = { params = 156138, huntId = 490 },
        -- Batallia Downs [S]
        [ 290] = { params =  86507, huntId = 491 },
        [ 546] = { params = 103916, huntId = 492 },
        [ 802] = { params = 104941, huntId = 493 },
        [1058] = { params = 122350, huntId = 494 },
        -- The Eldieme Necropolis [S]
        [ 298] = { params = 139759, huntId = 495 },
        [ 554] = { params = 174576, huntId = 496 },
        [ 810] = { params = 174577, huntId = 497 },
        -- Beaucedine Glacier [S]
        [ 306] = { params = 156184, huntId = 536 },
        [ 562] = { params = 156185, huntId = 537 },
        [ 818] = { params = 173594, huntId = 538 },
        [1074] = { params = 174619, huntId = 539 },
        -- Xarcabard [S]
        [ 314] = { params = 156188, huntId = 540 },
        [ 570] = { params = 173597, huntId = 541 },
        [ 826] = { params = 173598, huntId = 542 },
        [1082] = { params = 174623, huntId = 543 },
    },

    [xi.zone.BASTOK_MARKETS_S] =
    {
        huntMenu =
        {
            [   1] =    2096896,
            [   9] = 2147483616,
            [  17] = 2147483616,
            [  25] = 2147483616,
            [  33] = 2147483616,
            [  41] = 2147483632,
            [  49] = 2147483616,
            [  57] = 2147483616,
        },
        -- North Gustaberg [S]
        [ 266] = { params =  86514, huntId = 498 },
        [ 522] = { params =  86515, huntId = 499 },
        [ 778] = { params =  87540, huntId = 500 },
        [1034] = { params = 121333, huntId = 501 },
        -- Grauberg [S]
        [ 274] = { params = 121334, huntId = 502 },
        [ 530] = { params = 155127, huntId = 503 },
        [ 786] = { params = 156152, huntId = 504 },
        [1042] = { params = 173561, huntId = 505 },
        -- Pashhow Marshlands [S]
        [ 282] = { params = 139770, huntId = 506 },
        [ 538] = { params = 140795, huntId = 507 },
        [ 794] = { params = 156156, huntId = 508 },
        [1050] = { params = 173565, huntId = 509 },
        -- Rolanberry Fields [S]
        [ 290] = { params = 103934, huntId = 510 },
        [ 546] = { params = 102911, huntId = 511 },
        [ 802] = { params = 104960, huntId = 512 },
        [1058] = { params = 122369, huntId = 513 },
        -- Crawlers' Nest [S]
        [ 298] = { params = 139778, huntId = 514 },
        [ 554] = { params = 156163, huntId = 515 },
        [ 810] = { params = 174596, huntId = 516 },
        -- Beaucedine Glacier [S]
        [ 306] = { params = 156184, huntId = 536 },
        [ 562] = { params = 156185, huntId = 537 },
        [ 818] = { params = 173594, huntId = 538 },
        [1074] = { params = 174619, huntId = 539 },
        -- Xarcabard [S]
        [ 314] = { params = 156188, huntId = 540 },
        [ 570] = { params = 173597, huntId = 541 },
        [ 826] = { params = 173598, huntId = 542 },
        [1082] = { params = 174623, huntId = 543 },
    },

    [xi.zone.WINDURST_WATERS_S] =
    {
        huntMenu =
        {
            [   1] =    2096896,
            [   9] = 2147483616,
            [  17] = 2147483616,
            [  25] = 2147483616,
            [  33] = 2147483616,
            [  41] = 2147483632,
            [  49] = 2147483616,
            [  57] = 2147483616,
        },
        -- West Sarutabaruta [S]
        [ 266] = { params =  17925, huntId = 517 },
        [ 522] = { params =  86534, huntId = 518 },
        [ 778] = { params =  87559, huntId = 519 },
        [1034] = { params = 121352, huntId = 520 },
        -- Fort Karugo-Narugo [S]
        [ 274] = { params =  86537, huntId = 521 },
        [ 530] = { params = 104970, huntId = 522 },
        [ 786] = { params = 102923, huntId = 523 },
        [1042] = { params = 156172, huntId = 524 },
        -- Meriphataud Mountains [S]
        [ 282] = { params = 121357, huntId = 525 },
        [ 538] = { params = 140814, huntId = 526 },
        [ 794] = { params = 156175, huntId = 527 },
        [1050] = { params = 173584, huntId = 528 },
        -- Sauromugue Champaign [S]
        [ 290] = { params =  86545, huntId = 529 },
        [ 546] = { params = 103954, huntId = 530 },
        [ 802] = { params = 106003, huntId = 531 },
        [1058] = { params = 123412, huntId = 532 },
        -- Garlaige Citadel [S]
        [ 298] = { params = 139797, huntId = 533 },
        [ 554] = { params = 174614, huntId = 534 },
        [ 810] = { params = 174615, huntId = 535 },
        -- Beaucedine Glacier [S]
        [ 306] = { params = 156184, huntId = 536 },
        [ 562] = { params = 156185, huntId = 537 },
        [ 818] = { params = 173594, huntId = 538 },
        [1074] = { params = 174619, huntId = 539 },
        -- Xarcabard [S]
        [ 314] = { params = 156188, huntId = 540 },
        [ 570] = { params = 173597, huntId = 541 },
        [ 826] = { params = 173598, huntId = 542 },
        [1082] = { params = 174623, huntId = 543 },
    }
}

--[[    0  |   0000000000   | 0000000000 |  0000
      1bit |    10 bits     |  10 bits   |  4bit
      lock |   Scyld Qty    | NM pageId #  | status
                                          (Has distinct values) ]]--

function xi.hunts.onTrigger(player, npc)
    local huntId = player:getCharVar("[hunt]id")
    local huntStatus = player:getCharVar("[hunt]status")
    local scyldBits = bit.lshift(player:getCurrency("scyld"), 14)
    local lockBit = bit.lshift(1, 24)

    -- one vana'diel day lockout timer after completing a hunt
    if os.time() < player:getCharVar("[hunt]nextHunt") then
        scyldBits = scyldBits + lockBit
    -- [hunt]status 1 player has already accepted a hunt
    elseif huntStatus == 1 then
        local pageBits = bit.lshift(huntId, 4)
        scyldBits = scyldBits + pageBits + 0x0002 -- bit displays hunt active menu
    -- [hunt]status 2 player has completed a hunt
    elseif huntStatus == 2 then
        local pageBits = bit.lshift(huntId, 4)
        scyldBits = scyldBits + pageBits + 0x000A -- bit displays completion menu
    -- stops player from taking a hunt if a regime is active
    elseif player:getCharVar("[regime]id") >= 1 then
        scyldBits = scyldBits + 0x0001 -- bit displays regime active menu
    end

    player:startEvent(1500, scyldBits, zone[player:getZoneID()].huntMenu[1])
end

function xi.hunts.onEventUpdate(player, csid, option)
    local registryZone = zone[player:getZoneID()]
    local region = registryZone[option]
    player:updateEvent(0, 0, registryZone.huntMenu[option])

    -- handles region select
    option = bit.band(option, 0xFF)
    if registryZone.huntMenu[option] then
        player:updateEvent(0, 1, registryZone.huntMenu[option])
    end

    -- gets progress of current hunt (param controls the display of kills needed)
    if option == 3 then
        player:updateEvent(1)
    end

    -- displays hunt info (kills required, 0, 0, 0, zoneId, huntId, scyld bounty+fee, ?)
    if region then
        local huntPage = hunts[region.huntId]
        local bountyBit = bit.lshift(huntPage.bounty, 10)
        local feeBit = huntPage.fee
        local scyldParam = bountyBit + feeBit
        player:updateEvent(1, 0, 0, 0, 0, region.params, scyldParam, 1)
    end
end

xi.hunts.clearHuntVars = function(player)
    player:setCharVar("[hunt]id", 0)
    player:setCharVar("[hunt]status", 0)
end

function xi.hunts.onEventFinish(player, csid, option)
    local zoneid = player:getZoneID()
    local registryZone = zone[zoneid]
    local huntEntry = hunts[bit.rshift(option, 3)]
    local msg = zones[zoneid].text

    -- accepting hunt
    if huntEntry then
        player:setCharVar("[hunt]status", 1)
        player:setCharVar("[hunt]id", bit.rshift(option, 3))
        player:delCurrency("scyld", huntEntry.fee)
        player:messageSpecial(msg.HUNT_ACCEPTED)
        player:messageSpecial(msg.USE_SCYLDS, huntEntry.fee, player:getCurrency("scyld"))

    -- cancels hunt
    elseif option == 3 then
        player:messageSpecial(msg.HUNT_CANCELED)
        player:setCharVar("[hunt]status", 0)

    -- cancels training regime and clears all vars
    elseif option == 4 then
        player:messageSpecial(msg.REGIME_CANCELED)
        xi.regime.clearRegimeVars(player)

    -- completes hunt
    elseif option == 5 then
        local huntId = player:getCharVar("[hunt]id")
        local scyldBounty = hunts[huntId].bounty
        -- give player evoliths here
        player:setCharVar("[hunt]nextHunt", getVanaMidnight())
        xi.hunts.clearHuntVars(player)

        -- scylds cap at 1000
        if player:getCurrency("scyld") + scyldBounty > 1000 then
            player:setCurrency("scyld", 1000)
        else
            player:addCurrency("scyld", scyldBounty)
        end
        player:messageSpecial(msg.HUNT_RECORDED)
        player:messageSpecial(msg.OBTAIN_SCYLDS, scyldBounty, player:getCurrency("scyld"))
    end
end

function xi.hunts.checkHunt(mob, player, mobHuntID)
    -- dead players and players out of XP range get no credit
    -- also prevents error when this function is called onMobDeath from a mob not killed by a player
    if not player or player:getHP() == 0 or player:checkDistance(mob) > 100 then
        return
    end

    local playerHuntID = player:getCharVar("[hunt]id")

    -- required NM has been defeated
    if player:getCharVar("[hunt]status") == 1 and playerHuntID == mobHuntID then
        player:messageBasic(xi.msg.basic.FOV_DEFEATED_TARGET + 20)
        player:setCharVar("[hunt]status", 2)
    end
end
