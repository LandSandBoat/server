-----------------------------------
-- Mog House related functions
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
-----------------------------------
xi = xi or {}
xi.moghouse = xi.moghouse or {}

-----------------------------------
-- Mog Locker constants
-----------------------------------
local mogLockerStartTimestamp   = 1009810800 -- unix timestamp for 2001/12/31 15:00
local mogLockerTimestampVarName = 'mog-locker-expiry-timestamp'

xi.moghouse.MOGLOCKER_ALZAHBI_VALID_DAYS    = 7
xi.moghouse.MOGLOCKER_ALLAREAS_VALID_DAYS   = 5
xi.moghouse.MOGLOCKER_PLAYERVAR_ACCESS_TYPE = 'mog-locker-access-type'

xi.moghouse.lockerAccessType =
{
    ALZAHBI  = 0,
    ALLAREAS = 1,
}

xi.moghouse.moghouseZones =
{
    xi.zone.AL_ZAHBI,             -- 49
    xi.zone.AHT_URHGAN_WHITEGATE, -- 50
    xi.zone.SOUTHERN_SAN_DORIA_S, -- 80
    xi.zone.BASTOK_MARKETS_S,     -- 87
    xi.zone.WINDURST_WATERS_S,    -- 94
    xi.zone.RESIDENTIAL_AREA,     -- 219
    xi.zone.SOUTHERN_SAN_DORIA,   -- 230
    xi.zone.NORTHERN_SAN_DORIA,   -- 231
    xi.zone.PORT_SAN_DORIA,       -- 232
    xi.zone.BASTOK_MINES,         -- 234
    xi.zone.BASTOK_MARKETS,       -- 235
    xi.zone.PORT_BASTOK,          -- 236
    xi.zone.WINDURST_WATERS,      -- 238
    xi.zone.WINDURST_WALLS,       -- 239
    xi.zone.PORT_WINDURST,        -- 240
    xi.zone.WINDURST_WOODS,       -- 241
    xi.zone.RULUDE_GARDENS,       -- 243
    xi.zone.UPPER_JEUNO,          -- 244
    xi.zone.LOWER_JEUNO,          -- 245
    xi.zone.PORT_JEUNO,           -- 246
    xi.zone.WESTERN_ADOULIN,      -- 256
    xi.zone.EASTERN_ADOULIN,      -- 257
}

xi.moghouse.moghouse2FUnlockCSs =
{
    [xi.zone.SOUTHERN_SAN_DORIA] = 3535,
    [xi.zone.NORTHERN_SAN_DORIA] = 904,
    [xi.zone.PORT_SAN_DORIA]     = 820,
    [xi.zone.BASTOK_MINES]       = 610,
    [xi.zone.BASTOK_MARKETS]     = 604,
    [xi.zone.PORT_BASTOK]        = 456,
    [xi.zone.WINDURST_WATERS]    = 1086,
    [xi.zone.WINDURST_WALLS]     = 547,
    [xi.zone.PORT_WINDURST]      = 903,
    [xi.zone.WINDURST_WOODS]     = 885,
}

local offsetAxis =
{
    X = 1,
    Z = 3,
    R = 4,
}

--  [zoneId]                       = { [Entrance] ={x,      y,     z,   rot, offsetAxis,   max } }
xi.moghouse.exits =
{
    -- Single Exit Zones -------------------------------------------------------------------------
    [xi.zone.BASTOK_MINES]         = { [1] = {    117,   0.99,    -72,  127, offsetAxis.Z, 5.0 } },
    [xi.zone.PORT_BASTOK]          = { [1] = {     60,    8.5,   -239,  192, offsetAxis.X, 5.0 } },
    [xi.zone.AL_ZAHBI]             = { [1] = {     40,      0,    -61,  191, offsetAxis.X, 2.0 } },
    [xi.zone.AHT_URHGAN_WHITEGATE] = { [1] = {   -101,      0,    -80,  255, offsetAxis.Z, 2.0 } },
    [xi.zone.SOUTHERN_SAN_DORIA_S] = { [1] = {  148.5,     -2,    116,   95, offsetAxis.X, 2.0 } },
    [xi.zone.WINDURST_WATERS_S]    = { [1] = {    160,   0.99,    -11,  191, offsetAxis.X, 2.0 } },
    [xi.zone.SOUTHERN_SAN_DORIA]   = { [1] = {  159.5,     -2,    160,   95, offsetAxis.Z, 2.0 } },
    [xi.zone.NORTHERN_SAN_DORIA]   = { [1] = {    130,   -0.2,     -3,  160, offsetAxis.X, 2.0 } },
    [xi.zone.PORT_SAN_DORIA]       = { [1] = {   79.4,    -16, -135.5,  165, offsetAxis.R, 1.8 } },
    [xi.zone.WINDURST_WATERS]      = { [1] = {    160,  -2.65,  -53.7,  192, offsetAxis.X, 2.5 } },
    [xi.zone.WINDURST_WALLS]       = { [1] = {   -249,  -2.65,   -120,    0, offsetAxis.Z, 2.5 } },
    [xi.zone.PORT_WINDURST]        = { [1] = {    198, -15.65,    258,   65, offsetAxis.X, 2.5 } },
    [xi.zone.WINDURST_WOODS]       = { [1] = {   -130,  -7.65,     40,    0, offsetAxis.Z, 2.5 } },
    [xi.zone.RULUDE_GARDENS]       = { [1] = {   46.5,     10,    -73,  192, offsetAxis.X, 1.8 } },
    [xi.zone.UPPER_JEUNO]          = { [1] = {     47,     -5,  -79.3,  172, offsetAxis.R, 1.0 } },
    [xi.zone.LOWER_JEUNO]          = { [1] = {     42,     -5,     85,   85, offsetAxis.R, 1.0 } },
    [xi.zone.PORT_JEUNO]           = { [1] = {   -193,     -5,     -0,    0, offsetAxis.Z, 1.0 } },
    [xi.zone.WESTERN_ADOULIN]      = { [1] = {      0,   0.75,   -142,  223, offsetAxis.R, 4.0 } },
    [xi.zone.EASTERN_ADOULIN]      = { [1] = {    -56,  -0.15,   -127,  191, offsetAxis.X, 4.0 } },

    --- Multiple Exit Zones ----------------------------------------------------------------------
    [xi.zone.BASTOK_MARKETS_S]     = {
        [1] = { -177,  -8,  -30, 128, offsetAxis.Z, 2.0 },
        [2] = { -177,  -8,   30, 128, offsetAxis.Z, 2.0 }
    },

    [xi.zone.BASTOK_MARKETS]       = {
        [1] = { -177,  -8,  -30, 128, offsetAxis.Z, 2.0 },
        [2] = { -177,  -8,   30, 128, offsetAxis.Z, 2.0 }
    },
}

local moghouseZoneLines =
{
--  [Zoneline ID] = entrance no.
    [ 812805498] = 1, -- (230) SOUTHERN_SANDORIA
    [ 812871034] = 1, -- ( 80) SOUTHERN_SANDORIA_S
    [ 846359930] = 1, -- (231) NORTHERN_SANDORIA
    [ 879979898] = 1, -- ( 87) BASTOK_MARKETS_S [Entrance 1]
    [ 846425466] = 2, -- ( 87) BASTOK_MARKETS_S [Entrance 2]
    [ 879914362] = 1, -- (232) PORT_SANDORIA
    [ 913468794] = 1, -- (238) WINDURST_WATERS
    [ 913534330] = 1, -- ( 94) WINDURST_WATERS_S
    [ 947023226] = 1, -- (238) WINDURST_WALLS
    [1668443514] = 1, -- (235) BASTOK_MARKETS [Entrance 1]
    [1634889082] = 2, -- (235) BASTOK_MARKETS [Entrance 2]
    [1701997946] = 1, -- (240) PORT_WINDURST
    [1735552378] = 1, -- (234) BASTOK_MINES
    [1769106810] = 1, -- (236) PORT_BASTOK
    [1802661242] = 1, -- (241) WINDURST_WOODS
    [1836215674] = 1, -- (243) RULUDE_GARDENS
    [1869770106] = 1, -- (244) UPPER_JEUNO
    [1936878970] = 1, -- (246) PORT_JEUNO
    [1970433402] = 1, -- (245) LOWER_JEUNO
    [2003987834] = 1, -- ( 48) AL_ZAHBI
    [2037542266] = 1, -- ( 50) AHT_URHGAN_WHITEGATE
    [ 947088762] = 1, -- (256) WESTERN_ADOULIN
    [1634954618] = 1, -- (257) EASTERN_ADOULIN
}

xi.moghouse.isInMogHouseInHomeNation = function(player)
    if not player:isInMogHouse() then
        return false
    end

    local currentZone = player:getZoneID()
    local nation      = player:getNation()

    -- TODO: Simplify nested conditions
    if nation == xi.nation.BASTOK then
        if
            currentZone >= xi.zone.BASTOK_MINES and
            currentZone <= xi.zone.PORT_BASTOK
        then
            return true
        end
    elseif nation == xi.nation.SANDORIA then
        if
            currentZone >= xi.zone.SOUTHERN_SAN_DORIA and
            currentZone <= xi.zone.PORT_SAN_DORIA
        then
            return true
        end
    else
        if
            currentZone >= xi.zone.WINDURST_WATERS and
            currentZone <= xi.zone.WINDURST_WOODS
        then
            return true
        end
    end

    return false
end

xi.moghouse.set2ndFloorStyle = function(player, style)
    -- 0x0080: This bit and the next track which 2F decoration style is being used (0: SANDORIA, 1: BASTOK, 2: WINDURST, 3: PATIO)
    -- 0x0100: ^ As above
    local mhflag = player:getMoghouseFlag()
    utils.mask.setBit(mhflag, 0x0080, utils.mask.getBit(style, 0))
    utils.mask.setBit(mhflag, 0x0100, utils.mask.getBit(style, 1))
    player:setMoghouseFlag(mhflag)
end

xi.moghouse.getAvailableMusic = function(player)
    -- See documentation/songdata.txt or documentation/MusicIDs.txt for song data.
    local possibleSongs = {}

    local orchestrion  = player:findItem(xi.item.ORCHESTRION)
    local spinet       = player:findItem(xi.item.SPINET)
    local nanaaStatue1 = player:findItem(xi.item.NANAA_MIHGO_STATUE)
    local nanaaStatue2 = player:findItem(xi.item.NANAA_MIHGO_STATUE_II)

    local hasOrchestrion  = orchestrion and orchestrion:isInstalled()
    local hasSpinet       = spinet and spinet:isInstalled()
    local hasNanaaStatue1 = nanaaStatue1 and nanaaStatue1:isInstalled()
    local hasNanaaStatue2 = nanaaStatue2 and nanaaStatue2:isInstalled()

    -- NOTE: Since Spinet, Nanaa Mihgo Statue I, and Nanaa Mihgo Statue II are promotional-only items,
    --     : it is extremely difficult to get them and test what they do when used together.
    --     : We're completely guessing how they interact with each other.
    --     : TODO: Do these overwrite eachother in some way, or do they work together (as we've implemented
    --     : them here)?
    if not hasOrchestrion then
        -- https://www.bg-wiki.com/ffxi/Orchestrion
        if hasSpinet then
            table.insert(possibleSongs, 112) -- Selbina
            table.insert(possibleSongs, 196) -- Fighters of the Crystal
            table.insert(possibleSongs, 230) -- A New Horizon
            table.insert(possibleSongs, 187) -- Ragnarok
            table.insert(possibleSongs, 215) -- Clash of Standards
            table.insert(possibleSongs, 47)  -- Echoes of Creation
            table.insert(possibleSongs, 49)  -- Luck of the Mog
            table.insert(possibleSongs, 50)  -- Feast of the Ladies
            table.insert(possibleSongs, 51)  -- Abyssea
            table.insert(possibleSongs, 52)  -- Melodies Errant
            table.insert(possibleSongs, 109) -- Ronfaure
            table.insert(possibleSongs, 251) -- Autumn Footfalls
            table.insert(possibleSongs, 48)  -- Main Theme
            table.insert(possibleSongs, 126) -- Mog House
        end

        if hasNanaaStatue1 then
            table.insert(possibleSongs, 69) -- Distant Worlds (Nanaa Mihgo's Version)
        end

        if hasNanaaStatue2 then
            table.insert(possibleSongs, 59) -- The Pioneers (Nanaa Mihgo's Version)
        end
    end

    return possibleSongs
end

xi.moghouse.trySetMusic = function(player)
    local possibleSongs = xi.moghouse.getAvailableMusic(player)

    if #possibleSongs > 0 then
        -- This needs a moment before music changes can take effect
        player:timer(1000, function(playerArg)
            playerArg:changeMusic(6, utils.randomEntry(possibleSongs))
        end)
    end
end

xi.moghouse.onMoghouseZoneEvent = function(player, prevZone)
    -- Handle players zoning in their Mog House
    if player:isInMogHouse() then
        return xi.moghouse.onMoghouseZoneIn(player, prevZone)
    end

    -- Handle players zoning out of their Mog House
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then

        local zoneId = player:getZoneID()
        local prevZoneLineID = player:getPreviousZoneLineID()
        local moghouseEntrance = moghouseZoneLines[prevZoneLineID] or 1
        local x, y, z, r, randomizedAxis, randomMax = unpack(xi.moghouse.exits[zoneId][moghouseEntrance])
        local randomOffset                          = math.random(-randomMax * 1000, randomMax * 1000) -- offset -/+ from center point
        local offsetValue                           = randomOffset / 1000 -- 0.000 - N.N00 variance

        -- A few moghouses are rotated so we handle them first.
        if randomizedAxis == offsetAxis.R then
            local lineRot = (r + 64) % 256 -- Calculate the perpendicular angle (90 degrees / 64 units offset) from the rotaion of r.
            local lineRadians = lineRot * (math.pi * 2 / 256) -- Convert to radians.
            x = x + (offsetValue * math.cos(lineRadians))
            z = z - (offsetValue * math.sin(lineRadians))
        elseif randomizedAxis == offsetAxis.X then
            x = x + offsetValue
        elseif randomizedAxis == offsetAxis.Z then
            z = z + offsetValue
        end

        player:setPos(x, y, z, r)
    end

    return -1
end

xi.moghouse.onMoghouseZoneIn = function(player, prevZone)
    local cs = -1

    player:eraseAllStatusEffect()
    player:delStatusEffectSilent(xi.effect.POISON)
    player:delStatusEffectSilent(xi.effect.BLINDNESS)
    player:delStatusEffectSilent(xi.effect.PARALYSIS)
    player:delStatusEffectSilent(xi.effect.SILENCE)

    player:setPos(0, 0, 0, 192)

    -- Moghouse data (bit-packed)
    -- 0x0001: SANDORIA exit quest flag
    -- 0x0002: BASTOK exit quest flag
    -- 0x0004: WINDURST exit quest flag
    -- 0x0008: JEUNO exit quest flag
    -- 0x0010: WEST_AHT_URHGAN exit quest flag
    -- 0x0020: Unlocked Moghouse2F flag
    -- 0x0040: Moghouse 2F tracker flag (0: default, 1: using 2F)
    -- 0x0080: This bit and the next track which 2F decoration style is being used (0: SANDORIA, 1: BASTOK, 2: WINDURST, 3: PATIO)
    -- 0x0100: ^ As above
    local mhflag = player:getMoghouseFlag()

    local growingFlowers   = bit.band(mhflag, 0x0001) > 0
    local aLadysHeart      = bit.band(mhflag, 0x0002) > 0
    local flowerChild      = bit.band(mhflag, 0x0004) > 0
    local unlocked2ndFloor = bit.band(mhflag, 0x0020) > 0
    local using2ndFloor    = bit.band(mhflag, 0x0040) > 0

    -- NOTE: You can test these quest conditions with:
    -- Reset: !exec player:setMoghouseFlag(0)
    -- Complete quests: !exec player:setMoghouseFlag(7)
    if
        xi.moghouse.isInMogHouseInHomeNation(player) and
        growingFlowers and
        aLadysHeart and
        flowerChild and
        not unlocked2ndFloor and
        not using2ndFloor
    then
        cs = xi.moghouse.moghouse2FUnlockCSs[player:getZoneID()]

        player:setMoghouseFlag(mhflag + 0x0020) -- Set unlock flag now, rather than in onEventFinish

        local nation = player:getNation()
        xi.moghouse.set2ndFloorStyle(player, nation)
    end

    xi.moghouse.trySetMusic(player)

    return cs
end

xi.moghouse.moogleTrade = function(player, npc, trade)
    if player:isInMogHouse() then
        local numBronze = trade:getItemQty(xi.item.IMPERIAL_BRONZE_PIECE)

        if numBronze > 0 then
            if xi.moghouse.addMogLockerExpiryTime(player, numBronze) then
                player:tradeComplete()
                player:messageSpecial(zones[player:getZoneID()].text.MOG_LOCKER_OFFSET + 2, xi.moghouse.getMogLockerExpiryTimestamp(player))
            end
        end

        local eggComponents =
        {
            xi.item.EGG_LOCKER,
            xi.item.EGG_TABLE,
            xi.item.EGG_STOOL,
            xi.item.EGG_LANTERN,
        }

        if npcUtil.tradeHasExactly(trade, eggComponents) then
            if npcUtil.giveItem(player, xi.item.EGG_BUFFET) then
                player:confirmTrade()
            end

        elseif npcUtil.tradeHasExactly(trade, xi.item.EGG_BUFFET) then
            if npcUtil.giveItem(player, eggComponents) then
                player:confirmTrade()
            end
        end
    end
end

xi.moghouse.moogleTrigger = function(player, npc)
    if player:isInMogHouse() then
        local lockerTs = xi.moghouse.getMogLockerExpiryTimestamp(player)

        if lockerTs ~= nil then
            if lockerTs == -1 then -- Expired
                player:messageSpecial(zones[player:getZoneID()].text.MOG_LOCKER_OFFSET + 1, xi.item.IMPERIAL_BRONZE_PIECE)
            else
                player:messageSpecial(zones[player:getZoneID()].text.MOG_LOCKER_OFFSET, lockerTs)
            end
        end

        player:sendMenu(xi.menuType.MOOGLE)
    end
end

xi.moghouse.moogleEventUpdate = function(player, csid, option, npc)
end

xi.moghouse.moogleEventFinish = function(player, csid, option, npc)
end

-- Unlocks a mog locker for a player. Returns the 'expired' timestamp (-1)
xi.moghouse.unlockMogLocker = function(player)
    player:setCharVar(mogLockerTimestampVarName, -1)

    -- Safety check in case some servers auto-set 80 slots for mog locker items.
    if player:getContainerSize(xi.inv.MOGLOCKER) == 0 then
        player:changeContainerSize(xi.inv.MOGLOCKER, 30)
    end

    return -1
end

-- Sets the mog locker access type (all area or alzahbi only). Returns the new access type.
xi.moghouse.setMogLockerAccessType = function(player, accessType)
    player:setCharVar(xi.moghouse.MOGLOCKER_PLAYERVAR_ACCESS_TYPE, accessType)

    return accessType
end

-- Gets the mog locker access type (all area or alzahbi only). Returns the new access type.
xi.moghouse.getMogLockerAccessType = function(player)
    return player:getCharVar(xi.moghouse.MOGLOCKER_PLAYERVAR_ACCESS_TYPE)
end

-- Gets the expiry time for your locker. A return value of -1 is expired. A return value of nil means mog locker hasn't been unlocked.
xi.moghouse.getMogLockerExpiryTimestamp = function(player)
    local expiryTime = player:getCharVar(mogLockerTimestampVarName)

    if expiryTime == 0 then
        return nil
    end

    local now = GetSystemTime() - mogLockerStartTimestamp

    if now > expiryTime then
        player:setCharVar(mogLockerTimestampVarName, -1)

        return -1
    end

    return expiryTime
end

-- Adds time to your mog locker, given the number of bronze coins.
-- The amount of time per bronze is affected by the access type
-- The expiry time itself is the number of seconds past 2001/12/31 15:00
-- Returns true if time was added successfully, false otherwise.
xi.moghouse.addMogLockerExpiryTime = function(player, numBronze)
    local accessType       = xi.moghouse.getMogLockerAccessType(player)
    local numDaysPerBronze = 5

    if accessType == xi.moghouse.lockerAccessType.ALZAHBI then
        numDaysPerBronze = 7
    end

    local currentTs = xi.moghouse.getMogLockerExpiryTimestamp(player)

    if currentTs == nil then
        return false
    end

    if currentTs == -1 then
        currentTs = GetSystemTime() - mogLockerStartTimestamp
    end

    local timeIncrease = 60 * 60 * 24 * numDaysPerBronze * numBronze
    local newTs        = currentTs + timeIncrease

    player:setCharVar(mogLockerTimestampVarName, newTs)

    -- Send an invent size packet to enable the items if they weren't.
    player:changeContainerSize(xi.inv.MOGLOCKER, 0)

    return true
end
