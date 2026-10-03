-----------------------------------
-- Harvest Festival (2005 and 2007)
-- https://www.playonline.com/ff11/polnews/news5795.shtml
-- https://www.playonline.com/pcd/topics/ff11us/detail/2413/detail.html
-----------------------------------
xi = xi or {}
xi.events = xi.events or {}
xi.events.harvestFestival = xi.events.harvestFestival or {}

local event = SeasonalEvent:new('harvest_festival')
local data = require('scripts/events/harvest_festival_data')
local games = require('scripts/events/harvest_festival_games')
local lilies = require('scripts/events/harvest_festival_lilies')
local zoneStates = {}
local nextCheck = 0

xi.events.harvestFestival.games = games
xi.events.harvestFestival.lilies = lilies

xi.events.harvestFestival.isEnabled = function()
    local edition = xi.settings.main.HALLOWEEN_YEAR
    if edition ~= 2005 and edition ~= 2007 then
        return false
    end

    if xi.settings.main.HALLOWEEN_YEAR_ROUND ~= 0 then
        return true
    end

    local month = JstMonth()
    local day   = JstDayOfTheMonth()
    local hour  = JstHour()
    if month == 11 then
        return day == 1 and hour < 17
    end

    if month ~= 10 then
        return false
    end

    if edition == 2005 then
        return day > 21 or day == 21 and hour >= 9
    end

    return day > 18 or day == 18 and hour >= 17
end

xi.events.harvestFestival.onTrade = function(player, trade, npc)
    if not xi.events.harvestFestival.isEnabled() then
        return false
    end

    local zoneId = player:getZoneID()
    local zoneData = data[zoneId]
    local participant = zoneData and zoneData.npcs[npc:getName()]
    local treatId = trade:getItemId()
    local firstEdition = data.treats[treatId]
    if
        not participant or
        not firstEdition or
        firstEdition > xi.settings.main.HALLOWEEN_YEAR or
        not npcUtil.tradeMatches(trade, { { treatId, 1 } })
    then
        return false
    end

    local ID = zones[zoneId]
    local rewards = {}
    local equipment =
    {
        { xi.item.PUMPKIN_HEAD,    xi.item.HORROR_HEAD,    xi.slot.HEAD },
        { xi.item.PUMPKIN_HEAD_II, xi.item.HORROR_HEAD_II, xi.slot.HEAD },
        { xi.item.TRICK_STAFF,     xi.item.TREAT_STAFF,    xi.slot.MAIN },
        { xi.item.TRICK_STAFF_II,  xi.item.TREAT_STAFF_II, xi.slot.MAIN },
    }

    for _, pair in ipairs(equipment) do
        if not player:hasItem(pair[1]) then
            table.insert(rewards, pair[1])
        elseif player:getEquipID(pair[3]) == pair[1] and not player:hasItem(pair[2]) then
            table.insert(rewards, pair[2])
        end
    end

    -- The 5% reward chance is an estimate.
    if #rewards > 0 and math.randomInt(1, 100) <= 5 then
        if npcUtil.giveItem(player, rewards[math.randomInt(1, #rewards)]) then
            player:messageSpecial(ID.text.HERE_TAKE_THIS)
            player:tradeComplete()
        end

        return true
    end

    local variable = '[HarvestFestival]Sweet_' .. treatId
    if
        player:getCharVar(variable) ~= 0 or
        not player:canUseMisc(xi.zoneMisc.COSTUME)
    then
        player:messageSpecial(ID.text.THANK_YOU)
        player:tradeComplete()
        return true
    end

    local costume
    if
        not participant.goblinYear or
        participant.goblinYear <= xi.settings.main.HALLOWEEN_YEAR
    then
        costume = games.getGoblinCostume(player, participant.goblinNation)
    end

    if not costume then
        costume = participant.costume
        if type(costume) == 'table' then
            costume = math.randomInt(costume[1], costume[2])
        end
    end

    -- Model IDs don't measure strength.
    player:delStatusEffect(xi.effect.COSTUME)
    if player:addStatusEffect(xi.effect.COSTUME, { power = costume, duration = 324, origin = player }) then
        player:setCharVar(variable, 1, getVanaMidnight())
        player:messageSpecial(ID.text.THANK_YOU_TREAT)
        player:tradeComplete()
    end

    return true
end

xi.events.harvestFestival.onRoamerTrigger = function(player, npc)
    if xi.events.harvestFestival.isEnabled() then
        player:showText(npc, zones[player:getZoneID()].text.TRICK_OR_TREAT)
    end
end

xi.events.harvestFestival.onRoamerPathComplete = function(npc)
    if not xi.events.harvestFestival.isEnabled() then
        return
    end

    local zoneData = data[npc:getZoneID()]
    local participant = zoneData and zoneData.npcs[npc:getName()]
    if not participant or not participant.path then
        return
    end

    -- Wait for the old path to clear.
    npc:timer(100, function(npcArg)
        if not xi.events.harvestFestival.isEnabled() or npcArg:isFollowingPath() then
            return
        end

        local index = npcArg:getLocalVar('[HarvestFestival]Path') % #participant.path + 1
        local point = participant.path[index]
        npcArg:setLocalVar('[HarvestFestival]Path', index)
        npcArg:pathTo(point.x, point.y, point.z, xi.path.flag.SCRIPT)
    end)
end

local function setZoneEdition(zone, edition)
    local zoneId = zone:getID()
    local state = zoneStates[zoneId]
    if not state or state.edition == edition then
        return
    end

    if state.edition == 2007 then
        lilies.cleanupZone(zone)
    end

    for npcId, original in pairs(state.originals) do
        local npc = GetNPCByID(npcId)
        if npc then
            if original.standard then
                npc:setLook({ model = original.model })
            else
                npc:setLook({ face = original.model % 256, race = math.floor(original.model / 256) })
            end

            if original.roamer then
                npc:clearPath()
                npc:clearPath(true)
                npc:setStatus(original.status)
                npc:setLocalVar('[HarvestFestival]Path', 0)
            end
        end
    end

    state.edition = edition
    if edition ~= 0 then
        local zoneData = data[zoneId]
        if zoneData then
            for name, participant in pairs(zoneData.npcs) do
                local npc = zone:queryEntitiesByName(name)[1]
                if npc then
                    npc:setLook({ model = participant.model })
                    if participant.path then
                        local point = participant.path[1]
                        npc:setPos(point.x, point.y, point.z)
                        npc:setStatus(xi.status.NORMAL)
                        npc:initNpcAi()
                        npc:continuePath()
                        npc:setLocalVar('[HarvestFestival]Path', 1)
                        xi.events.harvestFestival.onRoamerPathComplete(npc)
                    end
                end
            end
        end
    end

    games.setZoneEnabled(zone, edition ~= 0)
    if edition == 2007 then
        lilies.initializeZone(zone)
    end
end

xi.events.harvestFestival.initializeZone = function(zone)
    local zoneId = zone:getID()
    if zoneStates[zoneId] then
        return
    end

    local state = { edition = 0, originals = {} }
    zoneStates[zoneId] = state
    local zoneData = data[zoneId]
    if zoneData then
        for name, participant in pairs(zoneData.npcs) do
            local npc = zone:queryEntitiesByName(name)[1]
            if npc then
                state.originals[npc:getID()] =
                {
                    model = npc:getModelId(),
                    standard = participant.standard or participant.path ~= nil,
                    roamer = participant.path ~= nil,
                    status = npc:getStatus(),
                }
            end
        end
    end

    games.initializeZone(zone)
    if xi.events.harvestFestival.isEnabled() then
        setZoneEdition(zone, xi.settings.main.HALLOWEEN_YEAR)
    end
end

xi.events.harvestFestival.update = function()
    local edition = 0
    if xi.events.harvestFestival.isEnabled() then
        edition = xi.settings.main.HALLOWEEN_YEAR
    end

    for zoneId, _ in pairs(zoneStates) do
        local zone = GetZone(zoneId)
        if zone then
            setZoneEdition(zone, edition)
        end
    end
end

xi.events.harvestFestival.onTimeServerTick = function()
    local now = GetSystemTime()
    if now < nextCheck then
        return
    end

    nextCheck = now + 60
    xi.events.harvestFestival.update()
end

event:setEnableCheck(xi.events.harvestFestival.isEnabled)
event:setStartFunction(xi.events.harvestFestival.update)
event:setEndFunction(xi.events.harvestFestival.update)

return event
