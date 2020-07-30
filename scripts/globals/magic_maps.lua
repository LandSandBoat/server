---------------------------------------------
--
--    Function that all map NPCS use.
--    SE updated the map NPCs to sell maps from the normal areas, RoZ, and CoP areas (Update was in Nov 5, 2013)
---------------------------------------------

require("scripts/globals/keyitems")

local Maps = {tpz.ki.MAP_OF_THE_SAN_DORIA_AREA, tpz.ki.MAP_OF_THE_BASTOK_AREA, tpz.ki.MAP_OF_THE_WINDURST_AREA, tpz.ki.MAP_OF_THE_JEUNO_AREA, tpz.ki.MAP_OF_ORDELLES_CAVES, tpz.ki.MAP_OF_GHELSBA, tpz.ki.MAP_OF_DAVOI, tpz.ki.MAP_OF_CARPENTERS_LANDING, tpz.ki.MAP_OF_THE_ZERUHN_MINES,
    tpz.ki.MAP_OF_THE_PALBOROUGH_MINES, tpz.ki.MAP_OF_BEADEAUX, tpz.ki.MAP_OF_GIDDEUS, tpz.ki.MAP_OF_CASTLE_OZTROJA, tpz.ki.MAP_OF_THE_MAZE_OF_SHAKHRAMI, tpz.ki.MAP_OF_THE_LITELOR_REGION, tpz.ki.MAP_OF_BIBIKI_BAY, tpz.ki.MAP_OF_QUFIM_ISLAND, tpz.ki.MAP_OF_THE_ELDIEME_NECROPOLIS,
    tpz.ki.MAP_OF_THE_GARLAIGE_CITADEL, tpz.ki.MAP_OF_THE_ELSHIMO_REGIONS, tpz.ki.MAP_OF_THE_NORTHLANDS_AREA, tpz.ki.MAP_OF_KING_RANPERRES_TOMB, tpz.ki.MAP_OF_THE_DANGRUF_WADI, tpz.ki.MAP_OF_THE_HORUTOTO_RUINS, tpz.ki.MAP_OF_BOSTAUNIEUX_OUBLIETTE,
    tpz.ki.MAP_OF_THE_TORAIMARAI_CANAL, tpz.ki.MAP_OF_THE_GUSGEN_MINES, tpz.ki.MAP_OF_THE_CRAWLERS_NEST, tpz.ki.MAP_OF_THE_RANGUEMONT_PASS, tpz.ki.MAP_OF_DELKFUTTS_TOWER, tpz.ki.MAP_OF_FEIYIN, tpz.ki.MAP_OF_CASTLE_ZVAHL, tpz.ki.MAP_OF_THE_KUZOTZ_REGION,
    tpz.ki.MAP_OF_THE_RUAUN_GARDENS, tpz.ki.MAP_OF_NORG, tpz.ki.MAP_OF_THE_TEMPLE_OF_UGGALEPIH, tpz.ki.MAP_OF_THE_DEN_OF_RANCOR, tpz.ki.MAP_OF_THE_KORROLOKA_TUNNEL, tpz.ki.MAP_OF_THE_KUFTAL_TUNNEL, tpz.ki.MAP_OF_THE_BOYAHDA_TREE, tpz.ki.MAP_OF_THE_VELUGANNON_PALACE,
    tpz.ki.MAP_OF_IFRITS_CAULDRON, tpz.ki.MAP_OF_THE_QUICKSAND_CAVES, tpz.ki.MAP_OF_THE_SEA_SERPENT_GROTTO, tpz.ki.MAP_OF_THE_VOLLBOW_REGION, tpz.ki.MAP_OF_THE_LABYRINTH_OF_ONZOZO, tpz.ki.MAP_OF_THE_ULEGUERAND_RANGE, tpz.ki.MAP_OF_THE_ATTOHWA_CHASM, tpz.ki.MAP_OF_PSOXJA,
    tpz.ki.MAP_OF_OLDTON_MOVALPOLOS, tpz.ki.MAP_OF_NEWTON_MOVALPOLOS, tpz.ki.MAP_OF_TAVNAZIA, tpz.ki.MAP_OF_THE_AQUEDUCTS, tpz.ki.MAP_OF_THE_SACRARIUM, tpz.ki.MAP_OF_CAPE_RIVERNE, tpz.ki.MAP_OF_ALTAIEU, tpz.ki.MAP_OF_HUXZOI, tpz.ki.MAP_OF_RUHMET, tpz.ki.MAP_OF_AL_ZAHBI, tpz.ki.MAP_OF_NASHMAU,
    tpz.ki.MAP_OF_WAJAOM_WOODLANDS, tpz.ki.MAP_OF_CAEDARVA_MIRE, tpz.ki.MAP_OF_MOUNT_ZHAYOLM, tpz.ki.MAP_OF_AYDEEWA_SUBTERRANE, tpz.ki.MAP_OF_MAMOOK, tpz.ki.MAP_OF_HALVUNG, tpz.ki.MAP_OF_ARRAPAGO_REEF, tpz.ki.MAP_OF_ALZADAAL_RUINS, tpz.ki.MAP_OF_BHAFLAU_THICKETS,
    tpz.ki.MAP_OF_VUNKERL_INLET, tpz.ki.MAP_OF_GRAUBERG, tpz.ki.MAP_OF_FORT_KARUGONARUGO}

local Uoption = {    --User option selected.
    1,            --SanDoria Area
    65537,        --Bastok Area
    131073,        --Windurst Area
    196609,        --Jeuno Area
    262145,        --Ordelles Caves
    327681,        --Ghelsba
    393217,        --Davoi
    458753,        --Carpenters Landing
    524289,        --Zeruhn Mines
    589825,        --Palborough Mines
    655361,        --Beadeaux
    720897,        --Giddeus
    786433,        --Castle Oztroja
    851969,        --Maze of Shakhrami
    917505,        --Li'Telor Region
    983041,        --Bibiki Bay
    1048577,    --Qufim Island
    1114113,    --Eldieme Necropolis
    1179649,    --Garlaige Citadel
    1245185,    --Elshimo Regions
    1310721,    --Northlands Area
    1376257,    --King Ranperres Tomb
    1441793,    --Dangruf Wadi
    1507329,    --Horutoto Ruins
    1572865,    --Bostaunieux Oubliette
    1638401,    --Toraimarai Canal
    1703937,    --Gusgen Mines
    1769473,    --Crawlers Nest
    1835009,    --Ranguemont Pass
    1900545,    --Delkfutts Tower
    1966081,    --Feiyin
    2031617,    --Castle Zvahl
    2097153,    --Kuzotz region
    2162689,    --Ru'Aun Gardens
    2228225,    --Norg
    2293761,    --Temple of Uggalepih
    2359297,    --Den of Rancor
    2424833,    --Korroloka Tunnel
    2490369,    --Kuftal Tunnel
    2555905,    --Boyahda Tree
    2621441,    --Ve'Lugannon Palace
    2686977,    --Ifrit's Cauldron
    2752513,    --Quicksand Caves
    2818049,    --Sea Serpent Grotto
    2883585,    --Vollbow region
    2949121,    --Labyrinth of Onzozo
    3014657,    --Uleguerand Range
    3080193,    --Attohwa Chasm
    3145729,    --Pso'Xja
    3211265,    --Oldton Movalpolos
    3276801,    --Newton Movalpolos
    3342337,    --Tavnazia
    3407873,    --Aqueducts
    3473409,    --Sacrarium
    3538945,    --Cape Riverne
    3604481,    --Al'Taieu
    3670017,    --Hu'Xzoi
    3735553,    --Ru'Hmet
    3801089,    --Al Zahbi
    3866625,    --Nashmau
    3932161,    --Wajaom Woodlands
    3997697,    --Caedarva Mire
    4063233,    --Mount Zhayolm
    4128769,    --Aydeewa Subterrane
    4194305,    --Mamook
    4259841,    --Halvung
    4325377,    --Arrapago Reef
    4390913,    --Alzadall Ruins
    4456449,    --Bhaflau Thickets
    4521985,    --Vunkerl Inlet
    4587521,    --Grauberg
    4653057        --Fort Karugo-Narugo
    }

--Groups maps by price, based off the user option.
local p2 = { --Maps that are price at 200 gil
    Uoption[1],        --SanDoria Area
    Uoption[2],        --Bastok Area
    Uoption[3],        --Windurst Area
    Uoption[9]        --Zeruhn Mines
    }
local p6 = { --Maps that are price at 600 gil
    Uoption[4],        --Jeuno Area
    Uoption[5],        --Ordelles Caves
    Uoption[6],        --Ghelsba
    Uoption[10],    --Palborough Mines
    Uoption[11],    --Beadeaux
    Uoption[12],    --Giddeus
    Uoption[14],    --Maze of Shakhrami
    Uoption[22],    --King Ranperres Tomb
    Uoption[23],    --Dangruf Wadi
    Uoption[24],    --Horutoto Ruins
    Uoption[27],    --Gusgen Mines
    Uoption[59]        --Al Zahbi
    }
local p3 = {    --Maps that are price at 3000 gil
    Uoption[7],        --Davoi
    Uoption[8],        --Carpenters Landing
    Uoption[13],    --Castle Oztroja
    Uoption[15],    --Li'Telor Region
    Uoption[16],    --Bibiki Bay
    Uoption[17],    --Qufim Island
    Uoption[18],    --Eldieme Necropolis
    Uoption[19],    --Garlaige Citadel
    Uoption[20],    --Elshimo Regions
    Uoption[21],    --Northlands Area
    Uoption[25],    --Bostaunieux Oubliette
    Uoption[26],    --Toraimarai Canal
    Uoption[28],    --Crawlers Nest
    Uoption[29],    --Ranguemont Pass
    Uoption[30],    --Delkfutts Tower
    Uoption[31],    --Feiyin
    Uoption[32],    --Castle Zvahl
    Uoption[33],    --Kuzotz region
    Uoption[34],    --Ru'Aun Gardens
    Uoption[35],    --Norg
    Uoption[36],    --Temple of Uggalepih
    Uoption[37],    --Den of Rancor
    Uoption[38],    --Korroloka Tunnel
    Uoption[39],    --Kuftal Tunnel
    Uoption[40],    --Boyahda Tree
    Uoption[41],    --Ve'Lugannon Palace
    Uoption[42],    --Ifrit's Cauldron
    Uoption[43],    --Quicksand Caves
    Uoption[44],    --Sea Serpent Grotto
    Uoption[45],    --Vollbow region
    Uoption[46],    --Labyrinth of Onzozo
    Uoption[47],    --Uleguerand Range
    Uoption[48],    --Attohwa Chasm
    Uoption[49],    --Pso'Xja
    Uoption[50],    --Oldton Movalpolos
    Uoption[51],    --Newton Movalpolos
    Uoption[52],    --Tavnazia
    Uoption[53],    --Aqueducts
    Uoption[54],    --Sacrarium
    Uoption[55],    --Cape Riverne
    Uoption[56],    --Al'Taieu
    Uoption[57],    --Hu'Xzoi
    Uoption[58],    --Ru'Hmet
    Uoption[60],    --Nashmau
    Uoption[61],    --Wajaom Woodlands
    Uoption[62],    --Caedarva Mire
    Uoption[63],    --Mount Zhayolm
    Uoption[64],    --Aydeewa Subterrane
    Uoption[65],    --Mamook
    Uoption[66],    --Halvung
    Uoption[67],    --Arrapago Reef
    Uoption[68],    --Alzadall Ruins
    Uoption[69]        --Bhaflau Thickets
    }
local p30 = { --Maps that are price at 30, 000 gil
    Uoption[70],    --Vunkerl Inlet
    Uoption[71],    --Grauberg
    Uoption[72]        --Fort Karugo-Narugo
    }

function CheckMaps(player, npc, csid)
    local i = 0
    local mapVar1 = 0
    local mapVar2 = 0
    local mapVar3 = 0

    while i <= 31 do
        if player:hasKeyItem(Maps[i+1]) then
            mapVar1 = bit.bor(mapVar1, bit.lshift(1, i))
        end
        i = i + 1
    end

    while i <= 63 do
        if player:hasKeyItem(Maps[i+1]) then
            mapVar2 = bit.bor(mapVar2, bit.lshift(1, i))
        end
        i = i + 1
    end

    while i <= 71 do
        if player:hasKeyItem(Maps[i+1]) then
            mapVar3 = bit.bor(mapVar3, bit.lshift(1, i))
        end
        i = i + 1
    end

    player:startEvent(csid, mapVar1, mapVar2, mapVar3)
end

function CheckMapsUpdate (player, option, NOT_HAVE_ENOUGH_GIL, KEYITEM_OBTAINED)
    local price = 0
    local MadePurchase = false
    local KI = 0
    local i = 0
    local mapVar1 = 0
    local mapVar2 = 0
    local mapVar3 = 0

    while i <= 71 do
        if (option == Uoption[i+1]) then
            local x = 1
            while x <= 53 do
                if (x <= 4 and option == p2[x]) then
                    price = 200
                elseif (x <= 12 and option == p6[x]) then
                    price = 600
                elseif (x <= 53 and option == p3[x]) then
                    price = 3000
                elseif (x <= 3 and option == p30[x]) then
                    price = 30000
                end
                x=x+1
            end
            MadePurchase = true
            KI = Maps[i+1]
        end
        i = i + 1
    end

    if (price > player:getGil()) then
        player:messageSpecial(NOT_HAVE_ENOUGH_GIL)
        MadePurchase = false
        price = 0
    elseif (price > 0 and MadePurchase == true) then
        player:delGil(price)
        MadePurchase = false
        player:addKeyItem(KI)
        player:messageSpecial(KEYITEM_OBTAINED, KI)
    end

    i=0
    while i <= 31 do
        if player:hasKeyItem(Maps[i+1]) then
            mapVar1 = bit.bor(mapVar1, bit.lshift(1, i))
        end
        i = i + 1
    end

    while i <= 63 do
        if player:hasKeyItem(Maps[i+1]) then
            mapVar2 = bit.bor(mapVar2, bit.lshift(1, i))
        end
        i = i + 1
    end

    while i <= 71 do
        if player:hasKeyItem(Maps[i+1]) then
            mapVar3 = bit.bor(mapVar3, bit.lshift(1, i))
        end
        i = i + 1
    end

    player:updateEvent(mapVar1, mapVar2, mapVar3)
end
