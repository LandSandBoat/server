----------------------------------------
-- Campaign global
----------------------------------------
require("scripts/globals/teleports")
----------------------------------------

-- -------------------------------------------------------------------
-- getMedalRank()
-- Returns the numerical Campaign Medal of the player.
-- -------------------------------------------------------------------

function getMedalRank(player)
    local rank = 0
    local medals =
    {
         924, 925, 926, 927, 928, 929, 930,
         931, 932, 933, 934, 935, 936, 937,
         938, 939, 940, 941, 942, 943
    }
    while (player:hasKeyItem(medals[rank + 1]) == true) do
        rank = rank + 1
    end
    return rank
end

-- -------------------------------------------------------------------
-- get[nation]NotesItem()
-- Returns the item ID and cost of the Allied Notes indexed item
-- (the same value as that used by the vendor event)
-- Format:
-- ListName_AN_item[optionID] = itemID -- ItemName
-- ListName_AN_price[optionID] = cost -- ItemName
-- -------------------------------------------------------------------

function getSandOriaNotesItem(i)
    local SandOria_AN =
    {
        [2] = {id = 15754, price = 980}, -- Sprinter's Shoes
        [258] = {id = 5428, price = 10}, -- Scroll of Instant Retrace
        [514] = {id = 14584, price = 1500}, -- Iron Ram jack coat
        [770] = {id = 14587, price = 1500}, -- Pilgrim Tunica
        [1026] = {id = 16172, price = 4500}, -- Iron Ram Shield
        [1282] = {id = 15841, price = 5000}, -- Recall Ring: Jugner
        [1538] = {id = 15842, price = 5000}, -- Recall Ring: Pashhow
        [1794] = {id = 15843, price = 5000}, -- Recall Ring: Meriphataud
        [2050] = {id = 10116, price = 2000}, -- Cipher: Valaineral
        -- Stars Service
        [18] = {id = 14581, price = 15000}, -- Iron Ram Chainmain
        [274] = {id = 15005, price = 10500}, -- Iron Ram Mufflers
        [530] = {id = 15749, price = 10500}, -- Iron Ram Sollerets
        [786] = {id = 16141, price = 10500}, -- Iron Ram Helm
        [1042] = {id = 16312, price = 10500}, -- Iron Ram Breeches
        -- Emblems Service
        [34] = {id = 16312, price = 30000}, -- Iron Ram Horn
        [290] = {id = 16312, price = 30000}, -- Iron Ram Lance
        [546] = {id = 16312, price = 30000}, -- Iron Ram Pick
        [802] = {id = 16312, price = 60000}, -- Iron Ram Sallet
        [1058] = {id = 16312, price = 60000}, -- Iron Ram Dastanas
        -- Wings Service
        [50] = {id = 15755, price = 75000}, -- Iron Ram Greaves
        [306] = {id = 16315, price = 75000}, -- Iron Ram Hose
        -- Medals Service
        [66] = {id = 15844, price = 45000}, -- Patronus Ring
        [322] = {id = 15966, price = 45000}, -- Fox Earring
        [578] = {id = 15961, price = 45000}, -- Temple Earring
        [834] = {id = 15934, price = 45000}, -- Crimson Belt
        [1090] = {id = 19041, price = 45000}, -- Rose Strap
        [1346] = {id = 15488, price = 112500}, -- Iron Ram Hauberk
        [1602] = {id = 11356, price = 15000}, -- Royal Guard Livery
        -- Medal of Altana
        [82] = {id = 17684, price = 150000}, -- Griffinclaw
        [338] = {id = 11636, price = 75000} -- Royal Knight Sigil Ring
    }
    local item = SandOria_AN[i]
    return item.id, item.price
end

function getBastokNotesItem(i)
    local Bastok_AN =
    {
        [2] = {id = 15754, price = 980}, -- Sprinter's Shoes
        [258] = {id = 5428, price = 10}, -- Scroll of Instant Retrace
        [514] = {id = 14585, price = 1500}, -- Fourth Tunica
        [770] = {id = 14587, price = 1500}, -- Pilgrim Tunica
        [1026] = {id = 18727, price = 4500}, -- Fourth Gun
        [1282] = {id = 15841, price = 5000}, -- Recall Ring: Jugner
        [1538] = {id = 15842, price = 5000}, -- Recall Ring: Pashhow
        [1794] = {id = 15843, price = 5000}, -- Recall Ring: Meriphataud
        [2050] = {id = 10116, price = 2000}, -- Cipher: Valaineral
        -- Stars Service
        [18] = {id = 14582, price = 15000}, -- Fourth Cuirass
        [274] = {id = 15006, price = 10500}, -- Fourth Gauntlets
        [530] = {id = 15750, price = 10500}, -- Fourth Sabatons
        [786] = {id = 16142, price = 10500}, -- Fourth Armet
        [1042] = {id = 16313, price = 10500}, -- Fourth Cuisses
        -- Emblems Service
        [34] = {id = 18494, price = 30000}, -- Fourth Toporok
        [290] = {id = 18854, price = 30000}, -- Fourth Mace
        [546] = {id = 18946, price = 30000}, -- Fourth Zaghnal
        [802] = {id = 16147, price = 60000}, -- Fourth Haube
        [1058] = {id = 15010, price = 60000}, -- Fourth Hentzes
        -- Wings Service
        [50] = {id = 15756, price = 75000}, -- Fourth Schuhs
        [306] = {id = 16316, price = 75000}, -- Fourth Schoss
        -- Medals Service
        [66] = {id = 16291, price = 45000}, -- Shield Collar
        [322] = {id = 18734, price = 45000}, -- Sturm's Report
        [578] = {id = 18735, price = 45000}, -- Sonia's Plectrum
        [834] = {id = 16292, price = 45000}, -- Bull Necklace
        [1090] = {id = 16258, price = 45000}, -- Arrestor Mantle
        [1346] = {id = 14589, price = 112500}, -- Fourth Division Brunne
        [1602] = {id = 11357, price = 15000}, -- Mythril Musketeer Livery
        -- Medal of Altana
        [82] = {id = 17685, price = 150000}, -- Lex Talionis
        [338] = {id = 11545, price = 75000} -- Fourth Mantle
    }
    local item = Bastok_AN[i]
    return item.id, item.price
end

function getWindurstNotesItem(i)
    local Windurst_AN =
    {
        [2] = {id = 15754, price = 980}, -- Sprinter's Shoes
        [258] = {id = 5428, price = 10}, -- Scroll of Instant Retrace
        [514] = {id = 14586, price = 1500}, -- Cobra Tunica
        [770] = {id = 14587, price = 1500}, -- Pilgrim Tunica
        [1026] = {id = 19150, price = 4500}, -- Cobra CLaymore
        [1282] = {id = 15841, price = 5000}, -- Recall Ring: Jugner
        [1538] = {id = 15842, price = 5000}, -- Recall Ring: Pashhow
        [1794] = {id = 15843, price = 5000}, -- Recall Ring: Meriphataud
        [2050] = {id = 10116, price = 2000}, -- Cipher: Valaineral
        -- Stars Service
        [18] = {id = 14583, price = 15000}, -- Cobra Coat
        [274] = {id = 15007, price = 10500}, -- Cobra Cuffs
        [530] = {id = 15751, price = 10500}, -- Cobra Pigaches
        [786] = {id = 16143, price = 10500}, -- Cobra Hat
        [1042] = {id = 16314, price = 10500}, -- Cobra Slops
        -- Emblems Service
        [34] = {id = 18756, price = 30000}, -- Cobra Unit Baghnakhs
        [290] = {id = 19100, price = 30000}, -- Cobra Unit Knife
        [546] = {id = 18728, price = 30000}, -- Cobra Unit Bow
        [802] = {id = 16149, price = 60000}, -- Cobra Unit Cloche
        [1058] = {id = 15011, price = 60000}, -- Cobra Unit Mittens
        -- Wings Service
        [50] = {id = 15757, price = 75000}, -- Cobra Unit Leggings
        [306] = {id = 16317, price = 75000}, -- Cobra Unit Subligar
        [580] = {id = 15758, price = 75000}, -- Cobra Unit Crackows
        [1001] = {id = 16318, price = 75000}, -- Cobra Unit Trews
        -- Medals Service
        [66] = {id = 15935, price = 45000}, -- Capricornian Rope
        [322] = {id = 15936, price = 45000}, -- Earthly Belt
        [578] = {id = 16293, price = 45000}, -- Cougar Pendant
        [834] = {id = 16294, price = 45000}, -- Crocodile Collar
        [1090] = {id = 19041, price = 45000}, -- Ariesian Grip
        [1346] = {id = 19042, price = 112500}, -- Cobra Unit Harness
        [1602] = {id = 11358, price = 15000}, -- Patriarch Protector Livery
        -- Medal of Altana
        [82] = {id = 17684, price = 150000}, -- Samudra
        [338] = {id = 11636, price = 75000} -- Mercenary Major Charm
    }
    local item = Windurst_AN[i]
    return item.id, item.price
end

-- -------------------------------------------------------------------
-- getSigilTimeStamp(player)
-- This is for the time-stamp telling player what day/time the
-- effect will last until, NOT the actual status effect duration.
-- -------------------------------------------------------------------

function getSigilTimeStamp(player)
    local timeStamp = 0 -- zero'd till math is done.

    -- TODO: calculate time stamp for menu display of when it wears off

    return timeStamp
end

-- TODO:
-- Past nation teleport
