-----------------------------------
-- Zone: Fort_Ghelsba (141)
-----------------------------------
local ID = require('scripts/zones/Fort_Ghelsba/IDs')
require('scripts/globals/conquest')
require('scripts/globals/treasure')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- NM Persistence
    xi.mob.nmTODPersistCache(zone, ID.mob.ORCISH_PANZER)

    if xi.settings.main.ENABLE_WOTG == 1 then
        xi.mob.nmTODPersistCache(zone, ID.mob.KEGPAUNCH_DOSHGNOSH)
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
        player:setPos(-159, -19, 19, 3)
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
