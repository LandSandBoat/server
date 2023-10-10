-----------------------------------
-- Zone: Qulun_Dome (148)
-----------------------------------
local ID = require('scripts/zones/Qulun_Dome/IDs')
require('scripts/globals/conquest')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- NM Persistence
    local timeOfDeath = GetServerVariable("[POP]Za_Dha_Adamantking")
    local popNow      = GetServerVariable("[POPNUM]Za_Dha_Adamantking") == 4

    if os.time() > timeOfDeath and popNow then
        xi.mob.nmTODPersistCache(zone, ID.mob.ZADHA_ADAMANTKING)
    else
        xi.mob.nmTODPersistCache(zone, ID.mob.DIAMOND_QUADAV)
    end
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(337.901, 38.091, 20.087, 129)
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
