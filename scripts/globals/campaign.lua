-----------------------------------
-- Campaign global
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/zone")
require("scripts/globals/items")
-----------------------------------
xi = xi or {}
xi.campaign = {}

xi.campaign.control =
{
    Sandoria = 2,
    Bastok   = 4,
    Windurst = 6,
    Beastman = 8,
}

xi.campaign.union =
{
    Adder  = 1,
    Bison  = 2,
    Coyote = 3,
    Dhole  = 4,
    Eland  = 5,
}

xi.campaign.army =
{
    Sandoria = 0,
    Bastok   = 1,
    Windurst = 2,
    Orcish   = 3,
    Quadav   = 4,
    Yagudo   = 5,
    Kindred  = 6,
}

xi.campaign.zone =
{
    SouthernSandOria     = 80,
    EastRonfaure         = 81,
    JugnerForest         = 82,
    VunkerlInlet         = 83,
    BatalliaDowns        = 84,
    LaVaule              = 85,
    TheEldiemeNecropolis = 175,
    BastokMarkets        = 87,
    NorthGustaberg       = 88,
    Grauberg             = 89,
    PashhowMarshlands    = 90,
    RolanberryFields     = 91,
    Beadeaux             = 92,
    CrawlersNest         = 171,
    WindurstWaters       = 94,
    WestSarutabaruta     = 95,
    FortKarugoNarugo     = 96,
    MeriphataudMountains = 97,
    SauromugueChampaign  = 98,
    CastleOztroja        = 99,
    GarlaigeCitadel      = 164,
    BeaucedineGlacier    = 136,
    Xarcabard            = 137,
    CastleZvahlBaileys   = 138,
    CastleZvahlKeep      = 155,
    ThroneRoom           = 156,
}

-----------------------------------------------------------------
-- Variable for getNationTeleport and getPoint
-----------------------------------------------------------------

--[[
ALLIED_NOTES = 11
MAW = 4
PAST_SANDORIA = 5
PAST_BASTOK = 6
PAST_WINDURST = 7
]]

-- -------------------------------------------------------------------
-- getMedalRank()
-- Returns the numerical Campaign Medal of the player.
-- -------------------------------------------------------------------

xi.campaign.getMedalRank = function(player)
    local rank = 0
    -- TODO: Use xi.ki enum in this table
    local medals =
    {
        924, 925, 926, 927, 928, 929, 930,
        931, 932, 933, 934, 935, 936, 937,
        938, 939, 940, 941, 942, 943
    }

    while player:hasKeyItem(medals[rank + 1]) do
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

xi.campaign.getSandOriaNotesItem = function(i)
    local sandOriaAlliedNotesItems =
    {
        [2] = { id = 15754, price = 980 }, -- Sprinter's Shoes
        [258] = { id = 5428, price = 10 }, -- Scroll of Instant Retrace
        [514] = { id = 14584, price = 1500, adj = 1000 }, -- Iron Ram jack coat
        [770] = { id = 14587, price = 1500, adj = 1000 }, -- Pilgrim Tunica
        [1026] = { id = 16172, price = 4500, adj = 3000 }, -- Iron Ram Shield
        [1282] = { id = 15841, price = 5000, adj = 5000 }, -- Recall Ring: Jugner
        [1538] = { id = 15842, price = 5000, adj = 5000 }, -- Recall Ring: Pashow
        [1794] = { id = 15843, price = 5000, adj = 5000 }, -- Recall Ring: Meriphataud
        [2050] = { id = xi.items.CIPHER_OF_VALAINERALS_ALTER_EGO, price = 2000 }, -- Cipher: Valaineral
        [2306] = { id = xi.items.CIPHER_OF_ADELHEIDS_ALTER_EGO, price = 2000 }, -- Cipher: Adelheid
        -- Stars Service
        [18] = { id = 14581, price = 15000, adj = 10000 }, -- Iron Ram Chainmain
        [274] = { id = 15005, price = 10500, adj = 7000 }, -- Iron Ram Mufflers
        [530] = { id = 15749, price = 10500, adj = 7000 }, -- Iron Ram Sollerets
        [786] = { id = 16141, price = 10500, adj = 7000 }, -- Iron Ram Helm
        [1042] = { id = 16312, price = 10500, adj = 7000 }, -- Iron Ram Breeches
        -- Emblems Service
        [34] = { id = 17853, price = 30000, adj = 20000 }, -- Iron Ram Horn
        [290] = { id = 18074, price = 30000, adj = 20000 }, -- Iron Ram Lance
        [546] = { id = 17958, price = 30000, adj = 20000 }, -- Iron Ram Pick
        [802] = { id = 16146, price = 60000, adj = 40000 }, -- Iron Ram Sallet
        [1058] = { id = 15009, price = 60000, adj = 40000 }, -- Iron Ram Dastanas
        -- Wings Service
        [50] = { id = 15755, price = 75000, adj = 50000 }, -- Iron Ram Greaves
        [306] = { id = 16315, price = 75000, adj = 50000 }, -- Iron Ram Hose
        -- Medals Service
        [66] = { id = 15844, price = 45000, adj = 30000 }, -- Patronus Ring
        [322] = { id = 15966, price = 45000, adj = 30000 }, -- Fox Earring
        [578] = { id = 15961, price = 45000, adj = 30000 }, -- Temple Earring
        [834] = { id = 15934, price = 45000, adj = 30000 }, -- Crimson Belt
        [1090] = { id = 19041, price = 45000, adj = 30000 }, -- Rose Strap
        [1346] = { id = 14588, price = 112500, adj = 75000 }, -- Iron Ram Hauberk
        [1602] = { id = 11356, price = 15000, adj = 10000 }, -- Royal Guard Livery
        [1858] = { id = 14671, price = 22500, adj = 15000 }, -- Alied ring
        -- Medal of Altana
        [82] = { id = 17684, price = 150000, adj = 100000 }, -- Griffinclaw
        [338] = { id = 11636, price = 75000, adj = 50000 } -- Royal Knight Sigil Ring
    }
    local item = sandOriaAlliedNotesItems[i]
    return item.id, item.price, item.adj
end

xi.campaign.getBastokNotesItem = function(i)
    local bastokAlliedNotesItems =
    {
        [2] = { id = 15754, price = 980 }, -- Sprinter's Shoes
        [258] = { id = 5428, price = 10 }, -- Scroll of Instant Retrace
        [514] = { id = 14585, price = 1500, adj = 1000 }, -- Fourth Tunica
        [770] = { id = 14587, price = 1500, adj = 1000 }, -- Pilgrim Tunica
        [1026] = { id = 18727, price = 4500, adj = 3000 }, -- Fourth Gun
        [1282] = { id = 15841, price = 5000 }, -- Recall Ring: Jugner
        [1538] = { id = 15842, price = 5000 }, -- Recall Ring: Pashow
        [1794] = { id = 15843, price = 5000 }, -- Recall Ring: Meriphataud
        [2050] = { id = 10116, price = 2000 }, -- Cipher: Valaineral
        [2306] = { id = 10153, price = 2000 }, -- Cipher: Adelheid
        -- Stars Service
        [18] = { id = 14582, price = 15000, adj = 10000 }, -- Fourth Cuirass
        [274] = { id = 15006, price = 10500, adj = 7000 }, -- Fourth Gauntlets
        [530] = { id = 15750, price = 10500, adj = 7000 }, -- Fourth Sabatons
        [786] = { id = 16142, price = 10500, adj = 7000 }, -- Fourth Armet
        [1042] = { id = 16313, price = 10500, adj = 7000 }, -- Fourth Cuisses
        -- Emblems Service
        [34] = { id = 18494, price = 30000, adj = 20000 }, -- Fourth Toporok
        [290] = { id = 18854, price = 30000, adj = 20000 }, -- Fourth Mace
        [546] = { id = 18946, price = 30000, adj = 20000 }, -- Fourth Zaghnal
        [802] = { id = 16147, price = 60000, adj = 40000 }, -- Fourth Haube
        [1058] = { id = 15010, price = 60000, adj = 40000 }, -- Fourth Hentzes
        -- Wings Service
        [50] = { id = 15756, price = 75000, adj = 50000 }, -- Fourth Schuhs
        [306] = { id = 16316, price = 75000, adj = 50000 }, -- Fourth Schoss
        -- Medals Service
        [66] = { id = 16291, price = 45000, adj = 30000 }, -- Shield Collar
        [322] = { id = 18734, price = 45000, adj = 30000 }, -- Sturm's Report
        [578] = { id = 18735, price = 45000, adj = 30000 }, -- Sonia's Plectrum
        [834] = { id = 16292, price = 45000, adj = 30000 }, -- Bull Necklace
        [1090] = { id = 16258, price = 45000, adj = 30000 }, -- Arrestor Mantle
        [1346] = { id = 14589, price = 112500, adj = 75000 }, -- Fourth Division Brunne
        [1602] = { id = 11357, price = 15000, adj = 10000 }, -- Mythril Musketeer Livery
        [1858] = { id = 14671, price = 22500, adj = 15000 }, -- Alied ring
        -- Medal of Altana
        [82] = { id = 17685, price = 150000, adj = 100000 }, -- Lex Talionis
        [338] = { id = 11545, price = 75000, adj = 50000 } -- Fourth Mantle
    }
    local item = bastokAlliedNotesItems[i]
    return item.id, item.price, item.adj
end

xi.campaign.getWindurstNotesItem = function(i)
    local windurstAlliedNotesItems =
    {
        [2] = { id = 15754, price = 980 }, -- Sprinter's Shoes
        [258] = { id = 5428, price = 10 }, -- Scroll of Instant Retrace
        [514] = { id = 14586, price = 1500, adj = 1000 }, -- Cobra Tunica
        [770] = { id = 14587, price = 1500, adj = 1000 }, -- Pilgrim Tunica
        [1026] = { id = 19150, price = 4500, adj = 3000 }, -- Cobra CLaymore
        [1282] = { id = 15841, price = 5000 }, -- Recall Ring: Jugner
        [1538] = { id = 15842, price = 5000 }, -- Recall Ring: Pashow
        [1794] = { id = 15843, price = 5000 }, -- Recall Ring: Meriphataud
        [2050] = { id = 10116, price = 2000 }, -- Cipher: Valaineral
        [2306] = { id = 10153, price = 2000 }, -- Cipher: Adelheid
        -- Stars Service
        [18] = { id = 14583, price = 15000, adj = 10000 }, -- Cobra Coat
        [274] = { id = 15007, price = 10500, adj = 7000 }, -- Cobra Cuffs
        [530] = { id = 15751, price = 10500, adj = 7000 }, -- Cobra Pigaches
        [786] = { id = 16143, price = 10500, adj = 7000 }, -- Cobra Hat
        [1042] = { id = 16314, price = 10500, adj = 7000 }, -- Cobra Slops
        -- Emblems Service
        [34] = { id = 18756, price = 30000, adj = 20000 }, -- Cobra Unit Baghnakhs
        [290] = { id = 19100, price = 30000, adj = 20000 }, -- Cobra Unit Knife
        [546] = { id = 18728, price = 30000, adj = 20000 }, -- Cobra Unit Bow
        [802] = { id = 16148, price = 60000, adj = 40000 }, -- Cobra Unit Cap
        [1058] = { id = 15011, price = 60000, adj = 40000 }, -- Cobra Unit Mittens
        [1314] = { id = 16149, price = 60000, adj = 40000 }, -- Cobra Unit Cloche
        [1570] = { id = 15012, price = 60000, adj = 40000 }, -- Cobra Unit Gloves
        -- Wings Service
        [50] = { id = 15757, price = 75000, adj = 50000 }, -- Cobra Unit Leggings
        [306] = { id = 16317, price = 75000, adj = 50000 }, -- Cobra Unit Subligar
        [562] = { id = 15758, price = 75000, adj = 50000 }, -- Cobra Unit Crackows
        [818] = { id = 16318, price = 75000, adj = 50000 }, -- Cobra Unit Trews
        -- Medals Service
        [66] = { id = 15935, price = 45000, adj = 30000 }, -- Capricornian Rope
        [322] = { id = 15936, price = 45000, adj = 30000 }, -- Earthly Belt
        [578] = { id = 16293, price = 45000, adj = 30000 }, -- Cougar Pendant
        [834] = { id = 16294, price = 45000, adj = 30000 }, -- Crocodile Collar
        [1090] = { id = 19042, price = 45000, adj = 30000 }, -- Ariesian Grip
        [1346] = { id = 14590, price = 112500, adj = 75000 }, -- Cobra Unit Harness
        [1602] = { id = 14591, price = 15000, adj = 75000 }, -- Cobra Unit Robe
        [1858] = { id = 14671, price = 22500, adj = 15000 }, -- Alied ring
        -- Medal of Altana
        [82] = { id = 17684, price = 150000, adj = 10000 }, -- Samudra
        [338] = { id = 11636, price = 75000, adj = 50000 } -- Mercenary Major Charm
    }
    local item = windurstAlliedNotesItems[i]
    return item.id, item.price, item.adj
end

-- -------------------------------------------------------------------
-- getSigilTimeStamp(player)
-- This is for the time-stamp telling player what day/time the
-- effect will last until, NOT the actual status effect duration.
-- -------------------------------------------------------------------

xi.campaign.getSigilTimeStamp = function(player)
    local timeStamp = 0 -- zero'd till math is done.

    -- TODO: calculate time stamp for menu display of when it wears off

    return timeStamp
end

-----------------------------------
-- hasMawActivated Action
-----------------------------------

-- 1st number for hasMawActivated()
-- 2nd number for player:addNationTeleport()

-- 0    1   Batallia Downs (S) (H-5)
-- 1    2   Rolanberry Fields (S) (H-6)
-- 2    4   Sauromugue Champaign (S) (K-9)
-- 3    8   Jugner Forest (S) (H-11)
-- 4    16  Pashhow Marshlands (S) (K-8)
-- 5    32  Meriphataud Mountains (S) (K-6)
-- 6    64  East Ronfaure (S) (H-5)
-- 7    128 North Gustaberg (S) (K-7)
-- 8    256 West Sarutabaruta (S) (H-9)
--[[
function hasMawActivated(player, portal)
    local mawActivated = player:getNationTeleport(MAW)
    local bit = {}

    for i = 8, 0, -1 do
        local twop = 2^i

        if (mawActivated >= twop) then
            bit[i] = true mawActivated = mawActivated - twop
        else
            bit[i] = false
        end
    end

    return bit[portal]
end
]]
-- TODO:
-- Past nation teleport
