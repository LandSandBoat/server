-----------------------------------------------------
-- Hunt Registry

-- https://www.bg-wiki.com/bg/Hunts
-- https://ffxiclopedia.fandom.com/wiki/Hunt_Registry
-- https://www.bg-wiki.com/bg/Hunt_Registry
-----------------------------------------------------
require("scripts/globals/zone")
require("scripts/globals/msg")
require("scripts/globals/regimes")

tpz = tpz or {}
tpz.hunts = tpz.hunts or {}

local zone =
{
   [tpz.zone.RULUDE_GARDENS] =
   {
      msg =
      {
        6869, -- Hunt accepted!
        6870, -- You use <fee> scylds. Scyld balance: <scylds>.
        6887, -- Hunt canceled.
        6851, -- Current training regime canceled.
        6881, -- You record your hunt.
        6883, -- You obtain <scylds>! Current Balance: <scylds>.
      },
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
        [ 266] = { huntId =  52531, optionId = 2457 },
        [ 522] = { huntId =  69940, optionId = 2465 },
        [ 778] = { huntId =  86325, optionId = 2473 },
        [1034] = { huntId = 121142, optionId = 2481 },
        -- Beaucedine Glacier
        [ 274] = { huntId =  69943, optionId = 2489 },
        [ 530] = { huntId =  86328, optionId = 2497 },
        [ 786] = { huntId =  88377, optionId = 2505 },
        [1042] = { huntId = 105786, optionId = 2513 },
        -- Xarcabard
        [ 282] = { huntId =  86331, optionId = 2521 },
        [ 538] = { huntId =  86332, optionId = 2529 },
        [ 794] = { huntId = 104765, optionId = 2537 },
        [1050] = { huntId = 122174, optionId = 2545 },
        -- Uleguerand Range
        [ 290] = { huntId = 120127, optionId = 2553 },
        [ 546] = { huntId = 121152, optionId = 2561 },
        [ 802] = { huntId = 139585, optionId = 2569 },
        [1058] = { huntId = 158018, optionId = 2577 },
        -- The Sanctuary of Zi'tah
        [ 298] = { huntId =  86339, optionId = 2585 },
        [ 554] = { huntId = 103748, optionId = 2593 },
        [ 810] = { huntId = 105797, optionId = 2601 },
        [1066] = { huntId = 105798, optionId = 2609 },
        -- Ro'Maeve
        [ 306] = { huntId = 120135, optionId = 2617 },
        [ 562] = { huntId = 122184, optionId = 2625 },
        [ 818] = { huntId = 121161, optionId = 2633 },
        [1074] = { huntId = 139594, optionId = 2641 },
        -- Upper Delkfutt's Tower
        [ 314] = { huntId =  69963, optionId = 2649 },
        [ 570] = { huntId = 120140, optionId = 2657 },
        [ 826] = { huntId = 155981, optionId = 2665 },
        -- Middle Delkfutt's Tower
        [ 322] = { huntId =  52558, optionId = 2673 },
        [ 578] = { huntId =  52559, optionId = 2681 },
        [ 834] = { huntId =  52560, optionId = 2689 },
        [1090] = { huntId =  52561, optionId = 2697 },
        [1346] = { huntId =  52562, optionId = 2705 },
        [1602] = { huntId =  52563, optionId = 2713 },
        -- Lower Delkfutt's Tower
        [ 330] = { huntId =  52564, optionId = 2721 },
        [ 586] = { huntId =  52565, optionId = 2729 },
        [ 842] = { huntId =  52566, optionId = 2737 },
        [1098] = { huntId =  68951, optionId = 2745 },
        -- Ranguemont Pass
        [ 338] = { huntId =  69976, optionId = 2753 },
        [ 594] = { huntId =  86361, optionId = 2761 },
        [ 850] = { huntId = 122202, optionId = 2769 },
        -- Fei'Yin
        [ 346] = { huntId = 103771, optionId = 2777 },
        [ 602] = { huntId = 121180, optionId = 2785 },
        [ 858] = { huntId = 140637, optionId = 2793 },
        -- Castle Zvahl Baileys
        [ 354] = { huntId = 103774, optionId = 2801 },
        [ 610] = { huntId = 121183, optionId = 2809 },
        [ 866] = { huntId = 122208, optionId = 2817 },
        -- Castle Zvahl Keep
        [ 362] = { huntId = 120161, optionId = 2825 },
        [ 618] = { huntId = 120162, optionId = 2833 },
        [ 874] = { huntId = 120163, optionId = 2841 },
        [1130] = { huntId = 120164, optionId = 2849 },
        -- The Boyahda Tree
        [ 370] = { huntId = 104805, optionId = 2857 },
        [ 626] = { huntId = 122214, optionId = 2865 },
        [ 874] = { huntId = 122215, optionId = 2873 },
        [1130] = { huntId = 139624, optionId = 2881 },
        -- Habitat Unknown (Ru'lude Gardens)
        [ 378] = { huntId = 157226, optionId = 2889 },
        [ 634] = { huntId = 157227, optionId = 2897 },
        [ 890] = { huntId = 157229, optionId = 2905 },
        [1146] = { huntId = 157230, optionId = 2913 },
        [ 634] = { huntId = 174633, optionId = 2921 },
        [ 890] = { huntId = 174636, optionId = 2929 },
        [1146] = { huntId = 174639, optionId = 2937 },
      -- actual data for each hunt
      hunt =
      {
        [2457] = { pageId = 307, mobId = 17293537, bounty = 10, fee =   0 }, -- Trickster Kinetix
        [2465] = { pageId = 308, mobId = 17293389, bounty = 15, fee =   0 }, -- Slippery Sucker
        [2473] = { pageId = 309, mobId = 17293597, bounty = 15, fee =   0 }, -- Qoofim
        [2481] = { pageId = 310, mobId = 17293485, bounty = 25, fee =   0 }, -- Atkorkamuy
        [2489] = { pageId = 311, mobId = 17232044, bounty = 15, fee =   0 }, -- Kirata
        [2497] = { pageId = 312, mobId = 17232079, bounty = 15, fee =   0 }, -- Gargantua
        [2505] = { pageId = 313, mobId = 17232117, bounty = 20, fee =   0 }, -- Calcabrina
        [2513] = { pageId = 314, mobId = 17232094, bounty = 25, fee =  60 }, -- Humbaba
        [2521] = { pageId = 315, mobId = 17236180, bounty = 15, fee =   0 }, -- Shadow Eye
        [2529] = { pageId = 316, mobId = 17236146, bounty = 15, fee =   0 }, -- Duke Focalor
        [2537] = { pageId = 317, mobId = 17236045, bounty = 25, fee =   0 }, -- Timeworn Warrior
        [2545] = { pageId = 318, mobId = 17236027, bounty = 30, fee =   0 }, -- Barbaric Weapon
        [2553] = { pageId = 319, mobId = 16798056, bounty = 25, fee =   0 }, -- Bonnacon
        [2561] = { pageId = 320, mobId = 16797738, bounty = 25, fee =  70 }, -- Frost Flambeau
        [2569] = { pageId = 321, mobId = 16797770, bounty = 35, fee =  75 }, -- Skvader
        [2577] = { pageId = 322, mobId = 16797968, bounty = 40, fee =   0 }, -- Magnotaur
        [2585] = { pageId = 323, mobId = 17272915, bounty = 15, fee =   0 }, -- Elusive Edwin
        [2593] = { pageId = 324, mobId = 17272978, bounty = 20, fee =   0 }, -- Keeper of Halidom
        [2601] = { pageId = 325, mobId = 17273190, bounty = 25, fee =   0 }, -- Bastet
        [2609] = { pageId = 326, mobId = 17272958, bounty = 25, fee =   0 }, -- Huwasi
        [2617] = { pageId = 327, mobId = 17276992, bounty = 25, fee =   0 }, -- Nightmare Vase
        [2625] = { pageId = 328, mobId = 17277079, bounty = 30, fee =   0 }, -- Rogue Receptacle
        [2633] = { pageId = 329, mobId = 17277011, bounty = 25, fee =   0 }, -- Martinet
        [2641] = { pageId = 330, mobId = 17277103, bounty = 35, fee =  75 }, -- Nargun
        [2649] = { pageId = 331, mobId = 17424385, bounty = 15, fee =  35 }, -- Enkelados
        [2657] = { pageId = 332, mobId = 17424475, bounty = 25, fee =   0 }, -- Ixtab
        [2665] = { pageId = 333, mobId = 17424488, bounty = 35, fee =  85 }, -- Autarch
        [2673] = { pageId = 334, mobId = 17420324, bounty = 10, fee =   0 }, -- Eurytos
        [2681] = { pageId = 335, mobId = 17420382, bounty = 10, fee =   0 }, -- Polybotes
        [2689] = { pageId = 336, mobId = 17420417, bounty = 10, fee =   0 }, -- Rhoitos
        [2697] = { pageId = 337, mobId = 17420529, bounty = 10, fee =   0 }, -- Ophion
        [2705] = { pageId = 338, mobId = 17420555, bounty = 10, fee =   0 }, -- Rhoikos
        [2713] = { pageId = 339, mobId = 17420592, bounty = 10, fee =   0 }, -- Ogygos
        [2721] = { pageId = 340, mobId = 17530881, bounty = 10, fee =   0 }, -- Epialtes
        [2729] = { pageId = 341, mobId = 17530999, bounty = 10, fee =   0 }, -- Hippolytos
        [2737] = { pageId = 342, mobId = 17531114, bounty = 10, fee =  30 }, -- Eurymedon
        [2745] = { pageId = 343, mobId = 17530932, bounty = 10, fee =  40 }, -- Tyrant
        [2753] = { pageId = 344, mobId = 17457236, bounty = 15, fee =   0 }, -- Hyakume
        [2761] = { pageId = 345, mobId = 17457245, bounty = 15, fee =   0 }, -- Mucoid Mass
        [2769] = { pageId = 346, mobId = 17457204, bounty = 30, fee =   0 }, -- Gloom Eye
        [2777] = { pageId = 347, mobId = 17612859, bounty = 20, fee =   0 }, -- Mind Hoarder
        [2785] = { pageId = 348, mobId = 17612840, bounty = 25, fee =   0 }, -- Jenglot
        [2793] = { pageId = 349, mobId = 17612811, bounty = 35, fee =  75 }, -- Sluagh
        [2801] = { pageId = 350, mobId = 17436876, bounty = 20, fee =   0 }, -- Marquis Naberius
        [2809] = { pageId = 351, mobId = 17436714, bounty = 25, fee =   0 }, -- Likho
        [2817] = { pageId = 352, mobId = 17436881, bounty = 30, fee =  70 }, -- Marquis Sabnock
        [2825] = { pageId = 353, mobId = 17440986, bounty = 25, fee =   0 }, -- Baronet Romwe
        [2833] = { pageId = 354, mobId = 17440963, bounty = 25, fee =   0 }, -- Baron Vapula
        [2841] = { pageId = 355, mobId = 17440969, bounty = 25, fee =   0 }, -- Count Bifrons
        [2849] = { pageId = 356, mobId = 17440975, bounty = 25, fee =  65 }, -- Viscount Morax
        [2857] = { pageId = 357, mobId = 17403939, bounty = 25, fee =   0 }, -- Ellyllon
        [2865] = { pageId = 358, mobId = 17404000, bounty = 25, fee =   0 }, -- Aquarius
        [2873] = { pageId = 359, mobId = 17404029, bounty = 30, fee =   0 }, -- Unut
        [2881] = { pageId = 360, mobId = 17404300, bounty = 35, fee =  75 }, -- Leshonki
        [2889] = { pageId = 554, mobId = 17178923, bounty = 40, fee =   0 }, -- Urd
        [2897] = { pageId = 555, mobId = 17178924, bounty = 40, fee =   0 }, -- Skuld
        [2905] = { pageId = 557, mobId = 17334553, bounty = 40, fee =   0 }, -- Erebus
        [2913] = { pageId = 558, mobId = 17338598, bounty = 40, fee =   0 }, -- Feuerunke
        [2921] = { pageId = 553, mobId = 17178922, bounty = 50, fee = 125 }, -- Verthandi
        [2929] = { pageId = 556, mobId = 17334551, bounty = 50, fee = 125 }, -- Lord Ruthven
        [2937] = { pageId = 559, mobId = 17338596, bounty = 60, fee = 150 }, -- Yilbegan
      }
   },

  [tpz.zone.NORTHERN_SAN_DORIA] =
  {
      msg =
      {
        7986,
        7987,
        8004,
        7968,
        7998,
        8000,
      },

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
        [ 266] = { huntId =  17555, optionId = 1177 },
        [ 522] = { huntId =  17556, optionId = 1185 },
        [ 778] = { huntId =  17557, optionId = 1193 },
        -- East Ronfaure
        [ 274] = { huntId =  17558, optionId = 1201 },
        [ 530] = { huntId =  17559, optionId = 1209 },
        [ 786] = { huntId =  17560, optionId = 1217 },
        -- La Theine Plateau
        [ 282] = { huntId =  18585, optionId = 1225 },
        [ 538] = { huntId =  34970, optionId = 1233 },
        [ 794] = { huntId =  33947, optionId = 1241 },
        [1050] = { huntId =  52380, optionId = 1249 },
        -- Valkurm Dunes
        [ 290] = { huntId =  33999, optionId = 1257 },
        [ 546] = { huntId =  52432, optionId = 1265 },
        [ 802] = { huntId =  52433, optionId = 1273 },
        [1058] = { huntId =  68818, optionId = 1281 },
        -- Jugner Forest
        [ 298] = { huntId =  34973, optionId = 1289 },
        [ 554] = { huntId =  51358, optionId = 1297 },
        [ 810] = { huntId =  68767, optionId = 1305 },
        [1066] = { huntId =  69792, optionId = 1313 },
        -- Batallia Downs
        [ 306] = { huntId =  52385, optionId = 1321 },
        [ 562] = { huntId =  69770, optionId = 1329 },
        [ 818] = { huntId =  87203, optionId = 1337 },
        [1074] = { huntId =  87204, optionId = 1345 },
        -- Carpenters' Landing
        [ 314] = { huntId =  53413, optionId = 1353 },
        [ 570] = { huntId =  53414, optionId = 1361 },
        [ 826] = { huntId =  69799, optionId = 1369 },
        [1082] = { huntId =  68776, optionId = 1377 },
        -- Ghelsba Outpost
        [ 322] = { huntId =  18601, optionId = 1385 },
        [ 578] = { huntId =  17578, optionId = 1393 },
        [ 834] = { huntId =  34987, optionId = 1401 },
        -- Fort Ghelsba
        [ 330] = { huntId =  17580, optionId = 1409 },
        [ 586] = { huntId =  33965, optionId = 1417 },
        [ 842] = { huntId =  36014, optionId = 1425 },
        -- King Ranperre's Tomb
        [ 338] = { huntId =  34991, optionId = 1433 },
        [ 594] = { huntId =  36016, optionId = 1441 },
        [ 850] = { huntId =  52401, optionId = 1449 },
        -- Bostaunieux Oubliette
        [ 346] = { huntId = 104626, optionId = 1457 },
        [ 602] = { huntId = 123059, optionId = 1465 },
        [ 858] = { huntId = 123060, optionId = 1473 },
        -- Ordelle's Caves
        [ 354] = { huntId =  69813, optionId = 1481 },
        [ 610] = { huntId =  68790, optionId = 1489 },
        [ 866] = { huntId =  87223, optionId = 1497 },
        -- The Eldieme Necropolis
        [ 362] = { huntId = 105656, optionId = 1505 },
        [ 618] = { huntId = 105657, optionId = 1513 },
        [ 874] = { huntId = 105658, optionId = 1521 },
        [1130] = { huntId = 105659, optionId = 1529 },
        [1386] = { huntId = 105660, optionId = 1537 },
        [1642] = { huntId = 105661, optionId = 1545 },
        [1898] = { huntId = 105662, optionId = 1553 },
        [2154] = { huntId = 104639, optionId = 1561 },
        -- Davoi
        [ 370] = { huntId =  52416, optionId = 1569 },
        [ 626] = { huntId =  51393, optionId = 1577 },
        [ 882] = { huntId =  51394, optionId = 1585 },
        [1138] = { huntId =  69827, optionId = 1593 },
        [1394] = { huntId =  88260, optionId = 1601 },
        -- Habitat Unknown (Northern San d'Oria)
        [ 378] = { huntId = 157217, optionId = 1609 },
        [ 634] = { huntId = 157218, optionId = 1617 },
        [ 890] = { huntId = 174624, optionId = 1625 },

      hunt =
      {
        [1177] = { pageId = 147, mobId = 17187047, bounty =  5, fee =   0 }, -- Fungus Beetle
        [1185] = { pageId = 148, mobId = 17187111, bounty =  5, fee =   0 }, -- Jaggedy-Eared Jack
        [1193] = { pageId = 149, mobId = 17186927, bounty =  5, fee =   0 }, -- Amanita
        [1201] = { pageId = 150, mobId = 17191189, bounty =  5, fee =   0 }, -- Swamfisk
        [1209] = { pageId = 151, mobId = 17191196, bounty =  5, fee =   0 }, -- Bigmouth Billy
        [1217] = { pageId = 152, mobId = 17191044, bounty =  5, fee =   0 }, -- Rambukk
        [1225] = { pageId = 153, mobId = 17195475, bounty =  5, fee =   0 }, -- Nihniknoovi
        [1233] = { pageId = 154, mobId = 17195259, bounty =  5, fee =  15 }, -- Tumbling Truffle
        [1241] = { pageId = 155, mobId = 17195221, bounty =  5, fee =  15 }, -- Slumbering Samwell
        [1249] = { pageId = 156, mobId = 17195317, bounty = 10, fee =   0 }, -- Lumbering Lambert
        [1257] = { pageId = 207, mobId = 17199161, bounty =  5, fee =   0 }, -- Metal Shears
        [1265] = { pageId = 208, mobId = 17199564, bounty = 10, fee =   0 }, -- Golden Bat
        [1273] = { pageId = 209, mobId = 17199438, bounty = 10, fee =   0 }, -- Valkurm Emperor
        [1281] = { pageId = 210, mobId = 17199351, bounty = 10, fee =   0 }, -- Hippomaritimus
        [1289] = { pageId = 157, mobId = 17203642, bounty =  5, fee =   0 }, -- Panzer Percival
        [1297] = { pageId = 158, mobId = 17203447, bounty =  5, fee =   0 }, -- Fraelissa
        [1305] = { pageId = 159, mobId = 17203547, bounty = 10, fee =  40 }, -- Sappy Sycamore
        [1313] = { pageId = 160, mobId = 17203475, bounty = 15, fee =  40 }, -- Supplespine Mujwuj
        [1321] = { pageId = 161, mobId = 17207476, bounty = 10, fee =  25 }, -- Tottering Toby
        [1329] = { pageId = 162, mobId = 17207410, bounty = 10, fee =  40 }, -- Skirling Liger
        [1337] = { pageId = 163, mobId = 17207608, bounty = 20, fee =   0 }, -- Eyegouger
        [1345] = { pageId = 164, mobId = 17207640, bounty = 20, fee =   0 }, -- Prankster Maverix
        [1353] = { pageId = 165, mobId = 16785723, bounty = 10, fee =   0 }, -- Hercules Beetle
        [1361] = { pageId = 166, mobId = 16785722, bounty = 10, fee =  30 }, -- Mycophile
        [1369] = { pageId = 167, mobId = 16785676, bounty = 15, fee =   0 }, -- Orctrap
        [1377] = { pageId = 168, mobId = 16785593, bounty = 10, fee =   0 }, -- Tempest Tigon
        [1385] = { pageId = 169, mobId = 17350800, bounty =  5, fee =   0 }, -- Orcish Wallbreacher
        [1393] = { pageId = 170, mobId = 17350826, bounty =  5, fee =   0 }, -- Thousandarm Deshglesh
        [1401] = { pageId = 171, mobId = 17350801, bounty =  5, fee =   0 }, -- Orcish Barricader
        [1409] = { pageId = 172, mobId = 17354828, bounty =  5, fee =  10 }, -- Hundredscar Hajwaj
        [1417] = { pageId = 173, mobId = 17354922, bounty =  5, fee =   0 }, -- Kegpaunch Doshgnosh
        [1425] = { pageId = 174, mobId = 17354896, bounty =  5, fee =   0 }, -- Chariotbuster Byakzak
        [1433] = { pageId = 175, mobId = 17555721, bounty =  5, fee =   0 }, -- Barbastelle
        [1441] = { pageId = 176, mobId = 17555709, bounty =  5, fee =   0 }, -- Ankou
        [1449] = { pageId = 177, mobId = 17555664, bounty = 10, fee =   0 }, -- Gwyllgi
        [1457] = { pageId = 178, mobId = 17461433, bounty = 25, fee =   0 }, -- Arioch
        [1465] = { pageId = 179, mobId = 17461315, bounty = 30, fee =   0 }, -- Shii
        [1473] = { pageId = 180, mobId = 17461471, bounty = 30, fee =   0 }, -- Manes
        [1481] = { pageId = 181, mobId = 17567801, bounty = 15, fee =  40 }, -- Donggu
        [1489] = { pageId = 182, mobId = 17568132, bounty = 10, fee =  40 }, -- Bombast
        [1497] = { pageId = 183, mobId = 17567901, bounty = 20, fee =   0 }, -- Agar Agar
        [1505] = { pageId = 184, mobId = 17575938, bounty = 25, fee =   0 }, -- Skull of Gluttony
        [1513] = { pageId = 185, mobId = 17575939, bounty = 25, fee =   0 }, -- Skull of Greed
        [1521] = { pageId = 186, mobId = 17575940, bounty = 25, fee =   0 }, -- Skull of Sloth
        [1529] = { pageId = 187, mobId = 17575941, bounty = 25, fee =   0 }, -- Skull of Lust
        [1537] = { pageId = 188, mobId = 17575942, bounty = 25, fee =   0 }, -- Skull of Pride
        [1545] = { pageId = 189, mobId = 17575943, bounty = 25, fee =   0 }, -- Skull of Envy
        [1553] = { pageId = 190, mobId = 17575944, bounty = 25, fee =   0 }, -- Skull of Wrath
        [1561] = { pageId = 191, mobId = 17576054, bounty = 25, fee =   0 }, -- Cwn Cyrff
        [1569] = { pageId = 192, mobId = 17387567, bounty = 10, fee =  25 }, -- Hawkeyed Dnatbat
        [1577] = { pageId = 193, mobId = 17387606, bounty =  5, fee =   0 }, -- Tigerbane Bakdak
        [1585] = { pageId = 194, mobId = 17387585, bounty =  5, fee =   0 }, -- Steelbiter Gudrud
        [1593] = { pageId = 195, mobId = 17387644, bounty = 15, fee =  35 }, -- Poisonhand Gnadgad
        [1601] = { pageId = 196, mobId = 17387920, bounty = 20, fee =   0 }, -- Blubbery Bulge
        [1609] = { pageId = 545, mobId = 17109384, bounty = 40, fee =   0 }, -- Yacumama
        [1617] = { pageId = 546, mobId = 17109385, bounty = 40, fee =   0 }, -- Capricornus
        [1625] = { pageId = 544, mobId = 17113490, bounty = 50, fee = 125 }, -- Krabkatoa
      }
  },

  [tpz.zone.BASTOK_MINES] =
  {
      msg =
      {
        7287,
        7288,
        7305,
        7269,
        7299,
        7301,
      },

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
        [ 266] = { huntId =  17605, optionId = 1577 },
        [ 522] = { huntId =  17606, optionId = 1585 },
        [ 778] = { huntId =  17607, optionId = 1593 },
        -- South Gustaberg
        [ 274] = { huntId =  17608, optionId = 1601 },
        [ 530] = { huntId =  17609, optionId = 1609 },
        [ 786] = { huntId =  17610, optionId = 1617 },
        -- Konschtat Highlands
        [ 282] = { huntId =  35019, optionId = 1625 },
        [ 538] = { huntId =  33996, optionId = 1633 },
        [ 794] = { huntId =  52429, optionId = 1641 },
        [1050] = { huntId =  52430, optionId = 1649 },
        -- Valkurm Dunes
        [ 290] = { huntId =  33999, optionId = 1657 },
        [ 546] = { huntId =  52432, optionId = 1665 },
        [ 802] = { huntId =  52433, optionId = 1673 },
        [1058] = { huntId =  68818, optionId = 1681 },
        -- Pashhow Marshlands
        [ 298] = { huntId =  35027, optionId = 1689 },
        [ 554] = { huntId =  52436, optionId = 1697 },
        [ 810] = { huntId =  69845, optionId = 1705 },
        [1066] = { huntId =  69846, optionId = 1713 },
        -- Rolanberry Fields
        [ 306] = { huntId =  52439, optionId = 1721 },
        [ 562] = { huntId =  69848, optionId = 1729 },
        [ 818] = { huntId =  68825, optionId = 1737 },
        [1074] = { huntId =  87258, optionId = 1745 },
        -- Palborough Mines
        [ 314] = { huntId =  17627, optionId = 1753 },
        [ 570] = { huntId =  35036, optionId = 1761 },
        [ 826] = { huntId =  34013, optionId = 1769 },
        [1082] = { huntId =  35038, optionId = 1777 },
        -- Dangruf Wadi
        [ 322] = { huntId =  35039, optionId = 1785 },
        [ 578] = { huntId =  36064, optionId = 1793 },
        [ 834] = { huntId =  53473, optionId = 1801 },
        -- Korroloka Tunnel
        [ 330] = { huntId =  53474, optionId = 1809 },
        [ 586] = { huntId =  53475, optionId = 1817 },
        [ 842] = { huntId =  54500, optionId = 1825 },
        [1098] = { huntId =  68837, optionId = 1833 },
        -- Gusgen Mines
        [ 338] = { huntId =  69862, optionId = 1841 },
        [ 594] = { huntId =  69863, optionId = 1849 },
        [ 850] = { huntId =  69864, optionId = 1857 },
        [1106] = { huntId =  69865, optionId = 1865 },
        [1362] = { huntId =  69866, optionId = 1873 },
        [1618] = { huntId =  69867, optionId = 1881 },
        -- Crawlers' Nest
        [ 346] = { huntId = 104684, optionId = 1889 },
        [ 602] = { huntId = 103661, optionId = 1897 },
        [ 858] = { huntId = 138478, optionId = 1905 },
        -- Beadeaux
        [ 354] = { huntId =  35055, optionId = 1913 },
        [ 610] = { huntId =  52464, optionId = 1921 },
        [ 866] = { huntId =  52465, optionId = 1929 },
        [1122] = { huntId =  69874, optionId = 1937 },
        [1378] = { huntId =  86259, optionId = 1945 },
        -- Oldton Movalpolos
        [ 362] = { huntId =  86260, optionId = 1953 },
        [ 618] = { huntId =  88309, optionId = 1961 },
        [ 874] = { huntId =  86262, optionId = 1969 },
        -- Newton Movalpolos
        [ 370] = { huntId = 139511, optionId = 1977 },
        [ 626] = { huntId = 140536, optionId = 1985 },
        [ 882] = { huntId = 155897, optionId = 1993 },
        -- Habitat Unknown (Bastok Mines)
        [ 378] = { huntId = 157220, optionId = 2001 },
        [ 634] = { huntId = 157221, optionId = 2009 },
        [ 890] = { huntId = 174627, optionId = 2017 },

      hunt =
      {
        [1577] = { pageId = 197, mobId = 17211561, bounty =  5, fee =   0 }, -- Stinging Sophie
        [1585] = { pageId = 198, mobId = 17211714, bounty =  5, fee =   0 }, -- Maighdean Uaine
        [1593] = { pageId = 199, mobId = 17211666, bounty =  5, fee =   0 }, -- Bedrock Barry
        [1601] = { pageId = 200, mobId = 17215888, bounty =  5, fee =   0 }, -- Leaping Lizzy
        [1609] = { pageId = 201, mobId = 17215778, bounty =  5, fee =   0 }, -- Tococo
        [1617] = { pageId = 202, mobId = 17215626, bounty =  5, fee =  10 }, -- Carnero
        [1625] = { pageId = 203, mobId = 17219933, bounty =  5, fee =   0 }, -- Stray Mary
        [1633] = { pageId = 204, mobId = 17219619, bounty =  5, fee =   0 }, -- Ghillie Dhu
        [1641] = { pageId = 205, mobId = 17219886, bounty = 10, fee =   0 }, -- Rampaging Ram
        [1649] = { pageId = 206, mobId = 17219787, bounty = 10, fee =  25 }, -- Highlander Lizard
        [1657] = { pageId = 207, mobId = 17199161, bounty =  5, fee =   0 }, -- Metal Shears
        [1665] = { pageId = 208, mobId = 17199564, bounty = 10, fee =   0 }, -- Golden Bat
        [1673] = { pageId = 209, mobId = 17199438, bounty = 10, fee =   0 }, -- Valkurm Emperor
        [1681] = { pageId = 210, mobId = 17199351, bounty = 10, fee =   0 }, -- Hippomaritimus
        [1689] = { pageId = 211, mobId = 17224019, bounty =  5, fee =   0 }, -- Bloodpool Vorax
        [1697] = { pageId = 212, mobId = 17223889, bounty = 10, fee =   0 }, -- Jolly Green
        [1705] = { pageId = 213, mobId = 17223982, bounty = 15, fee =   0 }, -- Toxic Tamlyn
        [1713] = { pageId = 214, mobId = 17223797, bounty = 15, fee =  40 }, -- Ni'Zho Bladebender
        [1721] = { pageId = 215, mobId = 17227992, bounty = 10, fee =   0 }, -- Black Triple Stars
        [1729] = { pageId = 216, mobId = 17228236, bounty = 15, fee =   0 }, -- Drooling Daisy
        [1737] = { pageId = 217, mobId = 17228086, bounty = 10, fee =   0 }, -- Ravenous Crawler
        [1745] = { pageId = 218, mobId = 17228150, bounty = 20, fee =   0 }, -- Eldritch Edge
        [1753] = { pageId = 219, mobId = 17363181, bounty =  5, fee =   0 }, -- Bu'Ghi Howlblade
        [1761] = { pageId = 220, mobId = 17363208, bounty =  5, fee =  15 }, -- Zi'Ghi Boneeater
        [1769] = { pageId = 221, mobId = 17363080, bounty =  5, fee =   0 }, -- Qu'Vho Deathhurler
        [1777] = { pageId = 222, mobId = 17363258, bounty =  5, fee =   0 }, -- Be'Hya Hundredwall
        [1785] = { pageId = 223, mobId = 17559584, bounty =  5, fee =   0 }, -- Teporingo
        [1793] = { pageId = 224, mobId = 17559869, bounty =  5, fee =   0 }, -- Chocoboleech
        [1801] = { pageId = 225, mobId = 17559558, bounty = 10, fee =   0 }, -- Geyser Lizard
        [1809] = { pageId = 226, mobId = 17485980, bounty = 10, fee =   0 }, -- Cargo Crab Colin
        [1817] = { pageId = 227, mobId = 17486031, bounty = 10, fee =   0 }, -- Falcatus Aranei
        [1825] = { pageId = 228, mobId = 17486129, bounty = 15, fee =   0 }, -- Dame Blanche
        [1833] = { pageId = 229, mobId = 17486171, bounty = 10, fee =  40 }, -- Thoon
        [1841] = { pageId = 230, mobId = 17580039, bounty = 15, fee =   0 }, -- Smothered Schmidt
        [1849] = { pageId = 231, mobId = 17580040, bounty = 15, fee =   0 }, -- Crushed Krause
        [1857] = { pageId = 232, mobId = 17580041, bounty = 15, fee =   0 }, -- Pulverized Pfeffer
        [1865] = { pageId = 233, mobId = 17580042, bounty = 15, fee =   0 }, -- Burned Bergmann
        [1873] = { pageId = 234, mobId = 17580043, bounty = 15, fee =   0 }, -- Wounded Wurfel
        [1881] = { pageId = 235, mobId = 17580044, bounty = 15, fee =   0 }, -- Asphyxiated Amsel
        [1889] = { pageId = 236, mobId = 17584398, bounty = 25, fee =   0 }, -- Demonic Tiphia
        [1897] = { pageId = 237, mobId = 17584312, bounty = 20, fee =   0 }, -- Dynast Beetle
        [1905] = { pageId = 238, mobId = 17584416, bounty = 30, fee =   0 }, -- Aqrabuamelu
        [1913] = { pageId = 239, mobId = 17379351, bounty =  5, fee =  20 }, -- Bi'Gho Headtaker
        [1921] = { pageId = 240, mobId = 17379450, bounty = 10, fee =   0 }, -- Ge'Dha Evileye
        [1929] = { pageId = 241, mobId = 17154195, bounty = 10, fee =  25 }, -- Da'Dha Hundredmask
        [1937] = { pageId = 242, mobId = 17379564, bounty = 15, fee =   0 }, -- Zo'Khu Blackcloud
        [1945] = { pageId = 243, mobId = 17379626, bounty = 15, fee =  45 }, -- Ga'Bhu Unvanquished
        [1953] = { pageId = 244, mobId = 16822427, bounty = 15, fee =  45 }, -- Bugbear Strongman
        [1961] = { pageId = 245, mobId = 16822459, bounty = 20, fee =   0 }, -- Goblin Wolfman
        [1969] = { pageId = 246, mobId = 16822322, bounty = 15, fee =  50 }, -- Bugbear Muscleman
        [1977] = { pageId = 247, mobId = 16826517, bounty = 35, fee =  75 }, -- Swashstox Beadblinker
        [1985] = { pageId = 248, mobId = 16826570, bounty = 35, fee =  75 }, -- Bugbear Matman
        [1993] = { pageId = 249, mobId = 16826474, bounty = 35, fee =  80 }, -- Sword Sorcerer Solisoq
        [2001] = { pageId = 548, mobId = 17138077, bounty = 40, fee =   0 }, -- Shoggoth
        [2009] = { pageId = 549, mobId = 17138078, bounty = 40, fee =   0 }, -- Lamprey Lord
        [2017] = { pageId = 547, mobId = 17138070, bounty = 50, fee = 125 }, -- Blobdingnag
      }
  },

  [tpz.zone.PORT_WINDURST] =
  {
      msg =
      {
          32,
          33,
          50,
          14,
          44,
          46,
      },

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
        [ 266] = { huntId =  17658, optionId = 2001 },
        [ 522] = { huntId =  17659, optionId = 2009 },
        [ 778] = { huntId =  17660, optionId = 2017 },
        -- East Sarutabaruta
        [ 274] = { huntId =  17661, optionId = 2025 },
        [ 530] = { huntId =  17662, optionId = 2033 },
        [ 786] = { huntId =  17663, optionId = 2041 },
        -- Tahrongi Canyon
        [ 282] = { huntId =  18688, optionId = 2049 },
        [ 538] = { huntId =  35073, optionId = 2057 },
        [ 794] = { huntId =  36098, optionId = 2065 },
        [1050] = { huntId =  52483, optionId = 2073 },
        -- Buburimu Peninsula
        [ 290] = { huntId =  34052, optionId = 2081 },
        [ 546] = { huntId =  52485, optionId = 2089 },
        [ 802] = { huntId =  52486, optionId = 2097 },
        [1058] = { huntId =  69895, optionId = 2105 },
        -- Bibiki Bay
        [ 298] = { huntId =  69896, optionId = 2113 },
        [ 554] = { huntId =  86281, optionId = 2121 },
        [ 810] = { huntId =  86282, optionId = 2129 },
        [1066] = { huntId = 122123, optionId = 2137 },
        -- Meriphataud Mountains
        [ 306] = { huntId =  52492, optionId = 2145 },
        [ 562] = { huntId =  52493, optionId = 2153 },
        [ 818] = { huntId =  68878, optionId = 2161 },
        [1074] = { huntId =  87311, optionId = 2169 },
        -- Sauromugue Champaign
        [ 314] = { huntId =  69904, optionId = 2177 },
        [ 570] = { huntId =  69905, optionId = 2185 },
        [ 826] = { huntId =  86290, optionId = 2193 },
        [1082] = { huntId =  87315, optionId = 2201 },
        -- Attohwa Chasm
        [ 322] = { huntId =  86292, optionId = 2209 },
        [ 578] = { huntId = 123157, optionId = 2217 },
        [ 834] = { huntId = 123157, optionId = 2225 },
        [1090] = { huntId = 139543, optionId = 2233 },
        -- Giddeus
        [ 330] = { huntId =  17688, optionId = 2241 },
        [ 586] = { huntId =  35097, optionId = 2249 },
        [ 842] = { huntId =  35098, optionId = 2257 },
        [1098] = { huntId =  34075, optionId = 2265 },
        -- Toraimarai Canal
        [ 338] = { huntId = 122140, optionId = 2273 },
        [ 594] = { huntId = 139549, optionId = 2281 },
        [ 850] = { huntId = 155934, optionId = 2289 },
        -- Inner Horutoto Ruins
        [ 346] = { huntId =  35103, optionId = 2297 },
        [ 602] = { huntId =  36128, optionId = 2305 },
        [ 858] = { huntId =  35105, optionId = 2313 },
        -- Outer Horutoto Ruins
        [ 354] = { huntId =  35106, optionId = 2321 },
        [ 610] = { huntId =  52515, optionId = 2329 },
        [ 866] = { huntId =  52540, optionId = 2337 },
        -- Maze of Shakhrami
        [ 362] = { huntId =  69925, optionId = 2345 },
        [ 618] = { huntId =  68902, optionId = 2353 },
        [ 874] = { huntId =  86311, optionId = 2361 },
        -- Labyrinth of Onzozo
        [ 370] = { huntId = 104744, optionId = 2369 },
        [ 626] = { huntId = 104745, optionId = 2377 },
        [ 882] = { huntId = 122154, optionId = 2385 },
        [1138] = { huntId = 137515, optionId = 2393 },
        -- Garlaige Citadel
        [ 378] = { huntId = 104748, optionId = 2401 },
        [ 634] = { huntId = 104749, optionId = 2409 },
        [ 890] = { huntId = 121134, optionId = 2417 },
        -- Castle Oztroja
        [ 386] = { huntId =  52527, optionId = 2425 },
        [ 642] = { huntId =  68912, optionId = 2433 },
        [ 898] = { huntId =  69937, optionId = 2441 },
        [1154] = { huntId =  68914, optionId = 2449 },
        -- Habitat Unknown (Port Windurst)
        [ 394] = { huntId = 157223, optionId = 2457 },
        [ 650] = { huntId = 157224, optionId = 2465 },
        [ 898] = { huntId = 174630, optionId = 2473 },

      hunt =
      {
        [2001] = { pageId = 250, mobId = 17248468, bounty =  5, fee =   0 }, -- Tom Tit Tat
        [2009] = { pageId = 251, mobId = 17248517, bounty =  5, fee =   0 }, -- Nunyenunc
        [2017] = { pageId = 252, mobId = 17093009, bounty =  5, fee =   0 }, -- Numbing Norman
        [2025] = { pageId = 253, mobId = 17252657, bounty =  5, fee =   0 }, -- Spiny Spipi
        [2033] = { pageId = 254, mobId = 17252489, bounty =  5, fee =   0 }, -- Sharp-Eared Ropipi
        [2041] = { pageId = 255, mobId = 17252725, bounty =  5, fee =   0 }, -- Duke Decapod
        [2049] = { pageId = 256, mobId = 17256900, bounty =  5, fee =  10 }, -- Yara Ma Yha Who
        [2057] = { pageId = 257, mobId = 17256690, bounty =  5, fee =   0 }, -- Serpopard Ishtar
        [2065] = { pageId = 258, mobId = 17256493, bounty =  5, fee =   0 }, -- Habrok
        [2073] = { pageId = 259, mobId = 17256836, bounty = 10, fee =   0 }, -- Herbage Hunter
        [2081] = { pageId = 260, mobId = 17260732, bounty =  5, fee =   0 }, -- Wake Warder Wanda
        [2089] = { pageId = 261, mobId = 17261003, bounty = 10, fee =   0 }, -- Buburimboo
        [2097] = { pageId = 262, mobId = 17260907, bounty = 10, fee =   0 }, -- Helldiver
        [2105] = { pageId = 263, mobId = 17260613, bounty = 15, fee =  35 }, -- Backoo
        [2113] = { pageId = 264, mobId = 16793646, bounty = 15, fee =   0 }, -- Serra
        [2121] = { pageId = 265, mobId = 16793742, bounty = 15, fee =   0 }, -- Intulo
        [2129] = { pageId = 266, mobId = 16793698, bounty = 15, fee =   0 }, -- Shankha
        [2137] = { pageId = 267, mobId = 16793776, bounty = 30, fee =  65 }, -- Splacknuck
        [2145] = { pageId = 268, mobId = 17264818, bounty = 10, fee =   0 }, -- Daggerclaw Dracos
        [2153] = { pageId = 269, mobId = 17264972, bounty = 10, fee =   0 }, -- Patripatan
        [2161] = { pageId = 270, mobId = 17264722, bounty = 10, fee =   0 }, -- Chonchon
        [2169] = { pageId = 271, mobId = 17264768, bounty = 20, fee =  45 }, -- Naa Zeku the Unwaiting
        [2177] = { pageId = 272, mobId = 17268851, bounty = 15, fee =   0 }, -- Deadly Dodo
        [2185] = { pageId = 273, mobId = 17268788, bounty = 15, fee =   0 }, -- Bashe
        [2193] = { pageId = 274, mobId = 17268816, bounty = 15, fee =   0 }, -- Thunderclaw Thuban
        [2201] = { pageId = 275, mobId = 17269016, bounty = 20, fee =   0 }, -- Blighting Brand
        [2209] = { pageId = 276, mobId = 16805962, bounty = 15, fee =   0 }, -- Sekhmet
        [2217] = { pageId = 277, mobId = 16806249, bounty = 30, fee =   0 }, -- Ambusher Antlion
        [2225] = { pageId = 278, mobId = 16806162, bounty = 30, fee =   0 }, -- Citipati
        [2233] = { pageId = 279, mobId = 16806117, bounty = 35, fee =  75 }, -- Sargas
        [2241] = { pageId = 280, mobId = 17371300, bounty =  5, fee =   0 }, -- Juu Duzu the Whirlwind
        [2249] = { pageId = 281, mobId = 17371515, bounty =  5, fee =  15 }, -- Hoo Mjuu the Torrent
        [2257] = { pageId = 282, mobId = 17371578, bounty =  5, fee =   0 }, -- Vuu Puqu the Beguiler
        [2265] = { pageId = 283, mobId = 17371399, bounty =  5, fee =   0 }, -- Quu Xijo the Illusory
        [2273] = { pageId = 284, mobId = 17469578, bounty = 30, fee =   0 }, -- Canal Moocher
        [2281] = { pageId = 285, mobId = 17469632, bounty = 35, fee =  75 }, -- Konjac
        [2289] = { pageId = 286, mobId = 17469747, bounty = 35, fee =   0 }, -- Brazen Bones
        [2297] = { pageId = 287, mobId = 17563801, bounty =  5, fee =   0 }, -- Nocuous Weapon
        [2305] = { pageId = 288, mobId = 17563749, bounty =  5, fee =   0 }, -- Maltha
        [2313] = { pageId = 289, mobId = 17563785, bounty =  5, fee =   0 }, -- Slendlix Spindlethumb
        [2321] = { pageId = 290, mobId = 17571870, bounty =  5, fee =   0 }, -- Desmodont
        [2329] = { pageId = 291, mobId = 17571903, bounty = 10, fee =   0 }, -- Ah Puch
        [2337] = { pageId = 292, mobId = 17571873, bounty = 10, fee =   0 }, -- Legalox Heftyhind
        [2345] = { pageId = 293, mobId = 17588278, bounty = 15, fee =   0 }, -- Trembler Tabitha
        [2353] = { pageId = 294, mobId = 17588589, bounty = 10, fee =   0 }, -- Lesath
        [2361] = { pageId = 295, mobId = 17588469, bounty = 15, fee =   0 }, -- Gloombound Lurker
        [2369] = { pageId = 296, mobId = 17649795, bounty = 25, fee =  60 }, -- Hellion
        [2377] = { pageId = 297, mobId = 17649761, bounty = 25, fee =   0 }, -- Peg Powler
        [2385] = { pageId = 298, mobId = 17649818, bounty = 30, fee =   0 }, -- Soulstealer Skullnix
        [2393] = { pageId = 299, mobId = 17649784, bounty = 30, fee =  75 }, -- Narasimha
        [2401] = { pageId = 300, mobId = 17596520, bounty = 25, fee =   0 }, -- Hazmat
        [2409] = { pageId = 301, mobId = 17596628, bounty = 25, fee =   0 }, -- Hovering Hotpot
        [2417] = { pageId = 302, mobId = 17596599, bounty = 25, fee =   0 }, -- Frogamander
        [2425] = { pageId = 303, mobId = 17395816, bounty = 10, fee =  25 }, -- Moo Ouzi the Swiftblade
        [2433] = { pageId = 304, mobId = 17395731, bounty = 10, fee =   0 }, -- Saa Doyi the Fervid
        [2441] = { pageId = 305, mobId = 17395954, bounty = 15, fee =  40 }, -- Yaa Haqa the Profane
        [2449] = { pageId = 306, mobId = 17395896, bounty = 10, fee =  40 }, -- Lii Jixa the Somnolist
        [2457] = { pageId = 551, mobId = 17174909, bounty = 40, fee =   0 }, -- Jyeshtha
        [2465] = { pageId = 552, mobId = 17174908, bounty = 40, fee =   0 }, -- Farruca Fly
        [2473] = { pageId = 550, mobId = 17174907, bounty = 50, fee = 125 }, -- Orcus
      }
  },

  [tpz.zone.KAZHAM] =
  {
      msg =
      {
        6837,
        6838,
        6855,
        6819,
        6849,
        6851,
      },

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
        [ 266] = { huntId =  68969, optionId = 2889 },
        [ 522] = { huntId =  86378, optionId = 2897 },
        [ 778] = { huntId = 104811, optionId = 2905 },
        [1034] = { huntId = 123244, optionId = 2913 },
        -- Yhoator Jungle
        [ 274] = { huntId =  86381, optionId = 2921 },
        [ 530] = { huntId =  88430, optionId = 2929 },
        [ 786] = { huntId = 121199, optionId = 2937 },
        [1042] = { huntId = 122224, optionId = 2945 },
        -- Sea Serpent Grotto
        [ 282] = { huntId =  70001, optionId = 2953 },
        [ 538] = { huntId =  71026, optionId = 2961 },
        [ 794] = { huntId =  72051, optionId = 2969 },
        [1050] = { huntId =  88436, optionId = 2977 },
        [1306] = { huntId =  88437, optionId = 2985 },
        [1562] = { huntId =  86390, optionId = 2993 },
        [1818] = { huntId = 104823, optionId = 3001 },
        [2074] = { huntId = 102776, optionId = 3009 },
        [2330] = { huntId = 102777, optionId = 3017 },
        [2586] = { huntId = 102778, optionId = 3025 },
        [2842] = { huntId = 102779, optionId = 3033 },
        [3098] = { huntId = 102780, optionId = 3041 },
        [3354] = { huntId = 104829, optionId = 3049 },
        [3610] = { huntId = 122238, optionId = 3057 },
        -- Temple of Uggalepih
        [ 290] = { huntId = 104831, optionId = 3065 },
        [ 546] = { huntId = 103808, optionId = 3073 },
        [ 802] = { huntId = 105857, optionId = 3081 },
        [1058] = { huntId = 105858, optionId = 3089 },
        [1314] = { huntId = 105859, optionId = 3097 },
        [1570] = { huntId = 102788, optionId = 3105 },
        [1826] = { huntId = 102789, optionId = 3113 },
        [2082] = { huntId = 105862, optionId = 3121 },
        [2338] = { huntId = 123271, optionId = 3129 },
        [2594] = { huntId = 123272, optionId = 3137 },
        -- Den of Rancor
        [ 298] = { huntId = 102793, optionId = 3145 },
        [ 554] = { huntId = 122250, optionId = 3153 },
        [ 810] = { huntId = 122251, optionId = 3161 },
        [1066] = { huntId = 122252, optionId = 3169 },
        [1322] = { huntId = 122253, optionId = 3177 },
        [1578] = { huntId = 139662, optionId = 3185 },
        -- Ifrit's Cauldron
        [ 306] = { huntId = 122255, optionId = 3193 },
        [ 562] = { huntId = 122256, optionId = 3201 },
        [ 818] = { huntId = 122257, optionId = 3209 },
        [1074] = { huntId = 139666, optionId = 3217 },
        [1330] = { huntId = 140691, optionId = 3225 },

      hunt =
      {
        [2889] = { pageId = 361, mobId = 17281061, bounty = 10, fee =   0 }, -- Koropokkur
        [2897] = { pageId = 362, mobId = 17281149, bounty = 15, fee =   0 }, -- Mischievous Micholas
        [2905] = { pageId = 363, mobId = 17281388, bounty = 25, fee =   0 }, -- Bayawak
        [2913] = { pageId = 364, mobId = 17281296, bounty = 30, fee =   0 }, -- Pyuu the Spatemaker
        [2921] = { pageId = 365, mobId = 17285248, bounty = 15, fee =  45 }, -- Powderer Penny
        [2929] = { pageId = 366, mobId = 17285571, bounty = 20, fee =   0 }, -- Edacious Opo-opo
        [2937] = { pageId = 367, mobId = 17285341, bounty = 25, fee =   0 }, -- Acolnahuacatl
        [2945] = { pageId = 368, mobId = 17285394, bounty = 30, fee =   0 }, -- Hoar-knuckled Rimberry
        [2953] = { pageId = 369, mobId = 17498184, bounty = 15, fee =   0 }, -- Namtar
        [2961] = { pageId = 370, mobId = 17498199, bounty = 15, fee =   0 }, -- Wuur the Sandcomber
        [2969] = { pageId = 371, mobId = 17498159, bounty = 20, fee =   0 }, -- Masan
        [2977] = { pageId = 372, mobId = 17498269, bounty = 20, fee =  45 }, -- Fyuu the Seabellow
        [2985] = { pageId = 373, mobId = 17498285, bounty = 20, fee =  45 }, -- Qull the Shellbuster
        [2993] = { pageId = 374, mobId = 17498301, bounty = 15, fee =  45 }, -- Seww the Squidlimbed
        [3001] = { pageId = 375, mobId = 17498341, bounty = 25, fee =   0 }, -- Pahh the Gullcaller
        [3009] = { pageId = 376, mobId = 17498420, bounty = 20, fee =   0 }, -- Sea Hog
        [3017] = { pageId = 377, mobId = 17498436, bounty = 20, fee =   0 }, -- Yarr the Pearleyed
        [3025] = { pageId = 378, mobId = 17498428, bounty = 20, fee =   0 }, -- Voll the Sharkfinned
        [3033] = { pageId = 379, mobId = 17498464, bounty = 20, fee =   0 }, -- Denn the Orcavoiced
        [3041] = { pageId = 380, mobId = 17498356, bounty = 20, fee =  60 }, -- Mouu the Waverider
        [3049] = { pageId = 381, mobId = 17498413, bounty = 25, fee =   0 }, -- Worr the Clawfisted
        [3057] = { pageId = 382, mobId = 17498516, bounty = 30, fee =   0 }, -- Zuug the Shoreleaper
        [3065] = { pageId = 383, mobId = 17428651, bounty = 25, fee =   0 }, -- Manipulator
        [3073] = { pageId = 384, mobId = 17428737, bounty = 20, fee =   0 }, -- Flauros
        [3081] = { pageId = 385, mobId = 17428810, bounty = 25, fee =   0 }, -- Death from Above
        [3089] = { pageId = 386, mobId = 17428811, bounty = 25, fee =   0 }, -- Habetrot
        [3097] = { pageId = 387, mobId = 17428809, bounty = 25, fee =   0 }, -- Beryl-footed Molberry
        [3105] = { pageId = 388, mobId = 17428554, bounty = 20, fee =   0 }, -- Sozu Sarberry
        [3113] = { pageId = 389, mobId = 17428611, bounty = 20, fee =   0 }, -- Sozu Terberry
        [3121] = { pageId = 390, mobId = 17428751, bounty = 25, fee =   0 }, -- Sozu Rogberry
        [3129] = { pageId = 391, mobId = 17428816, bounty = 30, fee =   0 }, -- Sacrificial Goblet
        [3137] = { pageId = 392, mobId = 17428813, bounty = 30, fee =   0 }, -- Crimson-toothed Pawberry
        [3145] = { pageId = 393, mobId = 17432609, bounty = 20, fee =   0 }, -- Sozu Bliberry
        [3153] = { pageId = 394, mobId = 17432640, bounty = 30, fee =  65 }, -- Friar Rush
        [3161] = { pageId = 395, mobId = 17432624, bounty = 30, fee =   0 }, -- Celeste-eyed Tozberry
        [3169] = { pageId = 396, mobId = 17432798, bounty = 30, fee =   0 }, -- Tawny-fingered Mugberry
        [3177] = { pageId = 397, mobId = 17432845, bounty = 30, fee =   0 }, -- Bistre-hearted Malberry
        [3185] = { pageId = 398, mobId = 17432974, bounty = 35, fee =   0 }, -- Ogama
        [3193] = { pageId = 399, mobId = 17617062, bounty = 30, fee =   0 }, -- Foreseer Oramix
        [3201] = { pageId = 400, mobId = 17616999, bounty = 30, fee =   0 }, -- Tyrannic Tunnok
        [3209] = { pageId = 401, mobId = 17617013, bounty = 30, fee =   0 }, -- Lindwurm
        [3217] = { pageId = 402, mobId = 17617130, bounty = 35, fee =   0 }, -- Vouivre
        [3225] = { pageId = 403, mobId = 17617164, bounty = 35, fee =  75 }, -- Tarasque
      }
  },

  [tpz.zone.NORG] =
  {
      msg =
     {
       6837,
       6838,
       6855,
       6819,
       6849,
       6851,
     },

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
        [ 266] = { huntId =  68969, optionId = 2889 },
        [ 522] = { huntId =  86378, optionId = 2897 },
        [ 778] = { huntId = 104811, optionId = 2905 },
        [1034] = { huntId = 123244, optionId = 2913 },
        -- Yhoator Jungle
        [ 274] = { huntId =  86381, optionId = 2921 },
        [ 530] = { huntId =  88430, optionId = 2929 },
        [ 786] = { huntId = 121199, optionId = 2937 },
        [1042] = { huntId = 122224, optionId = 2945 },
        -- Sea Serpent Grotto
        [ 282] = { huntId =  70001, optionId = 2953 },
        [ 538] = { huntId =  71026, optionId = 2961 },
        [ 794] = { huntId =  72051, optionId = 2969 },
        [1050] = { huntId =  88436, optionId = 2977 },
        [1306] = { huntId =  88437, optionId = 2985 },
        [1562] = { huntId =  86390, optionId = 2993 },
        [1818] = { huntId = 104823, optionId = 3001 },
        [2074] = { huntId = 102776, optionId = 3009 },
        [2330] = { huntId = 102777, optionId = 3017 },
        [2586] = { huntId = 102778, optionId = 3025 },
        [2842] = { huntId = 102779, optionId = 3033 },
        [3098] = { huntId = 102780, optionId = 3041 },
        [3354] = { huntId = 104829, optionId = 3049 },
        [3610] = { huntId = 122238, optionId = 3057 },
        -- Temple of Uggalepih
        [ 290] = { huntId = 104831, optionId = 3065 },
        [ 546] = { huntId = 103808, optionId = 3073 },
        [ 802] = { huntId = 105857, optionId = 3081 },
        [1058] = { huntId = 105858, optionId = 3089 },
        [1314] = { huntId = 105859, optionId = 3097 },
        [1570] = { huntId = 102788, optionId = 3105 },
        [1826] = { huntId = 102789, optionId = 3113 },
        [2082] = { huntId = 105862, optionId = 3121 },
        [2338] = { huntId = 123271, optionId = 3129 },
        [2594] = { huntId = 123272, optionId = 3137 },
        -- Den of Rancor
        [ 298] = { huntId = 102793, optionId = 3145 },
        [ 554] = { huntId = 122250, optionId = 3153 },
        [ 810] = { huntId = 122251, optionId = 3161 },
        [1066] = { huntId = 122252, optionId = 3169 },
        [1322] = { huntId = 122253, optionId = 3177 },
        [1578] = { huntId = 139662, optionId = 3185 },
        -- Ifrit's Cauldron
        [ 306] = { huntId = 122255, optionId = 3193 },
        [ 562] = { huntId = 122256, optionId = 3201 },
        [ 818] = { huntId = 122257, optionId = 3209 },
        [1074] = { huntId = 139666, optionId = 3217 },
        [1330] = { huntId = 140691, optionId = 3225 },

      hunt =
      {
        [2889] = { pageId = 361, mobId = 17281061, bounty = 10, fee =   0 }, -- Koropokkur
        [2897] = { pageId = 362, mobId = 17281149, bounty = 15, fee =   0 }, -- Mischievous Micholas
        [2905] = { pageId = 363, mobId = 17281388, bounty = 25, fee =   0 }, -- Bayawak
        [2913] = { pageId = 364, mobId = 17281296, bounty = 30, fee =   0 }, -- Pyuu the Spatemaker
        [2921] = { pageId = 365, mobId = 17285248, bounty = 15, fee =  45 }, -- Powderer Penny
        [2929] = { pageId = 366, mobId = 17285571, bounty = 20, fee =   0 }, -- Edacious Opo-opo
        [2937] = { pageId = 367, mobId = 17285341, bounty = 25, fee =   0 }, -- Acolnahuacatl
        [2945] = { pageId = 368, mobId = 17285394, bounty = 30, fee =   0 }, -- Hoar-knuckled Rimberry
        [2953] = { pageId = 369, mobId = 17498184, bounty = 15, fee =   0 }, -- Namtar
        [2961] = { pageId = 370, mobId = 17498199, bounty = 15, fee =   0 }, -- Wuur the Sandcomber
        [2969] = { pageId = 371, mobId = 17498159, bounty = 20, fee =   0 }, -- Masan
        [2977] = { pageId = 372, mobId = 17498269, bounty = 20, fee =  45 }, -- Fyuu the Seabellow
        [2985] = { pageId = 373, mobId = 17498285, bounty = 20, fee =  45 }, -- Qull the Shellbuster
        [2993] = { pageId = 374, mobId = 17498301, bounty = 15, fee =  45 }, -- Seww the Squidlimbed
        [3001] = { pageId = 375, mobId = 17498341, bounty = 25, fee =   0 }, -- Pahh the Gullcaller
        [3009] = { pageId = 376, mobId = 17498420, bounty = 20, fee =   0 }, -- Sea Hog
        [3017] = { pageId = 377, mobId = 17498436, bounty = 20, fee =   0 }, -- Yarr the Pearleyed
        [3025] = { pageId = 378, mobId = 17498428, bounty = 20, fee =   0 }, -- Voll the Sharkfinned
        [3033] = { pageId = 379, mobId = 17498464, bounty = 20, fee =   0 }, -- Denn the Orcavoiced
        [3041] = { pageId = 380, mobId = 17498356, bounty = 20, fee =  60 }, -- Mouu the Waverider
        [3049] = { pageId = 381, mobId = 17498413, bounty = 25, fee =   0 }, -- Worr the Clawfisted
        [3057] = { pageId = 382, mobId = 17498516, bounty = 30, fee =   0 }, -- Zuug the Shoreleaper
        [3065] = { pageId = 383, mobId = 17428651, bounty = 25, fee =   0 }, -- Manipulator
        [3073] = { pageId = 384, mobId = 17428737, bounty = 20, fee =   0 }, -- Flauros
        [3081] = { pageId = 385, mobId = 17428810, bounty = 25, fee =   0 }, -- Death from Above
        [3089] = { pageId = 386, mobId = 17428811, bounty = 25, fee =   0 }, -- Habetrot
        [3097] = { pageId = 387, mobId = 17428809, bounty = 25, fee =   0 }, -- Beryl-footed Molberry
        [3105] = { pageId = 388, mobId = 17428554, bounty = 20, fee =   0 }, -- Sozu Sarberry
        [3113] = { pageId = 389, mobId = 17428611, bounty = 20, fee =   0 }, -- Sozu Terberry
        [3121] = { pageId = 390, mobId = 17428751, bounty = 25, fee =   0 }, -- Sozu Rogberry
        [3129] = { pageId = 391, mobId = 17428816, bounty = 30, fee =   0 }, -- Sacrificial Goblet
        [3137] = { pageId = 392, mobId = 17428813, bounty = 30, fee =   0 }, -- Crimson-toothed Pawberry
        [3145] = { pageId = 393, mobId = 17432609, bounty = 20, fee =   0 }, -- Sozu Bliberry
        [3153] = { pageId = 394, mobId = 17432640, bounty = 30, fee =  65 }, -- Friar Rush
        [3161] = { pageId = 395, mobId = 17432624, bounty = 30, fee =   0 }, -- Celeste-eyed Tozberry
        [3169] = { pageId = 396, mobId = 17432798, bounty = 30, fee =   0 }, -- Tawny-fingered Mugberry
        [3177] = { pageId = 397, mobId = 17432845, bounty = 30, fee =   0 }, -- Bistre-hearted Malberry
        [3185] = { pageId = 398, mobId = 17432974, bounty = 35, fee =   0 }, -- Ogama
        [3193] = { pageId = 399, mobId = 17617062, bounty = 30, fee =   0 }, -- Foreseer Oramix
        [3201] = { pageId = 400, mobId = 17616999, bounty = 30, fee =   0 }, -- Tyrannic Tunnok
        [3209] = { pageId = 401, mobId = 17617013, bounty = 30, fee =   0 }, -- Lindwurm
        [3217] = { pageId = 402, mobId = 17617130, bounty = 35, fee =   0 }, -- Vouivre
        [3225] = { pageId = 403, mobId = 17617164, bounty = 35, fee =  75 }, -- Tarasque
      }
  },

  [tpz.zone.RABAO] =
  {
      msg =
     {
        6876,
        6877,
        6894,
        6858,
        6888,
        6890,
     },

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
        [ 266] = { huntId = 121236, optionId = 3233 },
        [ 522] = { huntId = 137621, optionId = 3241 },
        [ 778] = { huntId = 139670, optionId = 3249 },
        [1034] = { huntId = 157079, optionId = 3257 },
        -- Eastern Altepa Desert
        [ 274] = { huntId =  70040, optionId = 3265 },
        [ 530] = { huntId =  86425, optionId = 3273 },
        [ 786] = { huntId =  87450, optionId = 3281 },
        [1042] = { huntId = 121243, optionId = 3289 },
        -- Western Altepa Desert
        [ 282] = { huntId = 103836, optionId = 3297 },
        [ 538] = { huntId = 103885, optionId = 3305 },
        [ 794] = { huntId = 104862, optionId = 3313 },
        [1050] = { huntId = 122271, optionId = 3321 },
        -- Kuftal Tunnel
        [ 290] = { huntId = 105888, optionId = 3329 },
        [ 546] = { huntId = 122273, optionId = 3337 },
        [ 802] = { huntId = 120226, optionId = 3345 },
        [1058] = { huntId = 120227, optionId = 3353 },
        [1314] = { huntId = 120228, optionId = 3361 },
        [1570] = { huntId = 122277, optionId = 3369 },
        [1826] = { huntId = 141734, optionId = 3377 },
        -- Gustav Tunnel
        [ 298] = { huntId =  88487, optionId = 3385 },
        [ 554] = { huntId = 139688, optionId = 3393 },
        [ 810] = { huntId = 137641, optionId = 3401 },
        [1066] = { huntId = 157145, optionId = 3409 },
        [1322] = { huntId = 157147, optionId = 3417 },
        -- Quicksand Caves
        [ 306] = { huntId = 104874, optionId = 3425 },
        [ 562] = { huntId = 104875, optionId = 3433 },
        [ 818] = { huntId = 106924, optionId = 3441 },
        [1074] = { huntId = 102829, optionId = 3449 },
        [1330] = { huntId = 102830, optionId = 3457 },
        [1586] = { huntId = 102831, optionId = 3465 },
        [1842] = { huntId = 102832, optionId = 3473 },
        [2098] = { huntId = 102833, optionId = 3481 },
        [2354] = { huntId = 105906, optionId = 3489 },
        [2610] = { huntId = 106931, optionId = 3497 },
        [2866] = { huntId = 122292, optionId = 3505 },
        [3122] = { huntId = 121269, optionId = 3513 },
        [3378] = { huntId = 141750, optionId = 3521 },

      hunt =
      {
        [3233] = { pageId = 404, mobId = 17240232, bounty = 25, fee =   0 }, -- Tegmine
        [3241] = { pageId = 405, mobId = 17240376, bounty = 30, fee =  75 }, -- Frostmane
        [3249] = { pageId = 406, mobId = 17240315, bounty = 35, fee =   0 }, -- Zmey Gorynych
        [3257] = { pageId = 407, mobId = 17240180, bounty = 40, fee =  80 }, -- Killer Jonny
        [3265] = { pageId = 408, mobId = 17244396, bounty = 15, fee =  40 }, -- Dune Widow
        [3273] = { pageId = 409, mobId = 17244471, bounty = 15, fee =  45 }, -- Nandi
        [3281] = { pageId = 410, mobId = 17244268, bounty =  5, fee =   0 }, -- Donnergugi
        [3289] = { pageId = 411, mobId = 17244350, bounty = 25, fee =   0 }, -- Sabotender Corrido
        [3297] = { pageId = 412, mobId = 17289560, bounty = 20, fee =   0 }, -- Cactuar Cantautor
        [3305] = { pageId = 413, mobId = 17289323, bounty = 25, fee =   0 }, -- Dahu
        [3313] = { pageId = 414, mobId = 17289638, bounty = 25, fee =   0 }, -- Picolaton
        [3321] = { pageId = 415, mobId = 17289547, bounty = 30, fee =  70 }, -- Calchas
        [3329] = { pageId = 416, mobId = 17490231, bounty = 25, fee =   0 }, -- Cancer
        [3337] = { pageId = 417, mobId = 17489980, bounty = 30, fee =   0 }, -- Sabotender Mariachi
        [3345] = { pageId = 418, mobId = 17490016, bounty = 25, fee =   0 }, -- Amemet
        [3353] = { pageId = 419, mobId = 17490204, bounty = 25, fee =   0 }, -- Yowie
        [3361] = { pageId = 420, mobId = 17490217, bounty = 25, fee =   0 }, -- Arachne
        [3369] = { pageId = 421, mobId = 17490159, bounty = 30, fee =   0 }, -- Bloodthirster Madkix
        [3377] = { pageId = 422, mobId = 17490101, bounty = 40, fee =   0 }, -- Pelican
        [3385] = { pageId = 423, mobId = 17645609, bounty = 20, fee =   0 }, -- Goblinsavior Heronox
        [3393] = { pageId = 424, mobId = 17645742, bounty = 35, fee =  75 }, -- Taxim
        [3401] = { pageId = 425, mobId = 17645719, bounty = 30, fee =  75 }, -- Baobhan Sith
        [3409] = { pageId = 473, mobId = 17645774, bounty = 40, fee =  80 }, -- Amikiri
        [3417] = { pageId = 475, mobId = 17645755, bounty = 40, fee =  80 }, -- Ungur
        [3425] = { pageId = 426, mobId = 17629238, bounty = 25, fee =  55 }, -- Centurio X-I
        [3433] = { pageId = 427, mobId = 17629301, bounty = 25, fee =  55 }, -- Sagittarius X-XIII
        [3441] = { pageId = 428, mobId = 17629430, bounty = 30, fee =   0 }, -- Diamond Daig
        [3449] = { pageId = 429, mobId = 17629412, bounty = 20, fee =   0 }, -- Antican Magister
        [3457] = { pageId = 430, mobId = 17629421, bounty = 20, fee =   0 }, -- Antican Proconsul
        [3465] = { pageId = 431, mobId = 17629281, bounty = 20, fee =   0 }, -- Antican Praefectus
        [3473] = { pageId = 432, mobId = 17629483, bounty = 20, fee =   0 }, -- Antican Tribunus
        [3481] = { pageId = 433, mobId = 17629264, bounty = 20, fee =   0 }, -- Sabotender Bailarina
        [3489] = { pageId = 434, mobId = 17629643, bounty = 25, fee =   0 }, -- Tribunus VII-I
        [3497] = { pageId = 435, mobId = 17629403, bounty = 30, fee =   0 }, -- Nussknacker
        [3505] = { pageId = 436, mobId = 17629524, bounty = 30, fee =   0 }, -- Triarius X-XV
        [3513] = { pageId = 437, mobId = 17629644, bounty = 25, fee =   0 }, -- Proconsul XII
        [3521] = { pageId = 438, mobId = 17629587, bounty = 40, fee =  75 }, -- Sabotender Bailarina
      }
  },

  [tpz.zone.TAVNAZIAN_SAFEHOLD] =
  {
      msg =
     {
        6720, -- Hunt accepted!
        6721, -- You use <fee> scylds. Current balance: <scylds>.
        6738, -- Hunt canceled.
        6702, -- Current training regime canceled.
        6732, -- You record your hunt.
        6734, -- You obtain <scylds>! Current Balance: <scylds>.
     },

      huntMenu =
     {
        [   1] =    2097114,
        [   9] = 2147483616,
        [  17] = 2147483616,
     },
        -- Lufaise Meadows
        [ 266] = { huntId =  86455, optionId = 3513 },
        [ 522] = { huntId =  87480, optionId = 3521 },
        [ 778] = { huntId = 103865, optionId = 3529 },
        [1034] = { huntId = 158138, optionId = 3537 },
        -- Misareaux Coast
        [ 274] = { huntId =  86459, optionId = 3545 },
        [ 530] = { huntId =  86460, optionId = 3553 },
        [ 786] = { huntId =  88509, optionId = 3561 },
        [1042] = { huntId = 104894, optionId = 3569 },

      hunt =
      {
        [3513] = { pageId = 439, mobId = 16875741, bounty = 15, fee =   0 }, -- Megalobugard
        [3521] = { pageId = 440, mobId = 16875600, bounty = 20, fee =   0 }, -- Yal-un Eke
        [3529] = { pageId = 441, mobId = 16875690, bounty = 20, fee =  55 }, -- Sengann
        [3537] = { pageId = 442, mobId = 16875638, bounty = 40, fee =  80 }, -- Flockbock
        [3545] = { pageId = 443, mobId = 16879758, bounty = 15, fee =   0 }, -- Odqan
        [3553] = { pageId = 444, mobId = 16879665, bounty = 15, fee =   0 }, -- Goaftrap
        [3561] = { pageId = 445, mobId = 16879900, bounty = 20, fee =   0 }, -- Ziphius
        [3569] = { pageId = 446, mobId = 16879847, bounty = 25, fee =   0 }, -- Okyupete
      }
  },

  [tpz.zone.AHT_URHGAN_WHITEGATE] =
  {
      msg =
     {
        1484,
        1485,
        1502,
        1466,
        1496,
        1498,
     },

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
        [ 266] = { huntId = 120255, optionId = 3577 },
        [ 522] = { huntId = 139712, optionId = 3585 },
        [ 778] = { huntId = 139713, optionId = 3593 },
        [1034] = { huntId = 156098, optionId = 3601 },
        -- Bhaflau Thickets
        [ 274] = { huntId = 121283, optionId = 3609 },
        [ 530] = { huntId = 137668, optionId = 3617 },
        [ 786] = { huntId = 139717, optionId = 3625 },
        [1042] = { huntId = 157126, optionId = 3633 },
        -- Mount Zhayolm
        [ 282] = { huntId = 139719, optionId = 3641 },
        [ 538] = { huntId = 141768, optionId = 3649 },
        [ 794] = { huntId = 157129, optionId = 3657 },
        [1050] = { huntId = 156106, optionId = 3665 },
        -- Mamook
        [ 290] = { huntId = 139723, optionId = 3673 },
        [ 546] = { huntId = 156108, optionId = 3681 },
        [ 802] = { huntId = 173517, optionId = 3689 },
        -- Aydeewa Subterrane
        [ 298] = { huntId = 121294, optionId = 3697 },
        [ 554] = { huntId = 123343, optionId = 3705 },
        [ 810] = { huntId = 137680, optionId = 3713 },
        -- Halvung
        [ 306] = { huntId = 156113, optionId = 3721 },
        [ 562] = { huntId = 157138, optionId = 3729 },
        [ 818] = { huntId = 173523, optionId = 3737 },

      hunt =
      {
        [3577] = { pageId = 447, mobId = 16986197, bounty = 25, fee =   0 }, -- Zoraal Ja's Pkuucha
        [3585] = { pageId = 448, mobId = 16986378, bounty = 35, fee =   0 }, -- Jaded Jody
        [3593] = { pageId = 449, mobId = 16986188, bounty = 35, fee =  75 }, -- Chelicerata
        [3601] = { pageId = 450, mobId = 16986320, bounty = 35, fee =   0 }, -- Gharial
        [3609] = { pageId = 451, mobId = 16990252, bounty = 25, fee =   0 }, -- Harvestman
        [3617] = { pageId = 452, mobId = 16990376, bounty = 35, fee =  75 }, -- Emergent Elm
        [3625] = { pageId = 453, mobId = 16990403, bounty = 35, fee =  75 }, -- Nis Puk
        [3633] = { pageId = 454, mobId = 16990306, bounty = 40, fee =  75 }, -- Mahishasura
        [3641] = { pageId = 455, mobId = 17027466, bounty = 35, fee =  75 }, -- Energetic Eruca
        [3649] = { pageId = 456, mobId = 17027228, bounty = 40, fee =  75 }, -- Chary Apkallu
        [3657] = { pageId = 457, mobId = 17027423, bounty = 40, fee =  80 }, -- Ignamoth
        [3665] = { pageId = 458, mobId = 17027183, bounty = 35, fee =  85 }, -- Fahrafahr the Bloodied
        [3673] = { pageId = 459, mobId = 17043466, bounty = 35, fee =  75 }, -- Venomfang
        [3681] = { pageId = 460, mobId = 17043554, bounty = 35, fee =  80 }, -- Zizzy Zillah
        [3689] = { pageId = 461, mobId = 17043779, bounty = 40, fee =  85 }, -- Firedance Magmaal Ja
        [3697] = { pageId = 462, mobId = 17056140, bounty = 25, fee =   0 }, -- Lizardtrap
        [3705] = { pageId = 463, mobId = 17056155, bounty = 30, fee =   0 }, -- Crystal Eater
        [3713] = { pageId = 464, mobId = 17056156, bounty = 30, fee =  75 }, -- Bluestreak Gyugyuroon
        [3721] = { pageId = 465, mobId = 17031220, bounty = 35, fee =  80 }, -- Copper Borer
        [3729] = { pageId = 466, mobId = 17031401, bounty = 40, fee =  80 }, -- Big Bomb
        [3737] = { pageId = 467, mobId = 17031312, bounty = 40, fee =  85 }, -- Flammeri
      }
  },

  [tpz.zone.NASHMAU] =
  {
      msg =
     {
        7363,
        7364,
        7381,
        7345,
        7375,
        7377,
     },

      huntMenu =
     {
        [   1] =    2097136,
        [   9] = 2147483616,
        [  17] = 2147483640,
        [  25] = 2147483632,
     },
        -- Caedarva Mire
        [ 266] = { huntId = 120276, optionId = 3745 },
        [ 522] = { huntId = 139733, optionId = 3753 },
        [ 778] = { huntId = 156118, optionId = 3761 },
        [1034] = { huntId = 173527, optionId = 3769 },
        -- Arrapago Reef
        [ 274] = { huntId = 155096, optionId = 3777 },
        [ 530] = { huntId = 173530, optionId = 3785 },
        -- Alzadaal Undersea Ruins
        [ 282] = { huntId = 156124, optionId = 3793 },
        [ 538] = { huntId = 173533, optionId = 3801 },
        [ 794] = { huntId = 174558, optionId = 3809 },

      hunt =
      {
        [3745] = { pageId = 468, mobId = 17101143, bounty = 25, fee =   0 }, -- Peallaidh
        [3753] = { pageId = 469, mobId = 17101144, bounty = 35, fee =  75 }, -- Zikko
        [3761] = { pageId = 470, mobId = 17101099, bounty = 35, fee =  80 }, -- Aynu-kaysey
        [3769] = { pageId = 471, mobId = 17101158, bounty = 40, fee =  85 }, -- Vidhuwa the Wrathborn
        [3777] = { pageId = 472, mobId = 16998655, bounty = 35, fee =  80 }, -- Bloody Bones
        [3785] = { pageId = 474, mobId = 16998696, bounty = 40, fee =  85 }, -- Euryale
        [3793] = { pageId = 476, mobId = 17072133, bounty = 35, fee =  80 }, -- Boompadu
        [3801] = { pageId = 477, mobId = 17072150, bounty = 40, fee =  85 }, -- Cookieduster Lipiroon
        [3809] = { pageId = 478, mobId = 17072170, bounty = 45, fee = 100 }, -- Oupire
      }
  },

  [tpz.zone.SOUTHERN_SAN_DORIA_S] =
  {
      msg =
     {
        7635,
        7636,
        7653,
        7617,
        7647,
        7649,
     },

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
        [ 266] = { huntId =  86495, optionId = 3833 },
        [ 522] = { huntId =  86496, optionId = 3841 },
        [ 778] = { huntId =  87521, optionId = 3849 },
        [1034] = { huntId = 121314, optionId = 3857 },
        -- Jugner Forest [S]
        [ 274] = { huntId = 103907, optionId = 3865 },
        [ 530] = { huntId = 156132, optionId = 3873 },
        [ 786] = { huntId = 157157, optionId = 3881 },
        [1042] = { huntId = 173542, optionId = 3889 },
        -- Vunkerl Inlet [S]
        [ 282] = { huntId = 121319, optionId = 3897 },
        [ 538] = { huntId = 139752, optionId = 3905 },
        [ 794] = { huntId = 155113, optionId = 3913 },
        [1050] = { huntId = 156138, optionId = 3921 },
        -- Batallia Downs [S]
        [ 290] = { huntId =  86507, optionId = 3929 },
        [ 546] = { huntId = 103916, optionId = 3937 },
        [ 802] = { huntId = 104941, optionId = 3945 },
        [1058] = { huntId = 122350, optionId = 3953 },
        -- The Eldieme Necropolis [S]
        [ 298] = { huntId = 139759, optionId = 3961 },
        [ 554] = { huntId = 174576, optionId = 3969 },
        [ 810] = { huntId = 174577, optionId = 3977 },
        -- Beaucedine Glacier [S]
        [ 306] = { huntId = 156184, optionId = 3985 },
        [ 562] = { huntId = 156185, optionId = 3993 },
        [ 818] = { huntId = 173594, optionId = 4001 },
        [1074] = { huntId = 174619, optionId = 4009 },
        -- Xarcabard [S]
        [ 314] = { huntId = 156188, optionId = 4017 },
        [ 570] = { huntId = 173597, optionId = 4025 },
        [ 826] = { huntId = 173598, optionId = 4033 },
        [1082] = { huntId = 174623, optionId = 4041 },

      hunt =
      {
        [3833] = { pageId = 479, mobId = 17109338, bounty = 15, fee =   0 }, -- Skogs Fru
        [3841] = { pageId = 480, mobId = 17109235, bounty = 15, fee =   0 }, -- Myradrosh
        [3849] = { pageId = 481, mobId = 17109296, bounty = 20, fee =   0 }, -- Goblintrap
        [3857] = { pageId = 482, mobId = 17109147, bounty = 25, fee =   0 }, -- Melusine
        [3865] = { pageId = 483, mobId = 17113332, bounty = 20, fee =   0 }, -- Boll Weevil
        [3873] = { pageId = 484, mobId = 17113381, bounty = 35, fee =  80 }, -- Drumskull Zogdregg
        [3881] = { pageId = 485, mobId = 17113463, bounty = 40, fee =  80 }, -- Vulkodlac
        [3889] = { pageId = 486, mobId = 17113175, bounty = 40, fee =  85 }, -- Voirloup
        [3897] = { pageId = 487, mobId = 17117295, bounty = 25, fee =   0 }, -- Warabouc
        [3905] = { pageId = 488, mobId = 17117349, bounty = 35, fee =  75 }, -- Big Bang
        [3913] = { pageId = 489, mobId = 17117250, bounty = 35, fee =  80 }, -- Pallas
        [3921] = { pageId = 490, mobId = 17117422, bounty = 35, fee =  80 }, -- Judgmental Julika
        [3929] = { pageId = 491, mobId = 17121576, bounty = 15, fee =   0 }, -- La Velue
        [3937] = { pageId = 492, mobId = 17121610, bounty = 20, fee =   0 }, -- Chaneque
        [3945] = { pageId = 493, mobId = 17121603, bounty = 25, fee =   0 }, -- Habergoass
        [3953] = { pageId = 494, mobId = 17121399, bounty = 30, fee =   0 }, -- Burlibix Brawnback
        [3961] = { pageId = 495, mobId = 17494135, bounty = 35, fee =  75 }, -- Laelaps
        [3969] = { pageId = 496, mobId = 17494213, bounty = 45, fee = 100 }, -- Tethra
        [3977] = { pageId = 497, mobId = 17494093, bounty = 45, fee = 100 }, -- Ethniu
        [3985] = { pageId = 536, mobId = 17334523, bounty = 35, fee =  80 }, -- Came-cruse
        [3993] = { pageId = 537, mobId = 17334356, bounty = 35, fee =  80 }, -- Becut
        [4001] = { pageId = 538, mobId = 17334482, bounty = 40, fee =  85 }, -- Grand'Goule
        [4009] = { pageId = 539, mobId = 17334336, bounty = 45, fee = 100 }, -- Scylla
        [4017] = { pageId = 540, mobId = 17338559, bounty = 35, fee =  80 }, -- Tikbalang
        [4025] = { pageId = 541, mobId = 17338462, bounty = 40, fee =  85 }, -- Prince Orobas
        [4033] = { pageId = 542, mobId = 17338386, bounty = 40, fee =  85 }, -- Graoully
        [4041] = { pageId = 543, mobId = 17338585, bounty = 45, fee = 100 }, -- Zirnitra
      }
  },

  [tpz.zone.BASTOK_MARKETS_S] =
  {
      msg =
     {
        7716,
        7717,
        7734,
        7698,
        7728,
        7730,
     },

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
        [ 266] = { huntId =  86514, optionId = 3985 },
        [ 522] = { huntId =  86515, optionId = 3993 },
        [ 778] = { huntId =  87540, optionId = 4001 },
        [1034] = { huntId = 121333, optionId = 4009 },
        -- Grauberg [S]
        [ 274] = { huntId = 121334, optionId = 4017 },
        [ 530] = { huntId = 155127, optionId = 4025 },
        [ 786] = { huntId = 156152, optionId = 4033 },
        [1042] = { huntId = 173561, optionId = 4041 },
        -- Pashhow Marshlands [S]
        [ 282] = { huntId = 139770, optionId = 4049 },
        [ 538] = { huntId = 140795, optionId = 4057 },
        [ 794] = { huntId = 156156, optionId = 4065 },
        [1050] = { huntId = 173565, optionId = 4073 },
        -- Rolanberry Fields [S]
        [ 290] = { huntId = 103934, optionId = 4081 },
        [ 546] = { huntId = 102911, optionId = 4089 },
        [ 802] = { huntId = 104960, optionId = 4097 },
        [1058] = { huntId = 122369, optionId = 4105 },
        -- Crawlers' Nest [S]
        [ 298] = { huntId = 139778, optionId = 4113 },
        [ 554] = { huntId = 156163, optionId = 4121 },
        [ 810] = { huntId = 174596, optionId = 4129 },
        -- Beaucedine Glacier [S]
        [ 306] = { huntId = 156184, optionId = 4137 },
        [ 562] = { huntId = 156185, optionId = 4145 },
        [ 818] = { huntId = 173594, optionId = 4153 },
        [1074] = { huntId = 174619, optionId = 4161 },
        -- Xarcabard [S]
        [ 314] = { huntId = 156188, optionId = 4169 },
        [ 570] = { huntId = 173597, optionId = 4177 },
        [ 826] = { huntId = 173598, optionId = 4185 },
        [1082] = { huntId = 174623, optionId = 4193 },

      hunt =
      {
        [3985] = { pageId = 498, mobId = 17137821, bounty = 15, fee =   0 }, -- Gloomanita
        [3993] = { pageId = 499, mobId = 17137859, bounty = 15, fee =   0 }, -- Olgoi-Khorkhoi
        [4001] = { pageId = 500, mobId = 17137705, bounty = 20, fee =   0 }, -- Ankabut
        [4009] = { pageId = 501, mobId = 17137976, bounty = 25, fee =   0 }, -- Peaseblossom
        [4017] = { pageId = 502, mobId = 17141872, bounty = 25, fee =  70 }, -- Sarcopsylla
        [4025] = { pageId = 503, mobId = 17141979, bounty = 35, fee =  80 }, -- Scitalis
        [4033] = { pageId = 504, mobId = 17141962, bounty = 35, fee =  80 }, -- Kotan-kor Kamuy
        [4041] = { pageId = 505, mobId = 17141885, bounty = 40, fee =  85 }, -- Vasiliceratops
        [4049] = { pageId = 506, mobId = 17145965, bounty = 35, fee =   0 }, -- Croque-mitaine
        [4057] = { pageId = 507, mobId = 17146147, bounty = 35, fee =  75 }, -- Kinepikwa
        [4065] = { pageId = 508, mobId = 17145867, bounty = 35, fee =  80 }, -- Sugaar
        [4073] = { pageId = 509, mobId = 17146012, bounty = 40, fee =  85 }, -- Nommo
        [4081] = { pageId = 510, mobId = 17149986, bounty = 20, fee =   0 }, -- Lamina
        [4089] = { pageId = 511, mobId = 17150047, bounty = 20, fee =   0 }, -- Dyinyinga
        [4097] = { pageId = 512, mobId = 17150081, bounty = 25, fee =   0 }, -- Erle
        [4105] = { pageId = 513, mobId = 17150280, bounty = 30, fee =   0 }, -- Delicieuse Delphine
        [4113] = { pageId = 514, mobId = 17477675, bounty = 35, fee =  75 }, -- Abatwa
        [4121] = { pageId = 515, mobId = 17477640, bounty = 35, fee =  80 }, -- Morille Mortelle
        [4129] = { pageId = 516, mobId = 17477708, bounty = 45, fee = 100 }, -- Lugh
        [4137] = { pageId = 536, mobId = 17334523, bounty = 35, fee =  80 }, -- Came-cruse
        [4145] = { pageId = 537, mobId = 17334356, bounty = 35, fee =  80 }, -- Becut
        [4153] = { pageId = 538, mobId = 17334482, bounty = 40, fee =  85 }, -- Grand'Goule
        [4161] = { pageId = 539, mobId = 17334336, bounty = 45, fee = 100 }, -- Scylla
        [4169] = { pageId = 540, mobId = 17338559, bounty = 35, fee =  80 }, -- Tikbalang
        [4177] = { pageId = 541, mobId = 17338462, bounty = 40, fee =  85 }, -- Prince Orobas
        [4185] = { pageId = 542, mobId = 17338386, bounty = 40, fee =  85 }, -- Graoully
        [4193] = { pageId = 543, mobId = 17338585, bounty = 45, fee = 100 }, -- Zirnitra
      }
  },

  [tpz.zone.WINDURST_WATERS_S] =
  {
      msg =
     {
        7748,
        7749,
        7766,
        7730,
        7760,
        7762,
     },

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
        [ 266] = { huntId =  17925, optionId = 4137 },
        [ 522] = { huntId =  86534, optionId = 4145 },
        [ 778] = { huntId =  87559, optionId = 4153 },
        [1034] = { huntId = 121352, optionId = 4161 },
        -- Fort Karugo-Narugo [S]
        [ 274] = { huntId =  86537, optionId = 4169 },
        [ 530] = { huntId = 104970, optionId = 4177 },
        [ 786] = { huntId = 102923, optionId = 4185 },
        [1042] = { huntId = 156172, optionId = 4193 },
        -- Meriphataud Mountains [S]
        [ 282] = { huntId = 121357, optionId = 4201 },
        [ 538] = { huntId = 140814, optionId = 4209 },
        [ 794] = { huntId = 156175, optionId = 4217 },
        [1050] = { huntId = 173584, optionId = 4225 },
        -- Sauromugue Champaign [S]
        [ 290] = { huntId =  86545, optionId = 4233 },
        [ 546] = { huntId = 103954, optionId = 4241 },
        [ 802] = { huntId = 106003, optionId = 4249 },
        [1058] = { huntId = 123412, optionId = 4257 },
        -- Garlaige Citadel [S]
        [ 298] = { huntId = 139797, optionId = 4265 },
        [ 554] = { huntId = 174614, optionId = 4273 },
        [ 810] = { huntId = 174615, optionId = 4281 },
        -- Beaucedine Glacier [S]
        [ 306] = { huntId = 156184, optionId = 4289 },
        [ 562] = { huntId = 156185, optionId = 4297 },
        [ 818] = { huntId = 173594, optionId = 4305 },
        [1074] = { huntId = 174619, optionId = 4313 },
        -- Xarcabard [S]
        [ 314] = { huntId = 156188, optionId = 4321 },
        [ 570] = { huntId = 173597, optionId = 4329 },
        [ 826] = { huntId = 173598, optionId = 4337 },
        [1082] = { huntId = 174623, optionId = 4345 },

      hunt =
      {
        [4137] = { pageId = 517, mobId = 17166543, bounty =  5, fee =   0 }, -- Jeduah
        [4145] = { pageId = 518, mobId = 17166441, bounty = 15, fee =   0 }, -- Belladonna
        [4153] = { pageId = 519, mobId = 17166705, bounty = 20, fee =   0 }, -- Ramponneau
        [4161] = { pageId = 520, mobId = 17166669, bounty = 25, fee =   0 }, -- Tiffenotte
        [4169] = { pageId = 521, mobId = 17170594, bounty = 15, fee =   0 }, -- Emela-ntouka
        [4177] = { pageId = 522, mobId = 17170475, bounty = 25, fee =   0 }, -- Ratatoskr
        [4185] = { pageId = 523, mobId = 17170499, bounty = 20, fee =   0 }, -- Kirtimukha
        [4193] = { pageId = 524, mobId = 17170569, bounty = 35, fee =  80 }, -- Demoiselle Desolee
        [4201] = { pageId = 525, mobId = 17174561, bounty = 25, fee =   0 }, -- Muq Shabeel
        [4209] = { pageId = 526, mobId = 17174889, bounty = 35, fee =  75 }, -- Bloodlapper
        [4217] = { pageId = 527, mobId = 17174682, bounty = 35, fee =  80 }, -- Hemodrosophila
        [4225] = { pageId = 528, mobId = 17174709, bounty = 40, fee =  85 }, -- Centipedal Centruroides
        [4233] = { pageId = 529, mobId = 17178803, bounty = 15, fee =   0 }, -- Balam-Quitz
        [4241] = { pageId = 530, mobId = 17178885, bounty = 20, fee =   0 }, -- Hyakinthos
        [4249] = { pageId = 531, mobId = 17178763, bounty = 25, fee =   0 }, -- Herensugue
        [4257] = { pageId = 532, mobId = 17178689, bounty = 30, fee =   0 }, -- Coquecigrue
        [4265] = { pageId = 533, mobId = 17448990, bounty = 35, fee =  75 }, -- Citadel Pipistrelles
        [4273] = { pageId = 534, mobId = 17449017, bounty = 45, fee = 100 }, -- Buarainech
        [4281] = { pageId = 535, mobId = 17449008, bounty = 45, fee = 100 }, -- Elatha
        [4289] = { pageId = 536, mobId = 17334523, bounty = 35, fee =  80 }, -- Came-cruse
        [4297] = { pageId = 537, mobId = 17334356, bounty = 35, fee =  80 }, -- Becut
        [4305] = { pageId = 538, mobId = 17334482, bounty = 40, fee =  85 }, -- Grand'Goule
        [4313] = { pageId = 539, mobId = 17334336, bounty = 45, fee = 100 }, -- Scylla
        [4321] = { pageId = 540, mobId = 17338559, bounty = 35, fee =  80 }, -- Tikbalang
        [4329] = { pageId = 541, mobId = 17338462, bounty = 40, fee =  85 }, -- Prince Orobas
        [4337] = { pageId = 542, mobId = 17338386, bounty = 40, fee =  85 }, -- Graoully
        [4345] = { pageId = 543, mobId = 17338585, bounty = 45, fee = 100 }, -- Zirnitra
      }
  }
}

--[[    0  |   0000000000   | 0000000000 |  0000
      1bit |    10 bits     |  10 bits   |  4bit
      lock |   Scyld Qty    | NM pageId #  | status
                                          (Has distinct values) ]]--

    function tpz.hunts.onTrigger(player,npc,event)
        local huntZone = player:getCharVar("[hunt]zone")
        local huntId = player:getCharVar("[hunt]id")
        local huntStatus = player:getCharVar("[hunt]status")
        local scyldBits = bit.lshift(player:getCurrency("scyld"), 14)
        local lockBit = bit.lshift(1, 24)
        local registryZone = zone[player:getZoneID()]

        -- one vana'diel day lockout timer after completing a hunt
        if os.time() < player:getCharVar("[hunt]nextHunt") then
            local bitCombo = scyldBits + lockBit
            player:startEvent(1500,bitCombo,registryZone.huntMenu[1])

        -- [hunt]status 1 player has already accepted a hunt
        elseif huntStatus == 1 then
            local playerHunt = zone[huntZone].hunt[huntId]
            local pageBits = bit.lshift(playerHunt.pageId, 4)
            local bitCombo = scyldBits + pageBits + 0x0002 -- bit displays hunt active menu
            player:startEvent(1500,bitCombo,registryZone.huntMenu[1])

        -- [hunt]status 2 player has completed a hunt
        elseif huntStatus == 2 then
            local playerHunt = zone[huntZone].hunt[huntId]
            local pageBits = bit.lshift(playerHunt.pageId, 4)
            local bitCombo = scyldBits + pageBits + 0x000A -- bit displays completion menu
            player:startEvent(1500,bitCombo,registryZone.huntMenu[1])

        -- stops player from taking a hunt if a regime is active
        elseif player:getCharVar("[regime]id") >= 1 then
            local bitCombo = scyldBits + 0x0001 -- bit displays regime active menu
            player:startEvent(1500,bitCombo,registryZone.huntMenu[1])

        -- default menu
        else
            player:startEvent(1500,scyldBits,registryZone.huntMenu[1])
        end
      end

    function tpz.hunts.onEventUpdate(player,csid,option)
        local registryZone = zone[player:getZoneID()]
        local region = registryZone[option]
        player:updateEvent(0,0,registryZone.huntMenu[option])

        -- handles region select
        option = bit.band(option, 0xFF)
        if registryZone.huntMenu[option] then
            player:updateEvent(0,1,registryZone.huntMenu[option])
        end

        -- gets progress of current hunt (param controls the display of kills needed)
        if option == 3 then
            player:updateEvent(1)
        end

        -- displays hunt info (kills required,0,0,0,zoneId,huntId,scyld bounty+fee,?)
        if region then
            local huntPage = registryZone.hunt[region.optionId]
            local bountyBit = bit.lshift(huntPage.bounty, 10)
            local feeBit = huntPage.fee
            local scyldParam = bountyBit + feeBit
            player:updateEvent(1,0,0,0,0,region.huntId,scyldParam,1)
        end
    end

    tpz.hunts.clearHuntVars = function(player)
        player:setCharVar("[hunt]id", 0)
        player:setCharVar("[hunt]status", 0)
        player:setCharVar("[hunt]zone", 0)
        player:setCharVar("[hunt]page", 0)
    end

    function tpz.hunts.onEventFinish(player, csid, option)
        local registryZone = zone[player:getZoneID()]
        local huntEntry = registryZone.hunt[option]
        local msg = registryZone.msg

        -- accepting hunt
        if huntEntry then
            player:setCharVar("[hunt]status", 1)
            player:setCharVar("[hunt]zone", player:getZoneID())
            player:setCharVar("[hunt]id", option)
            player:setCharVar("[hunt]page", huntEntry.pageId)
            player:delCurrency("scyld", huntEntry.fee)
            player:messageSpecial(msg[1])
            player:messageSpecial(msg[2], huntEntry.fee, player:getCurrency("scyld"))

        -- cancels hunt
        elseif option == 3 then
            player:messageSpecial(msg[3])
            player:setCharVar("[hunt]status", 0)

        -- cancels training regime and clears all vars
        elseif option == 4 then
            player:messageSpecial(msg[4])
            tpz.regime.clearRegimeVars(player)

        -- completes hunt
        elseif option == 5 then
            local huntZone = player:getCharVar("[hunt]zone")
            local huntId = player:getCharVar("[hunt]id")
            local scyldBounty = zone[huntZone].hunt[huntId].bounty
            -- give player evoliths here
            player:setCharVar("[hunt]nextHunt", getVanaMidnight())
            tpz.hunts.clearHuntVars(player)

          -- scylds cap at 1000
          if player:getCurrency("scyld") + scyldBounty > 1000 then
              player:setCurrency("scyld", 1000)
          else
              player:addCurrency("scyld", scyldBounty)
          end
              player:messageSpecial(msg[5])
              player:messageSpecial(msg[6], scyldBounty, player:getCurrency("scyld"))
        end
    end

    function tpz.hunts.checkHunt(mob, player, isKiller)
        local huntZone = player:getCharVar("[hunt]zone")
        local huntId = player:getCharVar("[hunt]id")
        local playerHunt = zone[huntZone].hunt[huntId]

        -- required NM has been defeated
        if player:getCharVar("[hunt]status") == 1 and mob:getID() == zone[huntZone].hunt[huntId].mobId then
           player:messageBasic(tpz.msg.basic.FOV_DEFEATED_TARGET + 20)
           player:setCharVar("[hunt]status", 2)
        end
    end
