-----------------------------------
-- Chocobo Riding Game
-- Deliver chocobo to requested city for a reward
-- https://ffxiclopedia.fandom.com/wiki/A_Chocobo_Riding_Game
-----------------------------------
require('scripts/globals/packet')
require('scripts/globals/utils')
-----------------------------------
local bastokID   = zones[xi.zone.BASTOK_MINES]
local sandoriaID = zones[xi.zone.SOUTHERN_SAN_DORIA]
local windurstID = zones[xi.zone.WINDURST_WOODS]
local kazhamID   = zones[xi.zone.KAZHAM]
-----------------------------------
xi = xi or {}
xi.chocoboGame = xi.chocoboGame or {}

local raceData =
{
    [xi.zone.WINDURST_WOODS] =
    {
        [xi.zone.SAUROMUGUE_CHAMPAIGN] = { gameDay = 0, reward = xi.item.WINDURST_WOODS_GLYPH, raceTimes = 930,            npc = windurstID.npc.ORLAINE, eventParam = 3, finishEvent = 901 },
        [xi.zone.WEST_RONFAURE]        = { gameDay = 1, reward = xi.item.MIRATETES_MEMOIRS,    raceTimes = { 1717, 1800 }, npc = windurstID.npc.SARIALE, eventParam = 0, finishEvent = 55  },
        [xi.zone.SOUTH_GUSTABERG]      = { gameDay = 2, reward = xi.item.MIRATETES_MEMOIRS,    raceTimes = { 1950, 2084 }, npc = windurstID.npc.AMIMI,   eventParam = 1, finishEvent = 907 },
    },
    [xi.zone.BASTOK_MINES] =
    {
        [xi.zone.EAST_SARUTABARUTA] = { gameDay = 0, reward = xi.item.MIRATETES_MEMOIRS,  raceTimes = { 1950, 2040 }, npc = bastokID.npc.AZETTE,  eventParam = 2, finishEvent = 901 },
        [xi.zone.ROLANBERRY_FIELDS] = { gameDay = 1, reward = xi.item.BASTOK_MINES_GLYPH, raceTimes = 1130,           npc = bastokID.npc.EULAPHE, eventParam = 3, finishEvent = 901 },
        [xi.zone.WEST_RONFAURE]     = { gameDay = 2, reward = xi.item.DRAGON_CHRONICLES,  raceTimes = { 1214, 1260 }, npc = bastokID.npc.QUELLE,  eventParam = 0, finishEvent = 55  },
    },
    [xi.zone.SOUTHERN_SAN_DORIA] =
    {
        [xi.zone.SOUTH_GUSTABERG]   = { gameDay = 0, reward = xi.item.DRAGON_CHRONICLES,   raceTimes = { 1200, 1248 }, npc = sandoriaID.npc.CAMEREINE, eventParam = 1, finishEvent = 907 },
        [xi.zone.EAST_SARUTABARUTA] = { gameDay = 1, reward = xi.item.MIRATETES_MEMOIRS,   raceTimes = { 1699, 1800 }, npc = sandoriaID.npc.EMOUSSINE, eventParam = 2, finishEvent = 901 },
        [xi.zone.BATALLIA_DOWNS]    = { gameDay = 2, reward = xi.item.EAST_SANDORIA_GLYPH, raceTimes = 795,            npc = sandoriaID.npc.MEUNEILLE, eventParam = 3, finishEvent = 906 },
    },
    [xi.zone.KAZHAM] =
    {
        [xi.zone.YUHTUNGA_JUNGLE] = { gameDay = 0, reward = xi.item.MIRATETES_MEMOIRS, raceTimes = { 150, 240 }, npc = kazhamID.npc.TIELLEQUE, eventParam = 3, finishEvent = 208 },
    },
}

-- Rewards that all races give
local defaultRewards =
{
    xi.item.CHOCOBO_TICKET,
    xi.item.BUNCH_OF_GYSAHL_GREENS
}

-- Checks if the NPC can start a race and the player hasn't already participated this week
xi.chocoboGame.raceCheck = function(player, npc)
    local zoneId = player:getZoneID()

    -- Early false return if zone isn't a racing zone
    if not raceData[zoneId] then
        return false
    end

    -- Calculate time race is available
    -- Should match https://www.mithrapride.org/vana_time/chocoracetable.html
    local gameDay = math.floor(VanadielTime() / 3456) -- Get current number of Vana'diel days
    local adjustedGameDay = gameDay % 3

    -- Check if npc offers the currently available race
    for destCity, data in pairs(raceData[zoneId]) do
        if
            data.gameDay == adjustedGameDay and
            npc:getID() == data.npc and
            player:getCharVar('[ChocoGame]NextEntryTime') == 0
        then
            return destCity
        end
    end

    return false
end

-- Get the event param to tell the player which city race they are offering
xi.chocoboGame.startRaceEvent = function(player, destination, eventSucceed)
    local zoneId     = player:getZone():getID()
    local eventParam = raceData[zoneId][destination].eventParam

    -- Temp destination var until player confirms race
    player:setLocalVar('[ChocoGame]DestCity', destination)
    player:startEvent(eventSucceed, -3, 0, 0, eventParam)
end

-- Apply race vars, check for csid and option is done in chocobo.lua
xi.chocoboGame.beginRace = function(player, option)
    if option == 0 then
        local zoneId     = player:getZone():getID()
        local destCity   = player:getLocalVar('[ChocoGame]DestCity')

        player:setCharVar('[ChocoGame]StartingCity', zoneId)
        player:setCharVar('[ChocoGame]DestCity', destCity)
        player:setCharVar('[ChocoGame]NextEntryTime', 1, NextConquestTally())
        player:setCharVar('[ChocoGame]StartTime', os.time())
    else -- Player declined race, clearing var
        player:setLocalVar('[ChocoGame]DestCity', 0)
    end
end

-- Determine which tier of award the player gets based off their time
xi.chocoboGame.rewardCheck = function(startingCity, destCity, clearTime)
    local raceTimes = raceData[startingCity][destCity].raceTimes
    local reward    = 0
    local jeuno     =
    {
        xi.zone.ROLANBERRY_FIELDS,
        xi.zone.SAUROMUGUE_CHAMPAIGN,
        xi.zone.BATALLIA_DOWNS
    }

    -- Jeuno paths only have two rewards
    if utils.contains(destCity, jeuno) then
        if clearTime < raceTimes[1] then -- Gold
            reward = raceData[startingCity][destCity].reward
        else -- Bronze
            reward = defaultRewards[2]
        end
    else
        if clearTime < raceTimes[1] then -- Gold
            reward = raceData[startingCity][destCity].reward
        elseif clearTime >= raceTimes[1] and clearTime <= raceTimes[2] then -- Silver
            reward = defaultRewards[1]
        else -- Bronze
            reward = defaultRewards[2]
        end
    end

    return reward
end

-- Player reached finish line, handle event messaging
xi.chocoboGame.onTriggerAreaEnter = function(player)
    local destCity = player:getCharVar('[ChocoGame]DestCity')

    if player:getZoneID() == destCity then
        local clearTime = os.time() - player:getCharVar('[ChocoGame]StartTime')
        local startingCity = player:getCharVar('[ChocoGame]StartingCity')
        local recordId = GetServerVariable('[ChocoGame][RecordHolder]'..startingCity..'+'..destCity)
        local recordTime = GetServerVariable('[ChocoGame][RecordTime]'..startingCity..'+'..destCity)

        -- Parse record name
        local recordName = ''
        if recordId ~= 0 then
            recordName = GetPlayerByID(recordId):getName()
        end

        -- Race complete event if a record for this path exists
        if recordName then
            player:startEvent(raceData[startingCity][destCity].finishEvent, clearTime, 0, recordTime)
            player:updateEventString(recordName)
        -- Race complete event with no record for this path
        else
            player:startEvent(raceData[startingCity][destCity].finishEvent, clearTime)
        end

        -- Update record if faster
        if clearTime < recordTime or recordTime == 0 then
            SetServerVariable('[ChocoGame][RecordHolder]'..startingCity..'+'..destCity, player:getID())
            SetServerVariable('[ChocoGame][RecordTime]'..startingCity..'+'..destCity, clearTime)
        end
    end
end

-- Remove chocobo and give player reward
xi.chocoboGame.onEventFinish = function(player, csid)
    local clearTime = os.time() - player:getCharVar('[ChocoGame]StartTime')
    local startingCity = player:getCharVar('[ChocoGame]StartingCity')
    local destCity = player:getCharVar('[ChocoGame]DestCity')

    if
        startingCity ~= 0 and
        destCity ~= 0 and
        csid == raceData[startingCity][destCity].finishEvent
    then
        npcUtil.giveItem(player, xi.chocoboGame.rewardCheck(startingCity, destCity, clearTime))
        player:delStatusEffectSilent(xi.effect.MOUNTED)
    end
end

-- Effect is called when mounted effect is lost through scripts\effects\mounted.lua
xi.chocoboGame.dismountChoco = function(player)
    if player:getCharVar('[ChocoGame]StartTime') then
        player:setCharVar('[ChocoGame]StartTime', 0)
        player:setCharVar('[ChocoGame]StartingCity', 0)
        player:setCharVar('[ChocoGame]DestCity', 0)
    end
end

xi.chocoboGame.handleMessage = function(player)
    local startTime = player:getCharVar('[ChocoGame]StartTime')
    local raceTime  = os.time() - startTime
    local ID        = zones[player:getZoneID()]

    -- Check if player is in race and hasn't just started
    if startTime ~= 0 and raceTime > 30 then
        local vanaHour  = math.floor(raceTime / 144) -- One Vana'diel hour is 144 earth seconds
        local earthMin  = math.floor(raceTime / 60)
        local earthSec  = raceTime % 60

        player:messageSpecial(ID.text.TIME_ELAPSED, vanaHour, earthMin, earthSec)
    end
end

-- Clear race records on server start
xi.chocoboGame.clearRecord = function(zone)
    local startingCity = zone:getID()

    for destination, _ in pairs(raceData[startingCity]) do
        SetServerVariable('[ChocoGame][RecordHolder]'..startingCity..'+'..destination, 0)
        SetServerVariable('[ChocoGame][RecordTime]'..startingCity..'+'..destination, 0)
    end
end
