-----------------------------------
-- Zone: Buburimu_Peninsula (118)
-----------------------------------
local ID = zones[xi.zone.BUBURIMU_PENINSULA]
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/missions/amk/helpers')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    local hour = VanadielHour()

    if hour >= 6 and hour < 16 then
        GetMobByID(ID.mob.BACKOO):setRespawnTime(1)
    end

    xi.conquest.setRegionalConquestOverseers(zone:getRegionID())

    xi.helm.initZone(zone, xi.helmType.LOGGING)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-276.529, 16.403, -324.519, 14)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 3
    end

    -- AMK06/AMK07
    if xi.settings.main.ENABLE_AMK == 1 then
        xi.amk.helpers.tryRandomlyPlaceDiggingLocation(player)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
    xi.chocoboGame.handleMessage(player)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onGameHour = function(zone)
    local hour = VanadielHour()
    local nmBackoo = GetMobByID(ID.mob.BACKOO)

    if nmBackoo then
        if hour == 6 then -- backoo time-of-day pop condition open
            DisallowRespawn(ID.mob.BACKOO, false)
            if nmBackoo:getRespawnTime() == 0 then
                nmBackoo:setRespawnTime(1)
            end
        elseif hour == 16 then -- backoo despawns
            DisallowRespawn(ID.mob.BACKOO, true)
            if nmBackoo:isSpawned() then
                nmBackoo:spawn(1)
            end
        end
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    if csid == 3 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
