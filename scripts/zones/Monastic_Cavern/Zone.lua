-----------------------------------
-- Zone: Monastic Cavern (150)
-----------------------------------
local ID = require('scripts/zones/Monastic_Cavern/IDs')
require('scripts/globals/conquest')
require('scripts/globals/treasure')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- NM Persistence
    local timeOfDeath = GetServerVariable("[POP]Overlord_Bakgodek")
    local popNow      = GetServerVariable("[POPNUM]Overlord_Bakgodek") == 4 -- Set as server var in case HQ is up and server crashes

    if os.time() > timeOfDeath and popNow then
        xi.mob.nmTODPersistCache(zone, ID.mob.OVERLORD_BAKGODEK)
    else
        xi.mob.nmTODPersistCache(zone, ID.mob.ORCISH_OVERLORD)
    end

    xi.treasure.initZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(261.354, -8.792, 23.124, 175)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
