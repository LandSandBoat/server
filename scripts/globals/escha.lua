-------------------------------------------
-- Global Escha/Reisenjima utility script
-------------------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/keyitems")
require("scripts/globals/vorseals")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
require("scripts/settings/main")
-------------------------------------------

xi = xi or {}
xi.escha = xi.escha or {}

local KIList =
{
    {ki = xi.keyItem.TRIBULENS         , name = "TRIBULENS"         , offset = 0,  cost = 1000 },
    {ki = xi.keyItem.REAPER            , name = "REAPER"            , offset = 1,  cost = 50   },
    {ki = xi.keyItem.MAP_OF_ESCHA_ZITAH, name = "MAP_OF_ESCHA_ZITAH", offset = 2,  cost = 50   },
    {ki = xi.keyItem.MAP_OF_ESCHA_RUAUN, name = "MAP_OF_ESCHA_RUAUN", offset = 3,  cost = 50   },
    {ki = xi.keyItem.MAP_OF_REISENJIMA , name = "MAP_OF_REISENJIMA" , offset = 4,  cost = 50   },
    {ki = xi.keyItem.ESCHAN_URN        , name = "ESCHAN_URN"        , offset = 5,  cost = 2000 },
    {ki = xi.keyItem.ESCHAN_CELLAR     , name = "ESCHAN_CELLAR"     , offset = 6,  cost = 10000},
    {ki = xi.keyItem.ESCHAN_NEF        , name = "ESCHAN_NEF"        , offset = 7,  cost = 50000},
    {ki = xi.keyItem.PRIMAL_NAZAR      , name = "PRIMAL_NAZAR"      , offset = 8,  cost = 0    },
    {ki = xi.keyItem.RADIALENS         , name = "RADIALENS"         , offset = 9,  cost = 10000},
    {ki = xi.keyItem.MOLLIFIER         , name = "MOLLIFIER"         , offset = 10, cost = 500  },
}

local tempItem =
{
    [4182] = {name = "scroll_of_instant_reraise", offset = 0},
    [5824] = {name = "lucid_potion_i"           , offset = 1},
    [5827] = {name = "lucid_ether_i"            , offset = 2},
}

local areaBlessing =
{
    ["Courage"]    = {bit = 20},
    ["Mercy"]      = {bit = 19},
    ["Loyalty"]    = {bit = 18},
    ["Dignity"]    = {bit = 17},
    ["Compassion"] = {bit = 16},
    ["Wisdom"]     = {bit = 15},
    ["Hope"]       = {bit = 14},
    ["Justice"]    = {bit = 13},
    ["Piety"]      = {bit = 12},
    ["Fortitude"]  = {bit = 11},
    ["Temperance"] = {bit = 10},
    ["Charity"]    = {bit =  9},
}

local trinkets =
{
    [xi.zone.ESCHA_ZITAH] =
    {
        [xi.keyItem.WEPWAWETS_TOOTH]    = 0,
        [xi.keyItem.LYDIAS_VINE]        = 1,
        [xi.keyItem.AGLAOPHOTIS_BUD]    = 2,
        [xi.keyItem.TANGATAS_WING]      = 3,
        [xi.keyItem.VIDALAS_CLAW]       = 4,
        [xi.keyItem.GESTALTS_RETINA]    = 5,
        [xi.keyItem.ANGRBODAS_NECKLACE] = 6,
        [xi.keyItem.CUNNASTS_TALON]     = 7,
        [xi.keyItem.REVETAURS_HORN]     = 8,
        [xi.keyItem.FERRODONS_SCALE]    = 9,
        [xi.keyItem.GULLTOPS_SHELL]     = 10,
        [xi.keyItem.VYALAS_PREY]        = 11,
        [xi.keyItem.IONOSS_WEBBING]     = 12,
        [xi.keyItem.SANDYS_LASHER]      = 13,
        [xi.keyItem.NOSOIS_FEATHER]     = 14,
        [xi.keyItem.BRITTLISS_RING]     = 15,
        [xi.keyItem.KAMOHOALIIS_FIN]    = 16,
        [xi.keyItem.UMDHLEBIS_FLOWER]   = 17,
        [xi.keyItem.FLEETSTALKERS_CLAW] = 18,
        [xi.keyItem.SHOCKMAWS_BLUBBER]  = 19,
        [xi.keyItem.URMAHLULLUS_ARMOR]  = 20,
    },
    [xi.zone.ESCHA_RUAUN] =
    {
        [xi.keyItem.ASIDAS_GEL]             = 0,
        [xi.keyItem.BIAS_GLOVE]             = 1,
        [xi.keyItem.EMPUTAS_WING]           = 2,
        [xi.keyItem.KHONS_SCEPTER]          = 3,
        [xi.keyItem.KHUNS_CROWN]            = 4,
        [xi.keyItem.MAS_LANCE]              = 5,
        [xi.keyItem.METS_RING]              = 6,
        [xi.keyItem.PEIRITHOOSS_HOOF]       = 7,
        [xi.keyItem.RUEAS_STONE]            = 8,
        [xi.keyItem.SAVA_SAVANOVICS_CAPE]   = 9,
        [xi.keyItem.TENODERAS_SCYTHE]       = 10,
        [xi.keyItem.WASSERSPEIERS_HORN]     = 11,
        [xi.keyItem.AMYMONES_TOOTH]         = 12,
        [xi.keyItem.HANBIS_NAIL]            = 13,
        [xi.keyItem.KAMMAVACAS_BINDING]     = 14,
        [xi.keyItem.NAPHULAS_BRACELET]      = 15,
        [xi.keyItem.PALILAS_TALON]          = 16,
        [xi.keyItem.YILANS_SCALE]           = 17,
        [xi.keyItem.DUKE_VEPARS_SIGNET]     = 18,
        [xi.keyItem.PAKECETS_BLUBBER]       = 19,
        [xi.keyItem.VIRAVAS_STALK]          = 20,
        [xi.keyItem.ARK_ANGEL_EVS_SASH]     = 21,
        [xi.keyItem.ARK_ANGEL_GKS_BANGLE]   = 22,
        [xi.keyItem.ARK_ANGEL_HMS_COAT]     = 23,
        [xi.keyItem.ARK_ANGEL_MRS_BUCKLE]   = 24,
        [xi.keyItem.ARK_ANGEL_TTS_NECKLACE] = 25,
        [xi.keyItem.BYAKKOS_PRIDE]          = 26,
        [xi.keyItem.GENBUS_HONOR]           = 27,
        [xi.keyItem.KIRINS_FERVOR]          = 28,
        [xi.keyItem.SEIRYUS_NOBILITY]       = 29,
        [xi.keyItem.SUZAKUS_BENEFACTION]    = 30,
        [xi.keyItem.PRIMAL_NAZAR]           = 31,
    },
    [xi.zone.REISENJIMA] =
    {
        [xi.keyItem.BELPHEGORS_CROWN]              = 0,
        [xi.keyItem.CROM_DUBHS_HELM]               = 1,
        [xi.keyItem.DAZZLING_DOLORESS_VINE]        = 2,
        [xi.keyItem.GOLDEN_KISTS_KEY]              = 3,
        [xi.keyItem.KABANDHAS_WING]                = 4,
        [xi.keyItem.MAUVE_WRISTED_GOMBERRYS_KNIFE] = 5,
        [xi.keyItem.ORYXS_PLUMAGE]                 = 6,
        [xi.keyItem.SABOTENDER_ROYALS_NEEDLE]      = 7,
        [xi.keyItem.SANG_BUAYAS_TUSK]              = 8,
        [xi.keyItem.SELKITS_PINCER]                = 9,
        [xi.keyItem.TAELMOTHS_STAFF]               = 10,
        [xi.keyItem.ZDUHACS_TALON]                 = 11,
        [xi.keyItem.BASHMUS_TRINKET]               = 12,
        [xi.keyItem.GAJASIMHAS_MANE]               = 13,
        [xi.keyItem.IRONSIDES_MAUL]                = 14,
        [xi.keyItem.OLD_SHUCKS_TUFT]               = 15,
        [xi.keyItem.SARSAOKS_HOARD]                = 16,
        [xi.keyItem.STROPHADIAS_PEARL]             = 17,
        [xi.keyItem.MAJUS_CLAW]                    = 18,
        [xi.keyItem.NEAKS_TREASURE]                = 19,
        [xi.keyItem.YAKSHIS_SCROLL]                = 20,
        [xi.keyItem.ALBUMENS_FLOWER]               = 21,
        [xi.keyItem.ERINYSS_BEAK]                  = 22,
        [xi.keyItem.ONYCHOPHORAS_SOIL]             = 23,
        [xi.keyItem.SCHAHS_GAMBIT]                 = 24,
        [xi.keyItem.TELESS_HYMN]                   = 25,
        [xi.keyItem.VINIPATAS_BLADE]               = 26,
        [xi.keyItem.ZERDES_CUP]                    = 27,
    }
}
---------------------------------------------------------------------------
-- Notes:
---------------------------------------------------------------------------
-- [   Dragon   ][         Zone         ][  Vorseal Unlocked  ]
---------------------------------------------------------------------------
-- Azi Dahaka   |   Escha - Zi'Tah      |     Regen
-- Naga Raja    |   Escha - Ru'Aun      |     Refresh
-- Quetzalcoatl |   Reisenjima          |     Accuracy++
---------------------------------------------------------------------------
-- [Vorseal Tier]     1   2   3    4    5    6    7     8     9    10    11
-- [Number of Kills]  1   5  10   20   40   60   80   100   160   240   360
---------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------
-- Local functions
-----------------------------------------------------------------------------------------------
local function getZoneInfo(player)
    local zoneName = player:getZoneName()
    --------------------------------------------------------------------------------------
    -- Area Blessings
    -- One blessing is randomly chosen when domain invasion ends in that zone.
    -- Every single one can be active in a zone.
    --------------------------------------------------------------------------------------
    local junk1        = "0" -- bit [23]
    local junk2        = "0" -- bit [22]
    local junk3        = "0" -- bit [21]
    local Courage      = "1" -- bit [20]
    local Mercy        = "0" -- bit [19]
    local Loyalty      = "0" -- bit [18]
    local Dignity      = "0" -- bit [17]
    local Compassion   = "0" -- bit [16]
    local Wisdom       = "1" -- bit [15]
    local Hope         = "0" -- bit [14]
    local Justice      = "0" -- bit [13]
    local Piety        = "0" -- bit [12]
    local Fortitude    = "1" -- bit [11]
    local Temperance   = "1" -- bit [10]
    local Charity      = "0" -- bit [9]
    local junk4        = "0" -- bit [8]
    local junk5        = "0" -- bit [7]
    local junk6        = "0" -- bit [6]
    local junk7        = "0" -- bit [5]
    local junk8        = "0" -- bit [4]
    local something1   = "0" -- bit [3]
    local something2   = "0" -- bit [2]
    local Mieru        = "1" -- bit [1]
    local reglarDragon = "0" -- bit [0]

    local zoneInfo = 1048578 -- GetServerVariable("["..zoneName.."]ZoneInfo")

    if player:hasStatusEffect(xi.effect.ELVORSEAL) then
        zoneInfo = zoneInfo -(utils.MAX_INT32 +1)
    end

    print("zoneInfo: " ..zoneInfo)
    return zoneInfo
end

local function getAvailableTrinkets(player)
    local trinketsAvailable = 0x1FFFFF

    for k, v in pairs(trinkets[player:getZoneID()]) do
        if player:hasKeyItem(k) then
            trinketsAvailable = utils.mask.setBit(trinketsAvailable,v, false)
        end
    end

    return trinketsAvailable
end

local function getPlayerEschaStatus(player)
    local statusVar = player:getCharVar("["..player:getZoneName().."]EschaStatus")
    local zoneID    = player:getZoneID()
    local keyitems  = 0

    for k,v in pairs(KIList) do
        local i = KIList[k]
        if player:hasKeyItem(i.ki)
            or (i.ki == 2307 and zoneID ~= xi.zone.ESCHA_ZITAH)
            or (i.ki == 2308 and zoneID ~= xi.zone.ESCHA_RUAUN)
            or (i.ki == 2309 and zoneID ~= xi.zone.REISENJIMA )
            or (i.ki == 2986 and zoneID ~= xi.zone.ESCHA_RUAUN) then
            keyitems = keyitems + bit.lshift(1, i.offset)
            print("player has keyitem: " ..i.name)
        end
    end

    statusVar = statusVar + keyitems

    print("Escha status: "..statusVar)
    return statusVar
end

local function getTutorialStatus(player)
    local zoneName = player:getZoneName()
    local mask     = player:getCharVar("["..zoneName.."]EschaStatus")
    local tutBit   = bit.rshift(mask, 24)

    if mask == 0 or mask == nil then
        player:addCharVar("["..zoneName.."]EschaStatus", 0x4000000)
    end

    print("Tutorial status: " ..tutBit)
    return tutBit
end

local function setTutorialDone(player)
    local zoneName = player:getZoneName()
    print("Setting Tutorial to done!")
    player:addCharVar("["..zoneName.."]EschaStatus", 0x3000000)
end

local function updateVorsealEvent(player)
    local eschaStatus = getPlayerEschaStatus(player)
    local beads       = player:getCurrency("escha_beads")
    local silt        = player:getCurrency("escha_silt")
    local vorsealSetA = player:getCharVar("vorseal_a")
    local vorsealSetB = player:getCharVar("vorseal_b")
    local vorsealSetC = player:getCharVar("vorseal_c")

    player:updateEvent(beads, silt, eschaStatus, 0, vorsealSetA, vorsealSetB, vorsealSetC, 0)
end

local function getVorsealValue(player, vorseal)
    local value = bit.band(bit.rshift(player:getCharVar(vorseal.vorsealSet), vorseal.bitOffset), 0xF) or 0
    print("Value of this vorseal is: " ..value)
    return value
end

local function upgradeVorseal(player, option)
    local vorsealNum = bit.band(bit.rshift(option, 8), 0xF)
    local vorseal    = nil

    for k,v in pairs(xi.vorseals.upgradeMap) do
        if v.option == vorsealNum then
            vorseal = v
        end
    end

    if vorseal ~= nil then
        local amount = bit.rshift(option, 16) -getVorsealValue(player, vorseal)
        local cost   = 600 * amount
        print("Upgrading Vorseal " ..vorseal.name.. " value by " ..amount.. " Cost: " ..cost)

        if player:getCurrency("escha_silt") >= cost then
            player:delCurrency("escha_silt", cost)
            player:addCharVar(vorseal.vorsealSet, bit.lshift(amount, vorseal.bitOffset))
            -- If this is the first time upgrading a vorseal, then we need to add the vorseal effect.
            if not player:getStatusEffect(xi.effect.VORSEAL) then
                player:addStatusEffectEx(xi.effect.VORSEAL, xi.effect.VORSEAL, 0, 3600, 0)
            end
        end
    end

    updateVorsealEvent(player)
end

local function returnVorseal(player, option)
    local vorsealNum = bit.band(bit.rshift(option, 8), 0xF)
    local vorseal    = nil

    for k,v in pairs(xi.vorseals.upgradeMap) do
        if v.option == vorsealNum then
            vorseal = v
        end
    end

    if vorseal ~= nil then
        ----------------------------------------------------------------------------
        -- DEBUG
        local amount = getVorsealValue(player, vorseal)
        print("Downgrading Vorseal " ..vorseal.name.. " value from " ..amount.. " to " ..amount-1)
        -----------------------------------------------------------------------------
        player:addCharVar(vorseal.vorsealSet, -bit.lshift(1, vorseal.bitOffset))
        -- TODO: check if vorseal has worn, adjusting a vorseal will re-apply vorseal effect?
        if not player:getStatusEffect(xi.effect.VORSEAL) then
            player:addStatusEffectEx(xi.effect.VORSEAL, xi.effect.VORSEAL, 0, 3600, 0)
        end
    end

    updateVorsealEvent(player)
end

local function getVendorCsOption(option)
    if option == 0 then
        return 0
    end
    return bit.band(0xFF, option)
end

local function getTadeItemCount(trade)
    local count = 0

    for i=0,7 do
        local item = trade:getItem(i)
        if item then
            count = count +1
        end
    end
    return count
end
-----------------------------------------------------------------------------------------------
-- Global functions
-----------------------------------------------------------------------------------------------
xi.escha.cleanUpKeyItems = function(player)
    local keyItemsToClear =
    {
        xi.keyItem.MOLLIFIER,
        xi.keyItem.RADIALENS,
    }

    for k, v in pairs(keyItemsToClear) do
        if player:hasKeyItem(keyItemsToClear[k]) then
            player:delKeyItem(keyItemsToClear[k])
        end
    end
end

xi.escha.unlockVorseal = function(player, vorseal, value)

end

xi.escha.setDomainInvasionStatus = function(zoneName, dragonID) -- TODO: set this to run in core
    local bitPos = 0
    local var = "["..zoneName.."]ZoneInfo"

    if dragonID == 2 then
        bitPos = 1
    elseif dragonID == 0 then
        SetServerVariable(var, utils.mask.setBit(GetServerVariable(var), 0, false))
        SetServerVariable(var, utils.mask.setBit(GetServerVariable(var), 1, false))
        return
    end

    SetServerVariable(var, utils.mask.setBit(GetServerVariable(var), bitPos, true))
end

xi.escha.setZoneBlessing = function(zoneName, areaBlessing) -- TODO: set this to run in core
    local bitPos = areaBlessing[areaBlessing].bit
    local var = "["..zoneName.."]ZoneInfo"
    SetServerVariable(var, utils.mask.setBit(GetServerVariable(var), bitPos, true))
end

xi.escha.clearZoneBlessings = function(zoneName) -- TODO: set this to run in core
    local var = "["..zoneName.."]ZoneInfo"
    for k, v in pairs(areaBlessing) do
        SetServerVariable(var, utils.mask.setBit(GetServerVariable(var), areaBlessing[k].bit, false))
    end
end

xi.escha.hasBlessingBeenSet = function(zoneName, areaBlessing) -- TODO: set this to run in core
    local bitPos = areaBlessing[areaBlessing].bit
    return utils.mask.getBit(GetServerVariable("["..zoneName.."]ZoneInfo"), bitPos)
end

local TrinketsList =
{
    [xi.zone.ESCHA_ZITAH] =
    {
        [9702] =
        {
            {KI = xi.keyItem.WEPWAWETS_TOOTH,    bit =  0},
            {KI = xi.keyItem.LYDIAS_VINE,        bit =  1},
            {KI = xi.keyItem.AGLAOPHOTIS_BUD,    bit =  2},
            {KI = xi.keyItem.TANGATAS_WING,      bit =  3},
            {KI = xi.keyItem.VIDALAS_CLAW,       bit =  4},
            {KI = xi.keyItem.GESTALTS_RETINA,    bit =  5},
            {KI = xi.keyItem.ANGRBODAS_NECKLACE, bit =  6},
            {KI = xi.keyItem.CUNNASTS_TALON,     bit =  7},
            {KI = xi.keyItem.REVETAURS_HORN,     bit =  8},
            {KI = xi.keyItem.FERRODONS_SCALE,    bit =  9},
            {KI = xi.keyItem.GULLTOPS_SHELL,     bit = 10},
            {KI = xi.keyItem.VYALAS_PREY,        bit = 11},
        },
        [9703] =
        {
            {KI = xi.keyItem.IONOSS_WEBBING,   bit = 1},
            {KI = xi.keyItem.NOSOIS_FEATHER,   bit = 2},
            {KI = xi.keyItem.KAMOHOALIIS_FIN,  bit = 3},
        },
        [9704] =
        {
            {KI = xi.keyItem.BRITTLISS_RING,   bit = 1},
            {KI = xi.keyItem.SANDYS_LASHER,    bit = 2},
            {KI = xi.keyItem.UMDHLEBIS_FLOWER, bit = 3},
        }
    }
}

local TrinketTradeList =
{
    [xi.zone.ESCHA_ZITAH] =
    {
        [1] =
        {
            {item = xi.items.SQUARE_OF_SILK_CLOTH, Amount = 2, CSID = 9702, KI = TrinketsList[xi.zone.ESCHA_ZITAH][9702]},
            {item = xi.items.CARAPACE_GORGET,      Amount = 1, CSID = 9702, KI = TrinketsList[xi.zone.ESCHA_ZITAH][9702]},
            {item = xi.items.BUFFALO_LEATHER,      Amount = 2, CSID = 9702, KI = TrinketsList[xi.zone.ESCHA_ZITAH][9702]},
            {item = xi.items.MAHOGANY_LUMBER,      Amount = 3, CSID = 9702, KI = TrinketsList[xi.zone.ESCHA_ZITAH][9702]},
            {item = xi.items.DARKSTEEL_INGOT,      Amount = 2, CSID = 9702, KI = TrinketsList[xi.zone.ESCHA_ZITAH][9702]},
            {item = xi.items.FISH_MITHKABOB,       Amount = 6, CSID = 9702, KI = TrinketsList[xi.zone.ESCHA_ZITAH][9702]},
            {item = xi.items.FLAME_BLADE,          Amount = 1, CSID = 9702, KI = TrinketsList[xi.zone.ESCHA_ZITAH][9702]},
            {item = xi.items.GOLD_INGOT,           Amount = 2, CSID = 9702, KI = TrinketsList[xi.zone.ESCHA_ZITAH][9702]},
            {item = xi.items.HOLY_SWORD,           Amount = 1, CSID = 9702, KI = TrinketsList[xi.zone.ESCHA_ZITAH][9702]},
            {item = xi.items.AYAPECS_SHELL,        Amount = 5, CSID = 9703, KI = TrinketsList[xi.zone.ESCHA_ZITAH][9703]},
            {item = xi.items.ETHEREAL_INCENSE,     Amount = 5, CSID = 9704, KI = TrinketsList[xi.zone.ESCHA_ZITAH][9704]},
            {item = xi.items.RIFTBORN_BOULDER,     Amount = 5, CSID = 0,    KI = xi.keyItem.FLEETSTALKERS_CLAW         },
            {item = xi.items.BEITETSU,             Amount = 5, CSID = 0,    KI = xi.keyItem.SHOCKMAWS_BLUBBER          },
            {item = xi.items.PLUTON,               Amount = 5, CSID = 0,    KI = xi.keyItem.URMAHLULLUS_ARMOR          },
        },
        [2] =
        {
            {items = {xi.items.ASHWEED,     xi.items.GRAVEWOOD_LOG}, KI = xi.keyItem.COVENS_DUST       },
            {items = {xi.items.DUSKCRAWLER, xi.items.GRAVEWOOD_LOG}, KI = xi.keyItem.BLAZEWINGS_PINCER },
            {items = {xi.items.ASHWEED,     xi.items.DUSKCRAWLER  }, KI = xi.keyItem.PAZUZUS_BLADE_HILT},
        },
        [3] =
        {
            {items = {xi.items.ASHWEED, xi.items.DUSKCRAWLER, xi.items.GRAVEWOOD_LOG}, KI = xi.keyItem.WRATHARES_CARROT},
        }
    }
}

xi.escha.vendorOnTrade = function(player, npc, trade)
    local zoneID      = player:getZoneID()
    local ID     = zones[zoneID]
    local individualItemsTraded = getTadeItemCount(trade)

    print("Items traded: " ..individualItemsTraded)

    switch (individualItemsTraded): caseof
    {
        [1] = function()
            for _, tradedItem in ipairs(TrinketTradeList[zoneID][1]) do
                if npcUtil.tradeHasExactly(trade, { {tradedItem.item, tradedItem.Amount} }) then
                    print("Traded item: " ..tradedItem.item.. " Amount: " ..tradedItem.Amount)
                    if tradedItem.CSID == 9702 then
                        local mask = 0
                        for k, v in pairs(TrinketsList[zoneID][9702]) do
                            if player:hasKeyItem(v.KI) then
                                mask = utils.mask.setBit(mask,v.bit, true)
                            end
                        end
                        print("mask: " ..mask)
                        player:startEvent(9702, zoneID, getPlayerEschaStatus(player), mask, player:getCurrency("escha_silt"), player:getCurrency("escha_beads"), 0, 0, 0)
                    elseif tradedItem.CSID == 9703 or tradedItem.CSID == 9704 then
                        local mask = -16
                        for k, v in pairs(TrinketsList[zoneID][tradedItem.CSID]) do
                            if player:hasKeyItem(v.KI) then
                                mask = utils.mask.setBit(mask,v.bit, true)
                            end
                        end
                        print("mask: " ..mask)
                        player:startEvent(tradedItem.CSID, zoneID, mask, 0, player:getCurrency("escha_silt"), player:getCurrency("escha_beads"), 0, 0, 0)
                    elseif tradedItem.CSID == 0 then
                        if not player:hasKeyItem(tradedItem.KI) then
                            player:messageText(npc, ID.text.KI_POP_TRADE, true)
                            player:tradeComplete()
                            npcUtil.giveKeyItem(player, tradedItem.KI)
                        else
                            print("You have this KI: " ..tradedItem.KI)
                        end
                    end
                end
            end
        end,
        [2] = function()
            for _, tradedItem in ipairs(TrinketTradeList[zoneID][2]) do
                if npcUtil.tradeHasExactly(trade, {tradedItem.items[1], tradedItem.items[2]}) then
                    if not player:hasKeyItem(tradedItem.KI) then
                        player:messageText(npc, ID.text.KI_POP_TRADE, true)
                        player:tradeComplete()
                        npcUtil.giveKeyItem(player, tradedItem.KI)
                    else
                        print("You have this KI: " ..tradedItem.KI)
                    end
                end
            end
        end,
        [3] = function()
            for _, tradedItem in ipairs(TrinketTradeList[zoneID][3]) do
                if npcUtil.tradeHasExactly(trade, {tradedItem.items[1], tradedItem.items[2], tradedItem.items[3]}) then
                    if not player:hasKeyItem(tradedItem.KI) then
                        player:messageText(npc, ID.text.KI_POP_TRADE, true)
                        player:tradeComplete()
                        npcUtil.giveKeyItem(player, tradedItem.KI)
                    else
                        print("You have this KI: " ..tradedItem.KI)
                    end
                end
            end
        end,
    }
end

xi.escha.vendorOnTrigger = function(player, npc)
    local eschaStats = getPlayerEschaStatus(player) -- TODO: This needs to be fixed.
    local beads      = player:getCurrency("escha_beads")
    local silt       = player:getCurrency("escha_silt")
    local vorsealA   = player:getCharVar("vorseal_a") -- TODO: Convert to sql.
    local vorsealB   = player:getCharVar("vorseal_b") -- TODO: Convert to sql.
    local vorsealC   = player:getCharVar("vorseal_c") -- TODO: Convert to sql.
    local cs         = 9700 -- tutorial not done

    if getTutorialStatus(player) >= 7 then
        cs = 9701 -- tutorial done
    end

    player:startEvent(cs,beads,   silt,   eschaStats, 0, vorsealA,   vorsealB,   vorsealC, 0)
    --print("eschaPlayerStats: " ..tonumber(eschaStats))
end

xi.escha.vendorOnUpdate = function(player, csid, option)
    --print("Escha onEventUpdate option: " ..getVendorCsOption(option))
    --------------------------------------------------
    -- TEMP STUFF (Get rid of this once it works!.)
    --------------------------------------------------
    local vorsealsA = 4294967295 --DONE!
    local vorsealsB = 4294967295 --DONE!
    local vorsealsC = 4294967295 --DONE!
    local vorsealsD = 4294967295 --DONE!
    local vorsealsE = 4294967295 --DONE!
    local vorsealsF = 4294967168 --DONE!
    --------------------------------------------------

    local zoneID = player:getZoneID()

    if csid == 9700 or csid == 9701 then
        switch (getVendorCsOption(option)): caseof
        {
            [2] = function() -- Currency Update.
                if csid == 9700 then -- Pay Silt to unlock options only on this CSID.
                    if player:getCurrency("escha_silt") >= 10 and getTutorialStatus(player) < 7 then
                        player:delCurrency("escha_silt", 10)
                        setTutorialDone(player)
                    end
                end
                player:updateEvent(player:getCurrency("escha_beads"), player:getCurrency("escha_silt"), getPlayerEschaStatus(player), 0, 0, 0, 0, 0)
            end,
            [3] = function() -- KI Available Update.
                player:updateEvent(player:getCurrency("escha_beads"), player:getCurrency("escha_silt"), getPlayerEschaStatus(player), 0, 0, 0, 0, 0)
            end,
            [4] = function() -- KI Purchase.
                local kiOption = bit.band(bit.rshift(option, 8), 0xF)
                local ki       = nil
                local cost     = 0

                for k,v in pairs(KIList) do
                    if v.offset == kiOption then
                        ki = KIList[k].ki
                        cost = v.cost
                    end
                end

                if ki ~= nil and player:getCurrency("escha_silt") >= cost then
                    if player:addKeyItem(ki) then
                        player:delCurrency("escha_silt", cost)
                    end
                end

                player:updateEvent(player:getCurrency("escha_beads"), player:getCurrency("escha_silt"), getPlayerEschaStatus(player), 0, 0, 0, 0, 0)
            end,
            [5] = function() -- VORSEAL Upgrade.
                upgradeVorseal(player, option)
            end,
            [6] = function() -- VORSEAL Return.
                returnVorseal(player, option)
            end,
            [8] = function() -- Available Vorseals update.
                -- TODO: create a system to unlock vorseals
                -- player:updateEvent(zoneID, vorsealsA, vorsealsB, vorsealsC, vorsealsD, vorsealsE, vorsealsF, getAvailableTrinkets(player))
                player:updateEvent(zoneID, vorsealsA, vorsealsB, vorsealsC, vorsealsD, vorsealsE, vorsealsF, getAvailableTrinkets(player))
            end,
            [9] = function() -- Zone Info Update.
                --print("Updating Area Info.")
                local vorsealA = player:getCharVar("vorseal_a") -- TODO: Convert to sql.
                local vorsealB = player:getCharVar("vorseal_b") -- TODO: Convert to sql.
                local vorsealC = player:getCharVar("vorseal_c") -- TODO: Convert to sql.
                -- Param 2
                -- 4321514 010000011111000011101010
                player:updateEvent(getZoneInfo(player), 4373498, getPlayerEschaStatus(player), 0, vorsealA, vorsealB, vorsealC, 0)
            end,
            [10] = function() -- Elvorseal Option Update.
                local text  = zones[player:getZoneID()].text
                local mask  = getZoneInfo(player) or 0
                local level = 119
                local unk_1 = 0 -- TODO: not sure what this does yet, values seem to have no change. (seen 200 and 3522)
                local unk_2 = 0 -- TODO: not sure what this does yet, values seem to have no change. (seen 0 and -125881872)
                local unk_3 = 0 -- TODO: not sure what this does yet, values seem to have no change. (seen 21049380 and 67010497)
                local unk_4 = 0 -- TODO: not sure what this does yet, values seem to have no change. (seen 972415233 and 1073741696)

                if utils.mask.getBit(mask, 1) then
                    level = 150
                end

                if player:getCharVar("[ESCHA]FirstTimeDomainInvasion") < 1 then
                    player:setCharVar("[ESCHA]FirstTimeDomainInvasion", 1)
                end

                if player:hasStatusEffect(xi.effect.ELVORSEAL) then
                    player:delStatusEffect(xi.effect.ELVORSEAL)
                    player:updateEvent(mask, unk_1, getPlayerEschaStatus(player), unk_2, unk_3, unk_4, 0, 0)
                    return
                else
                    player:addStatusEffectEx(xi.effect.ELVORSEAL, xi.effect.ELVORSEAL, 0, 0, 0)
                    player:messageSpecial(text.LEVEL_OF_DIFFICULTY_IS, level)
                end

                player:updateEvent(mask + 8, unk_1, getPlayerEschaStatus(player), unk_2, unk_3, unk_4, player:getCharVar("[ESCHA]FirstTimeDomainInvasion"), 0)

                if player:getCharVar("[ESCHA]FirstTimeDomainInvasion") == 1 then
                    player:setCharVar("[ESCHA]FirstTimeDomainInvasion", 2) -- progress past 1st time in a Domain Invasion.
                end
            end,
            [11] = function() -- Elvorseal Ready Selection.
                -- TODO: fix magic numbers.
                local diVar = player:getCharVar("[ESCHA]FirstTimeDomainInvasion")
                player:updateEvent(getZoneInfo(player), 3522, getPlayerEschaStatus(player), 0, 21049380, 872415233, diVar, 0)
            end,
            [12] = function() -- Elvorseal Warp Update.
                -- TODO: fix magic numbers.
                local diVar = player:getCharVar("[ESCHA]FirstTimeDomainInvasion")
                player:addStatusEffect(xi.effect.MOBILIZATION, 0, 3, 30)
                player:updateEvent(getZoneInfo(player), 3522, getPlayerEschaStatus(player), 0, 21049380, 872415233, diVar, 0)
            end,
            [14] = function() -- Temp Purchase.
                player:updateEvent(utils.MAX_UINT32, 31999, 0, 0, 0, 0, 0, 0) -- TODO: This is a mess, needs fixing.
            end,
        }
    end
end

------------------------------------------------------------------------
-- vendor onEventFinish.
------------------------------------------------------------------------
xi.escha.vendorOnEventFinish = function(player, csid, option, npc)
    local zoneID = player:getZoneID()

    if csid >= 9702 and csid <= 9704 then -- Trade cs
        local trinketOption = nil
        local keyitem = 0

        trinketOption = bit.band(bit.rshift(option, 8), 0xF)

        if trinketOption == nil then
            return 0
        end

        keyitem = TrinketsList[zoneID][csid][trinketOption].KI

        if keyitem ~= 0 then
            player:tradeComplete()
            npcUtil.giveKeyItem(player,keyitem)
        end

        print("\nTrade finished, option = " ..trinketOption)
    end

    print("onEventFinish CSID: " ..tostring(csid))
    print("onEventFinish option: " ..tostring(option))
end
