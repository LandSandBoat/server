-----------------------------------
-- Zone: Oldton_Movalpolos (11)
-----------------------------------
local ID = require('scripts/zones/Oldton_Movalpolos/IDs')
require('scripts/globals/conquest')
require('scripts/globals/missions')
require('scripts/globals/treasure')
require('scripts/globals/helm')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.conq.setRegionalConquestOverseers(zone:getRegionID())
    xi.treasure.initZone(zone)
    xi.helm.initZone(zone, xi.helm.type.MINING)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-286, 0, -99, 253)
    end

    if
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.DAWN and
        player:getCharVar("PromathiaStatus") == 3 and
        player:getCharVar("Promathia_kill_day") < os.time() and
        player:getCharVar("COP_jabbos_story") == 0
    then
        cs = 57
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 57 then
        player:setCharVar("COP_jabbos_story", 1)
    end
end

return zoneObject
