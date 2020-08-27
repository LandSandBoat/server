---------------------------------------------------------------------
-- TO DO: add "Exchange A.M.A.N. currencies" options and event trusts
---------------------------------------------------------------------
 require("scripts/globals/npc_util")
 require("scripts/globals/zone")
----------------------------------------------------------------------

tpz = tpz or {}
tpz.sparkshop = tpz.sparkshop or {}

local optionToItem = {
    [1] = { -- Items page
        [ 0] = { cost =    10, id =  4181 }, -- Scroll of Instant Warp
        [ 1] = { cost =    10, id =  4182 }, -- Scroll of Instant Reraise
        [ 2] = { cost =  7500, id =  4064 }, -- Copy of Rem's Tale, chapter 1
        [ 3] = { cost =  7500, id =  4065 }, -- Copy of Rem's Tale, chapter 2
        [ 4] = { cost =  7500, id =  4066 }, -- Copy of Rem's Tale, chapter 3
        [ 5] = { cost =  7500, id =  4067 }, -- Copy of Rem's Tale, chapter 4
        [ 6] = { cost =  7500, id =  4068 }, -- Copy of Rem's Tale, chapter 5
        [ 7] = { cost = 15000, id =  4069 }, -- Copy of Rem's Tale, chapter 6
        [ 8] = { cost = 15000, id =  4070 }, -- Copy of Rem's Tale, chapter 7
        [ 9] = { cost = 15000, id =  4071 }, -- Copy of Rem's Tale, chapter 8
        [10] = { cost = 15000, id =  4072 }, -- Copy of Rem's Tale, chapter 9
        [11] = { cost = 15000, id =  4073 }, -- Copy of Rem's Tale, chapter 10
        [12] = { cost =  5000, id = 28546 }, -- Capacity Ring
        [13] = { cost = 10000, id =  9009 }, -- Etched Memory
    },
    [2] = { -- Skill-increasing tomes
        [ 0] = { cost = 200, id = 6147 }, -- Mikehe's memo
        [ 1] = { cost = 200, id = 6148 }, -- Dagger enchiridion
        [ 2] = { cost = 200, id = 6149 }, -- Swing and Stab
        [ 3] = { cost = 200, id = 6150 }, -- Mieuseloir's diary
        [ 4] = { cost = 200, id = 6151 }, -- Striking Bull's diary
        [ 5] = { cost = 200, id = 6152 }, -- Death of Dimwits
        [ 6] = { cost = 200, id = 6153 }, -- Ludwig's report
        [ 7] = { cost = 200, id = 6154 }, -- Clash of Titans
        [ 8] = { cost = 200, id = 6155 }, -- Kagetora's diary
        [ 9] = { cost = 200, id = 6156 }, -- Noillurie's log
        [10] = { cost = 200, id = 6157 }, -- Ferreous's diary
        [11] = { cost = 200, id = 6158 }, -- Kayeel-Payeel's memoirs
        [12] = { cost = 200, id = 6159 }, -- Perih's primer
        [13] = { cost = 200, id = 6160 }, -- Barrels of Fun
        [14] = { cost = 200, id = 6161 }, -- Throwing weapon enchiridion
        [15] = { cost = 200, id = 6162 }, -- Mikehe's note
        [16] = { cost = 200, id = 6163 }, -- Sonia's diary
        [17] = { cost = 200, id = 6164 }, -- The Successor
        [18] = { cost = 200, id = 6165 }, -- Kagetora's journal
        [19] = { cost = 200, id = 6166 }, -- Altana's Hymn
        [20] = { cost = 200, id = 6167 }, -- Coveffe Barrows musings
        [21] = { cost = 200, id = 6168 }, -- Aid for All
        [22] = { cost = 200, id = 6169 }, -- Investigative report
        [23] = { cost = 200, id = 6170 }, -- Bounty list
        [24] = { cost = 200, id = 6171 }, -- Dark Deeds
        [25] = { cost = 200, id = 6172 }, -- Breezy Libretto
        [26] = { cost = 200, id = 6173 }, -- Cavernous score
        [27] = { cost = 200, id = 6174 }, -- Beaming score
        [28] = { cost = 200, id = 6175 }, -- Yomi's diagram
        [29] = { cost = 200, id = 6176 }, -- Astral Homeland
        [30] = { cost = 200, id = 6177 }, -- Life-form Study
        [31] = { cost = 200, id = 6178 }, -- Hrohj's record
        [32] = { cost = 200, id = 6179 }, -- The Bell Tolls
    },
    [3] = { -- Equipment (Lv.1 - 9)
        [ 0] = { cost = 50, id = 16385 }, -- Cesti
        [ 1] = { cost = 50, id = 16390 }, -- Bronze knuckles
        [ 2] = { cost = 50, id = 16391 }, -- Brass knuckles
        [ 3] = { cost = 50, id = 16448 }, -- Bronze dagger
        [ 4] = { cost = 50, id = 16465 }, -- Bronze knife
        [ 5] = { cost = 50, id = 16454 }, -- Blind dagger
        [ 6] = { cost = 50, id = 16471 }, -- Blind knife
        [ 7] = { cost = 50, id = 16449 }, -- Brass dagger
        [ 8] = { cost = 50, id = 16600 }, -- Wax sword
        [ 9] = { cost = 50, id = 16530 }, -- Xiphos
        [10] = { cost = 50, id = 16640 }, -- Bronze axe
        [11] = { cost = 50, id = 16641 }, -- Brass axe
        [12] = { cost = 50, id = 16704 }, -- Butterfly axe
        [13] = { cost = 50, id = 16709 }, -- Inferno axe
        [14] = { cost = 50, id = 16768 }, -- Bronze zaghnal
        [15] = { cost = 50, id = 16832 }, -- Harpoon
        [16] = { cost = 50, id = 16833 }, -- Bronze spear
        [17] = { cost = 50, id = 16896 }, -- Kunai
        [18] = { cost = 50, id = 16900 }, -- Wakizashi
        [19] = { cost = 50, id = 16966 }, -- Tachi
        [20] = { cost = 50, id = 17024 }, -- Ash club
        [21] = { cost = 50, id = 17034 }, -- Bronze mace
        [22] = { cost = 50, id = 4181  }, -- Bronze hammer
        [23] = { cost = 50, id = 17042 }, -- Bronze rod
        [24] = { cost = 50, id = 17050 }, -- Willow wand
        [25] = { cost = 50, id = 17088 }, -- Ash staff
        [26] = { cost = 50, id = 17095 }, -- Ash pole
        [27] = { cost = 50, id = 17152 }, -- Shortbow
        [28] = { cost = 50, id = 17160 }, -- Longbow
        [29] = { cost = 50, id = 17153 }, -- Self bow
        [30] = { cost = 50, id = 17216 }, -- Light crossbow
        [31] = { cost = 50, id = 19224 }, -- Musketoon
        [32] = { cost = 50, id = 17345 }, -- Flute
        [33] = { cost = 50, id = 17344 }, -- Cornette
        [34] = { cost = 50, id = 17347 }, -- Piccolo
        [35] = { cost = 50, id = 17353 }, -- Maple harp
        [36] = { cost = 50, id = 12448 }, -- Bronze cap
        [37] = { cost = 50, id = 12576 }, -- Bronze harness
        [38] = { cost = 50, id = 12704 }, -- Bronze mittens
        [39] = { cost = 50, id = 12832 }, -- Bronze subligar
        [40] = { cost = 50, id = 12960 }, -- Bronze Leggings
        [41] = { cost = 50, id = 12472 }, -- Circlet
        [42] = { cost = 50, id = 12600 }, -- Robe
        [43] = { cost = 50, id = 12728 }, -- Cuffs
        [44] = { cost = 50, id = 12856 }, -- Slops
        [45] = { cost = 50, id = 12984 }, -- Ash clogs
        [46] = { cost = 50, id = 12440 }, -- Leather bandana
        [47] = { cost = 50, id = 12568 }, -- Leather vest
        [48] = { cost = 50, id = 12696 }, -- Leather gloves
        [49] = { cost = 50, id = 12824 }, -- Leather trousers
        [50] = { cost = 50, id = 12952 }, -- Leather highboots
        [51] = { cost = 50, id = 12608 }, -- Tunic
        [52] = { cost = 50, id = 12736 }, -- Mitts
        [53] = { cost = 50, id = 12864 }, -- Slacks
        [54] = { cost = 50, id = 12992 }, -- Solea
        [55] = { cost = 50, id = 12456 }, -- Hachimaki
        [56] = { cost = 50, id = 12584 }, -- Kenpogi
        [57] = { cost = 50, id = 12712 }, -- Tekko
        [58] = { cost = 50, id = 12840 }, -- Sitabaki
        [59] = { cost = 50, id = 12968 }, -- Kyahan
        [60] = { cost = 50, id = 12289 }, -- Lauan shield
        [61] = { cost = 50, id = 12415 }, -- Shell shield
        [62] = { cost = 50, id = 12290 }, -- Maple shield
        [63] = { cost = 50, id = 12299 }, -- Aspis
    },
    [4] = { -- Equipment (Lv.10 - 19)
        [ 0] = { cost =  60, id = 16407 }, -- Brass baghnakhs
        [ 1] = { cost =  60, id = 16450 }, -- Dagger
        [ 2] = { cost =  60, id = 16466 }, -- Knife
        [ 3] = { cost =  80, id = 16455 }, -- Baselard
        [ 4] = { cost =  70, id = 16572 }, -- Bee spatha
        [ 5] = { cost =  80, id = 16531 }, -- Brass xiphos
        [ 6] = { cost = 132, id = 16536 }, -- Iron sword
        [ 7] = { cost =  60, id = 16583 }, -- Claymore
        [ 8] = { cost =  98, id = 16588 }, -- Flame Claymore
        [ 9] = { cost =  93, id = 16642 }, -- Bone axe
        [10] = { cost =  60, id = 16649 }, -- Bone pick
        [11] = { cost =  91, id = 16705 }, -- Greataxe
        [12] = { cost =  60, id = 16769 }, -- Brass zaghnal
        [13] = { cost = 177, id = 16774 }, -- Scythe
        [14] = { cost =  60, id = 16834 }, -- Brass spear
        [15] = { cost =  60, id = 18076 }, -- Spark spear
        [16] = { cost =  93, id = 16919 }, -- Shinobi-gatana
        [17] = { cost =  89, id = 16906 }, -- Mokuto
        [18] = { cost =  68, id = 16960 }, -- Uchigatana
        [19] = { cost = 135, id = 16982 }, -- Nodachi
        [20] = { cost =  60, id = 17043 }, -- Brass hammer
        [21] = { cost =  60, id = 17081 }, -- Brass rod
        [22] = { cost =  60, id = 17025 }, -- Chestnut club
        [23] = { cost =  60, id = 17051 }, -- Yew wand
        [24] = { cost =  81, id = 17035 }, -- Mace
        [25] = { cost =  60, id = 17089 }, -- Holly staff
        [26] = { cost =  60, id = 17096 }, -- Holly pole
        [27] = { cost =  99, id = 17161 }, -- Power bow
        [28] = { cost =  60, id = 17217 }, -- Crossbow
        [29] = { cost = 200, id = 17257 }, -- Bandit's gun
        [30] = { cost = 187, id = 17265 }, -- Tanegashima
        [31] = { cost =  86, id = 17351 }, -- Gemshorn
        [32] = { cost =  60, id = 17354 }, -- Harp
        [33] = { cost =  60, id = 12432 }, -- Faceguard
        [34] = { cost =  60, id = 12560 }, -- Scale mail
        [35] = { cost =  60, id = 12688 }, -- Scale finger gauntlets
        [36] = { cost =  60, id = 12816 }, -- Scale cuisses
        [37] = { cost =  60, id = 12944 }, -- Scale greaves
        [38] = { cost =  60, id = 12464 }, -- Headgear
        [39] = { cost =  60, id = 12592 }, -- Doublet
        [40] = { cost =  60, id = 12720 }, -- Gloves
        [41] = { cost =  60, id = 12848 }, -- Brais
        [42] = { cost =  60, id = 12976 }, -- Gaiters
        [43] = { cost =  65, id = 12454 }, -- Bone mask
        [44] = { cost =  60, id = 12582 }, -- Bone Harness
        [45] = { cost =  60, id = 12710 }, -- Bone mittens
        [46] = { cost =  60, id = 12834 }, -- Bone Subligar
        [47] = { cost =  60, id = 12966 }, -- Bone Leggings
        [48] = { cost =  60, id = 12441 }, -- Lizard helm
        [49] = { cost =  60, id = 12569 }, -- Lizard jerkin
        [50] = { cost =  60, id = 12697 }, -- Lizard gloves
        [51] = { cost =  60, id = 12825 }, -- Lizard trousers
        [52] = { cost =  60, id = 12953 }, -- Lizard Ledelsens
        [53] = { cost =  60, id = 12291 }, -- Elm shield
    },
    [5] = { -- Equipment (Lv.20 - 29)
        [ 0] = { cost =  87, id = 16392 }, -- Metal knuckles
        [ 1] = { cost = 144, id = 16406 }, -- Baghnakhs
        [ 2] = { cost =  99, id = 16387 }, -- Poison cesti
        [ 3] = { cost = 103, id = 16473 }, -- Kukri
        [ 4] = { cost =  96, id = 16496 }, -- Poison dagger
        [ 5] = { cost = 123, id = 16472 }, -- Poison knife
        [ 6] = { cost = 143, id = 16451 }, -- Mythril dagger
        [ 7] = { cost = 170, id = 16517 }, -- Degen
        [ 8] = { cost = 215, id = 16513 }, -- Tuck
        [ 9] = { cost = 269, id = 16532 }, -- Gladius
        [10] = { cost =  70, id = 16593 }, -- Plain sword
        [11] = { cost = 349, id = 16594 }, -- Inferno sword
        [12] = { cost = 136, id = 16643 }, -- Battleaxe
        [13] = { cost =  83, id = 17942 }, -- Tomahawk
        [14] = { cost = 209, id = 16770 }, -- Zaghnal
        [15] = { cost =  84, id = 16835 }, -- Spear
        [16] = { cost = 103, id = 17776 }, -- Hibari
        [17] = { cost = 120, id = 16907 }, -- Busuto
        [18] = { cost = 109, id = 17044 }, -- Warhammer
        [19] = { cost =  70, id = 17090 }, -- Elm staff
        [20] = { cost =  70, id = 17424 }, -- Spiked club
        [21] = { cost = 132, id = 17154 }, -- Wrapped bow
        [22] = { cost = 520, id = 17248 }, -- Arquebus
        [23] = { cost = 432, id = 17259 }, -- Pirate's gun
        [24] = { cost =  70, id = 15207 }, -- Trader's chapeau
        [25] = { cost =  71, id = 14446 }, -- Trader's saio
        [26] = { cost =  70, id = 14053 }, -- Trader's cuffs
        [27] = { cost =  70, id = 15404 }, -- Trader's slops
        [28] = { cost =  70, id = 15343 }, -- Trader's pigaches
        [29] = { cost = 171, id = 12424 }, -- Iron mask
        [30] = { cost = 264, id = 12552 }, -- Chainmail
        [31] = { cost = 141, id = 12680 }, -- Chain mittens
        [32] = { cost = 210, id = 12808 }, -- Chain hose
        [33] = { cost = 129, id = 12936 }, -- Greaves
        [34] = { cost = 195, id = 15165 }, -- Shade tiara
        [35] = { cost = 525, id = 14426 }, -- Shade harness
        [36] = { cost = 301, id = 14858 }, -- Shade mittens
        [37] = { cost = 354, id = 14327 }, -- Shade tights
        [38] = { cost = 379, id = 15315 }, -- Shade leggings
        [39] = { cost = 250, id = 15167 }, -- Eisenschaller
        [40] = { cost = 250, id = 14431 }, -- Eisenbrust
        [41] = { cost = 170, id = 14860 }, -- Eisenhentzes
        [42] = { cost = 140, id = 14329 }, -- Eisendiechlings
        [43] = { cost = 290, id = 15317 }, -- Eisenschuhs
        [44] = { cost =  70, id = 15163 }, -- Seer's crown
        [45] = { cost = 234, id = 14424 }, -- Seer's tunic
        [46] = { cost =  97, id = 14856 }, -- Seer's mitts
        [47] = { cost = 137, id = 14325 }, -- Seer's slacks
        [48] = { cost = 157, id = 15313 }, -- Seer's pumps
        [49] = { cost =  83, id = 12292 }, -- Mahogany shield
        [50] = { cost =  70, id = 12414 }, -- Turtle shield
        [51] = { cost = 153, id = 12306 }, -- Kite shield
    },
    [6] = { -- Equipment (Lv.30 - 39)
        [ 0] = { cost = 182, id = 16411 }, -- Claws
        [ 1] = { cost = 194, id = 16399 }, -- Katars
        [ 2] = { cost = 230, id = 16393 }, -- Mythril Knuckles
        [ 3] = { cost = 317, id = 19105 }, -- Thug's jambiya
        [ 4] = { cost = 248, id = 16475 }, -- Mythril kukri
        [ 5] = { cost = 198, id = 16456 }, -- Mythril baselard
        [ 6] = { cost = 334, id = 16545 }, -- Broadsword
        [ 7] = { cost = 497, id = 16576 }, -- Hunting sword
        [ 8] = { cost = 430, id = 16581 }, -- Holy sword
        [ 9] = { cost = 493, id = 16549 }, -- Divine sword
        [10] = { cost = 532, id = 18375 }, -- Falx
        [11] = { cost = 525, id = 16584 }, -- Mythril claymore
        [12] = { cost =  80, id = 17955 }, -- Plain pick
        [13] = { cost = 540, id = 16644 }, -- Mythril axe
        [14] = { cost = 297, id = 18214 }, -- Voulge
        [15] = { cost = 515, id = 16706 }, -- Heavy axe
        [16] = { cost = 154, id = 16845 }, -- Lance
        [17] = { cost = 144, id = 18078 }, -- Spark lance
        [18] = { cost = 135, id = 16836 }, -- Halberd
        [19] = { cost = 130, id = 18122 }, -- Broach lance
        [20] = { cost = 168, id = 16901 }, -- Kodachi
        [21] = { cost = 230, id = 16973 }, -- Homura
        [22] = { cost = 325, id = 16962 }, -- Ashura
        [23] = { cost = 324, id = 16970 }, -- Hosodachi
        [24] = { cost = 228, id = 17045 }, -- Maul
        [25] = { cost =  80, id = 17052 }, -- Chestnut wand
        [26] = { cost =  80, id = 17061 }, -- Mythril rod
        [27] = { cost = 226, id = 17036 }, -- Mythril mace
        [28] = { cost = 319, id = 17080 }, -- Holy maul
        [29] = { cost =  80, id = 17097 }, -- Elm pole
        [30] = { cost = 122, id = 17091 }, -- Oak staff
        [31] = { cost = 312, id = 17162 }, -- Great bow
        [32] = { cost = 125, id = 17155 }, -- Composite bow
        [33] = { cost = 171, id = 17218 }, -- Zamburak
        [34] = { cost = 340, id = 18715 }, -- Mars's hexagun
        [35] = { cost = 185, id = 18704 }, -- Darksteel hexagun
        [36] = { cost = 210, id = 17348 }, -- Traversiere
        [37] = { cost = 250, id = 17355 }, -- Rose harp
        [38] = { cost =  80, id = 15164 }, -- Garish crown
        [39] = { cost = 265, id = 14425 }, -- Garish tunic
        [40] = { cost =  84, id = 14857 }, -- Garish mitts
        [41] = { cost = 190, id = 14326 }, -- Garish slacks
        [42] = { cost = 124, id = 15314 }, -- Garish pumps
        [43] = { cost =  80, id = 15161 }, -- Noct beret
        [44] = { cost = 198, id = 14422 }, -- Noct doublet
        [45] = { cost = 136, id = 14854 }, -- Noct gloves
        [46] = { cost = 135, id = 14323 }, -- Noct brais
        [47] = { cost = 192, id = 15311 }, -- Noct gaiters
        [48] = { cost = 174, id = 12610 }, -- Cloak
        [49] = { cost =  82, id = 12738 }, -- Linen mitts
        [50] = { cost = 188, id = 12866 }, -- Linen slacks
        [51] = { cost = 110, id = 12994 }, -- Shoes
        [52] = { cost =  85, id = 12450 }, -- Padded cap
        [53] = { cost = 393, id = 12578 }, -- Padded armor
        [54] = { cost = 216, id = 12706 }, -- Iron mittens
        [55] = { cost = 316, id = 12836 }, -- Iron subligar
        [56] = { cost = 196, id = 12962 }, -- Leggings
        [57] = { cost = 125, id = 12466 }, -- Red cap
        [58] = { cost = 250, id = 12594 }, -- Gambison
        [59] = { cost =  80, id = 12722 }, -- Bracers
        [60] = { cost = 175, id = 12850 }, -- Hose
        [61] = { cost = 200, id = 12978 }, -- Socks
        [62] = { cost = 285, id = 12475 }, -- Velvet hat
        [63] = { cost = 425, id = 12603 }, -- Velvet robe
        [64] = { cost = 240, id = 12731 }, -- Velvet cuffs
        [65] = { cost = 347, id = 12859 }, -- Velvet slops
        [66] = { cost = 134, id = 12987 }, -- Ebony sabots
        [67] = { cost = 302, id = 13871 }, -- Iron visor
        [68] = { cost = 464, id = 13783 }, -- Iron scale mail
        [69] = { cost = 248, id = 14001 }, -- Iron finger gauntlets
        [70] = { cost = 226, id = 14118 }, -- Iron greaves
        [71] = { cost =  80, id = 12300 }, -- Targe
        [72] = { cost = 195, id = 12293 }, -- Oak shield
        [73] = { cost = 256, id = 12364 }, -- Nymph shield
    },
    [7] = { -- Equipment (Lv.40 - 50)
        [ 0] = { cost =  114, id = 16388 }, -- Himantes
        [ 1] = { cost =  298, id = 16412 }, -- Mythril claws
        [ 2] = { cost =  416, id = 16419 }, -- Patas
        [ 3] = { cost =  372, id = 16459 }, -- Acid baselard
        [ 4] = { cost =   90, id = 17610 }, -- Bone knife
        [ 5] = { cost =  480, id = 16522 }, -- Flame degen
        [ 6] = { cost =  680, id = 16558 }, -- Falchion
        [ 7] = { cost =  775, id = 16564 }, -- Flame blade
        [ 8] = { cost =  775, id = 16567 }, -- Knight's sword
        [ 9] = { cost =  676, id = 16590 }, -- Greatsword
        [10] = { cost =  669, id = 16957 }, -- Faussar
        [11] = { cost =  660, id = 16657 }, -- Tabar
        [12] = { cost =  740, id = 16651 }, -- Mythril pick
        [13] = { cost =  481, id = 18207 }, -- Kheten
        [14] = { cost =  690, id = 16775 }, -- Mythril scythe
        [15] = { cost =  698, id = 16796 }, -- Mythril zaghnal
        [16] = { cost = 1017, id = 18050 }, -- Mandibular sickle
        [17] = { cost =  258, id = 16847 }, -- Mythril lance
        [18] = { cost =  124, id = 16905 }, -- Bokuto
        [19] = { cost =  231, id = 16902 }, -- Sakurafubuki
        [20] = { cost =  120, id = 16908 }, -- Yoto
        [21] = { cost =  233, id = 16915 }, -- Hien
        [22] = { cost =  374, id = 16967 }, -- Mikazuki
        [23] = { cost =  112, id = 17062 }, -- Bone rod
        [24] = { cost =  136, id = 17053 }, -- Rose wand
        [25] = { cost =  156, id = 17098 }, -- Oak pole
        [26] = { cost =  105, id = 17523 }, -- Quarterstaff
        [27] = { cost =  360, id = 17163 }, -- Battle bow
        [28] = { cost =  247, id = 17156 }, -- Kaman
        [29] = { cost =  408, id = 17164 }, -- War bow
        [30] = { cost = 1200, id = 17267 }, -- Negoroshiki
        [31] = { cost =  255, id = 17219 }, -- Arbalest
        [32] = { cost =  308, id = 18710 }, -- Seadog gun
        [33] = { cost =   90, id = 17352 }, -- Horn
        [34] = { cost =  120, id = 17350 }, -- Angel's flute
        [35] = { cost =  414, id = 14243 }, -- Iron cuisses (random pants?)
        [36] = { cost =  354, id = 12416 }, -- Sallet
        [37] = { cost =  546, id = 12544 }, -- Breastplate
        [38] = { cost =  288, id = 12672 }, -- Gauntlets
        [39] = { cost =  180, id = 12800 }, -- Cuisses
        [40] = { cost =  264, id = 12928 }, -- Plate leggings
        [41] = { cost =  750, id = 15205 }, -- Alumine salade
        [42] = { cost = 1620, id = 14444 }, -- Alumine haubert
        [43] = { cost =  540, id = 14051 }, -- Alumine moufles
        [44] = { cost =  654, id = 15402 }, -- Alumine brayettes
        [45] = { cost =  534, id = 15341 }, -- Alumine sollerets
        [46] = { cost =  427, id = 12426 }, -- Banded helm
        [47] = { cost =  660, id = 12554 }, -- Banded mail
        [48] = { cost =  352, id = 12682 }, -- Mufflers
        [49] = { cost =  525, id = 12810 }, -- Breeches
        [50] = { cost =  322, id = 12938 }, -- Sollerets
        [51] = { cost =  224, id = 12444 }, -- Raptor helm
        [52] = { cost =  152, id = 12572 }, -- Raptor jerkin
        [53] = { cost =  360, id = 12700 }, -- Raptor gloves
        [54] = { cost =  216, id = 12828 }, -- Raptor trousers
        [55] = { cost =  336, id = 12956 }, -- Raptor ledelsens
        [56] = { cost =  437, id = 12417 }, -- Mythril sallet
        [57] = { cost =  750, id = 12545 }, -- Mythril breastplate
        [58] = { cost =  396, id = 12673 }, -- Mythril gauntlets
        [59] = { cost =  354, id = 12801 }, -- Mythril cuisses
        [60] = { cost =  363, id = 12929 }, -- Mythril leggings
        [61] = { cost =  437, id = 12460 }, -- Shinobi hachigane
        [62] = { cost =  660, id = 12588 }, -- Shinobi gi
        [63] = { cost =  363, id = 12716 }, -- Shinobi tekko
        [64] = { cost =  346, id = 12844 }, -- Shinobi hakama
        [65] = { cost =  338, id = 12972 }, -- Shinobi kyahan
        [66] = { cost =  448, id = 13873 }, -- Steel visor
        [67] = { cost =  688, id = 13785 }, -- Steel scale mail
        [68] = { cost =  368, id = 14003 }, -- Steel finger gauntlets
        [69] = { cost =  586, id = 14245 }, -- Steel cuisses
        [70] = { cost =  325, id = 14120 }, -- Steel greaves
        [71] = { cost =  210, id = 15242 }, -- Crow beret
        [72] = { cost =  308, id = 14498 }, -- Crow jupon
        [73] = { cost =  182, id = 14907 }, -- Crow bracers
        [74] = { cost =  287, id = 15578 }, -- Crow hose
        [75] = { cost =  385, id = 15663 }, -- Crow gaiters
        [76] = { cost =  316, id = 12307 }, -- Heater shield
        [77] = { cost =  311, id = 12301 }, -- Buckler
        [78] = { cost =  128, id = 12294 }, -- Leather shield
    },
    [8] = { -- Equipment (Lv.51 - 70)
        [ 0] = { cost =  389, id = 16394 }, -- Darksteel knuckles
        [ 1] = { cost =  484, id = 16400 }, -- Darksteel katars
        [ 2] = { cost =  362, id = 16422 }, -- Tigerfangs
        [ 3] = { cost =  200, id = 17612 }, -- Beetle knife
        [ 4] = { cost =  891, id = 16477 }, -- Cermet kukri
        [ 5] = { cost =  752, id = 16538 }, -- Darksteel sword
        [ 6] = { cost = 1018, id = 16554 }, -- Hanger
        [ 7] = { cost =  303, id = 16514 }, -- Mailbreaker
        [ 8] = { cost = 1354, id = 16541 }, -- Jagdplaute
        [ 9] = { cost =  997, id = 16585 }, -- Darksteel claymore
        [10] = { cost = 1485, id = 16596 }, -- Flamberge
        [11] = { cost = 1025, id = 16645 }, -- Darksteel axe
        [12] = { cost =  556, id = 16653 }, -- Nadziak
        [13] = { cost = 1155, id = 16730 }, -- Colossal axe
        [14] = { cost =  200, id = 16794 }, -- Bone scythe
        [15] = { cost = 1253, id = 16789 }, -- Darksteel scythe
        [16] = { cost =  735, id = 16888 }, -- Battle fork
        [17] = { cost =  483, id = 16848 }, -- Darksteel lance
        [18] = { cost =  482, id = 18093 }, -- Couse
        [19] = { cost =  546, id = 16842 }, -- Golden spear
        [20] = { cost =  402, id = 16903 }, -- Kabutowari
        [21] = { cost =  260, id = 16909 }, -- Kororito
        [22] = { cost =  632, id = 16964 }, -- Zanbato
        [23] = { cost =  795, id = 16972 }, -- Kazaridachi
        [24] = { cost =  200, id = 17054 }, -- Ebony wand
        [25] = { cost =  284, id = 17056 }, -- Mythic wand
        [26] = { cost =  435, id = 17100 }, -- Ebony pole
        [27] = { cost =  623, id = 17236 }, -- Leo crossbow
        [28] = { cost =  517, id = 17220 }, -- Heavy crossbow
        [29] = { cost =  533, id = 17242 }, -- Velocity bow
        [30] = { cost =  200, id = 17361 }, -- Crumhorn
        [31] = { cost =  200, id = 17849 }, -- Hellish bugle
        [32] = { cost =  700, id = 17359 }, -- Mythic harp
        [33] = { cost =  456, id = 12323 }, -- Scutum
        [34] = { cost =  200, id = 12311 }, -- Hoplon
        [35] = { cost =  825, id = 16170 }, -- Wivre shield
        [36] = { cost =  473, id = 12302 }, -- Darksteel buckler
        [37] = { cost =  540, id = 12308 }, -- Darksteel shield
        [38] = { cost =  281, id = 12295 }, -- Round shield
        [39] = { cost =  408, id = 12303 }, -- Gold buckler
        [40] = { cost =  395, id = 12324 }, -- Tower shield
        [41] = { cost =  560, id = 12310 }, -- Diamond shield
        [42] = { cost = 1560, id = 12383 }, -- General's shield
        [43] = { cost =  204, id = 12359 }, -- Hickory shield
    },
    [9] = { -- Equipment (Lv.71 - 98)
        [ 0] = { cost = 1033, id = 16423 }, -- Manoples
        [ 1] = { cost =  300, id = 18782 }, -- Eyra baghnakhs
        [ 2] = { cost =  300, id = 16470 }, -- Gully
        [ 3] = { cost =  687, id = 16485 }, -- Yataghan
        [ 4] = { cost =  687, id = 19138 }, -- Verus knife
        [ 5] = { cost =  687, id = 17664 }, -- Firmament
        [ 6] = { cost =  852, id = 18901 }, -- Falcata
        [ 7] = { cost = 1625, id = 19151 }, -- Bahadur
        [ 8] = { cost =  687, id = 19165 }, -- Cratus sword
        [ 9] = { cost =  866, id = 19170 }, -- Kardia faussar
        [10] = { cost =  694, id = 16660 }, -- Doom tabar
        [11] = { cost =  701, id = 18537 }, -- Maiden tabar
        [12] = { cost =  790, id = 16707 }, -- Bhuj
        [13] = { cost =  687, id = 18511 }, -- Dolor bhuj
        [14] = { cost =  687, id = 18517 }, -- Elephas axe
        [15] = { cost =  675, id = 16777 }, -- Death scythe
        [16] = { cost =  687, id = 18964 }, -- Dire scythe
        [17] = { cost =  762, id = 18555 }, -- Sectum sickle
        [18] = { cost =  795, id = 16840 }, -- Ox tongue
        [19] = { cost =  300, id = 16861 }, -- Ice lance
        [20] = { cost =  391, id = 19317 }, -- Borian spear
        [21] = { cost =  926, id = 18420 }, -- Hayabusa
        [22] = { cost =  687, id = 19285 }, -- Kakko
        [23] = { cost =  561, id = 19293 }, -- Ichi-an
        [24] = { cost =  701, id = 16971 }, -- Yukitsugu
        [25] = { cost =  391, id = 16963 }, -- Taimakuniyuki
        [26] = { cost =  300, id = 18848 }, -- Brass jadagna
        [27] = { cost =  687, id = 18875 }, -- Vodun mace
        [28] = { cost =  302, id = 18877 }, -- Robur mace
        [29] = { cost =  300, id = 17102 }, -- Eight-sided pole
        [30] = { cost =  708, id = 18621 }, -- Warmage's pole
        [31] = { cost =  516, id = 18695 }, -- Cerberus bow
        [32] = { cost =  361, id = 19733 }, -- Beursault bow
        [33] = { cost =  808, id = 17252 }, -- Culverin
        [34] = { cost =  650, id = 17213 }, -- Staurobow
        [35] = { cost =  687, id = 19265 }, -- Darkwing
        [36] = { cost =  687, id = 19267 }, -- Ribauldequin
        [37] = { cost =  656, id = 19735 }, -- Cecchino's fucile
        [38] = { cost =  644, id = 12309 }, -- Ritter shield
        [39] = { cost =  556, id = 12305 }, -- Ice shield
        [40] = { cost = 2231, id = 12387 }, -- Koenig shield
        [41] = { cost = 2755, id = 12385 }, -- Acheron shield
        [42] = { cost =  300,  id = 16189 }, -- Gleaming shield
    },
    [10] = { -- Equipment (Lv.99)
        [ 0] = { cost =  3000, id = 27740 }, -- Outrider mask
        [ 1] = { cost =  5000, id = 27881 }, -- Outrider mail
        [ 2] = { cost =  3000, id = 28029 }, -- Outrider mittens
        [ 3] = { cost =  3000, id = 28168 }, -- Outrider hose
        [ 4] = { cost =  3000, id = 28306 }, -- Outrider greaves
        [ 5] = { cost =  3000, id = 27741 }, -- Espial cap
        [ 6] = { cost =  5000, id = 27882 }, -- Espial Gambison
        [ 7] = { cost =  3000, id = 28030 }, -- Espial bracers
        [ 8] = { cost =  3000, id = 28169 }, -- Espial hose
        [ 9] = { cost =  3000, id = 28307 }, -- Espial socks
        [10] = { cost =  3000, id = 27742 }, -- Wayfarer circlet
        [11] = { cost =  5000, id = 27883 }, -- Wayfarer robe
        [12] = { cost =  3000, id = 28031 }, -- Wayfarer cuffs
        [13] = { cost =  3000, id = 28170 }, -- Wayfarer slops
        [14] = { cost =  3000, id = 28308 }, -- Wayfarer clogs
        [15] = { cost =  2000, id = 27743 }, -- Temachtiani headband
        [16] = { cost =  3000, id = 27884 }, -- Temachtiani shirt
        [17] = { cost =  2000, id = 28032 }, -- Temachtiani gloves
        [18] = { cost =  2000, id = 28171 }, -- Temachtiani pants
        [19] = { cost =  2000, id = 28309 }, -- Temachtiani boots
        [20] = { cost =  7000, id = 20540 }, -- Eminent baghnakhs
        [21] = { cost =  7000, id = 20624 }, -- Eminent dagger
        [22] = { cost =  7000, id = 20726 }, -- Eminent scimitar
        [23] = { cost =  7000, id = 20766 }, -- Eminent sword
        [24] = { cost =  7000, id = 20817 }, -- Eminent axe
        [25] = { cost =  7000, id = 20865 }, -- Eminent voulge
        [26] = { cost =  7000, id = 20908 }, -- Eminent sickle
        [27] = { cost =  7000, id = 20954 }, -- Eminent lance
        [28] = { cost =  7000, id = 20998 }, -- Kaitsuburi
        [29] = { cost =  7000, id = 21044 }, -- Ichimonji-Yofusa
        [30] = { cost =  7000, id = 21119 }, -- Eminent wand
        [31] = { cost =  7000, id = 21182 }, -- Eminent staff
        [32] = { cost =  7000, id = 21183 }, -- Eminent pole
        [33] = { cost =  7000, id = 21231 }, -- Eminent bow
        [34] = { cost =  7000, id = 21251 }, -- Eminent crossbow
        [35] = { cost =  7000, id = 21281 }, -- Eminent gun
        [36] = { cost =  7000, id = 28656 }, -- Eminent shield
        [37] = { cost =  7000, id = 21453 }, -- Eminent animator
        [38] = { cost =  7000, id = 21383 }, -- Eminent sachet
        [39] = { cost = 10000, id = 28549 }, -- Enlivened ring
        [40] = { cost = 10000, id = 28550 }, -- Vehemence ring
        [41] = { cost = 10000, id = 28551 }, -- Longshot ring
        [42] = { cost = 10000, id = 28552 }, -- Fistmele ring
        [43] = { cost = 10000, id = 28553 }, -- Perception ring
        [44] = { cost = 10000, id = 28554 }, -- Acumen ring
        [45] = { cost = 10000, id = 28499 }, -- Influx earring
        [46] = { cost = 10000, id = 28500 }, -- Upsurge earring
        [47] = { cost = 10000, id = 28501 }, -- Allegro earring
        [48] = { cost = 10000, id = 28502 }, -- Impregnable earring
        [49] = { cost = 10000, id = 28503 }, -- Flashward earring
        [50] = { cost = 10000, id = 28504 }, -- Spellbreaker earring
        [51] = { cost = 10000, id = 28547 }, -- Merirosvo ring
        [52] = { cost = 10000, id = 21462 }, -- Eminent bell
        [53] = { cost = 10000, id = 21405 }, -- Eminent flute
        [54] = { cost =  5000, id = 21302 }, -- Eminent arrow
        [55] = { cost =  5000, id = 21316 }, -- Eminent bolt
        [56] = { cost =  5000, id = 21331 }, -- Eminent bullet
        [57] = { cost =  7000, id = 21355 }, -- Hachiya shuriken
        [58] = { cost =  7000, id = 22260 }, -- Eminent animator II
    }
}

-- TO DO: add event trusts

function tpz.sparkshop.onTrade(player,npc,trade)
end

function tpz.sparkshop.onTrigger(player,npc,event)
    local sparks = player:getCurrency("Spark_of_Eminence")
    -- opens shop and lists available sparks
    player:startEvent(event,0,sparks)
end

function tpz.sparkshop.onEventUpdate(player,csid,option)
    local sparks = player:getCurrency("Spark_of_Eminence")
    local category = bit.band(option, 0xFF)
    local selection = bit.rshift(option, 16)
    local item = optionToItem[category][selection]
    local qty = bit.band(bit.rshift(option, 10), 0x3F)
    local qty = qty > 0 and qty or 1
    local cost = item.cost * qty

    -- makes sure player has room for three stacks of tomes
    if (qty > 12 and qty < 99) and player:getFreeSlotsCount() < 3 then
        player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED,item.id)
        player:updateEvent(sparks)
        return
    end

    -- handles eminent ammo
    if item.id == 21302 or item.id == 21316 or item.id == 21331 then
        qty = 99
        cost = 5000

    elseif item.id == 21355 then
        qty = 99
        cost = 7000
    end

    -- verifies and finishes transaction
    if sparks >= cost then
        if npcUtil.giveItem(player, { {item.id,qty} }) then
            sparks = sparks - cost
            player:updateEvent(sparks)
            player:delCurrency("spark_of_eminence", cost)
        end
        player:updateEvent(sparks)
    else
        player:updateEvent(sparks)
        player:messageSpecial(zones[player:getZoneID()].text.NOT_ENOUGH_SPARKS)
    end
end

function tpz.sparkshop.onEventFinish(player,csid,option)
end
