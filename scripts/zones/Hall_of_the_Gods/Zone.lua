-----------------------------------
-- Zone: Hall_of_the_Gods (251)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-0.011, -1.848, -176.133, 192)
    elseif
        player:getCurrentMission(xi.mission.log_id.ACP) == xi.mission.id.acp.REMEMBER_ME_IN_YOUR_DREAMS and
        prevZone == xi.zone.ROMAEVE
    then
        cs = 5
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 5 then
        player:completeMission(xi.mission.log_id.ACP, xi.mission.id.acp.REMEMBER_ME_IN_YOUR_DREAMS)
        player:addMission(xi.mission.log_id.ACP, xi.mission.id.acp.BORN_OF_HER_NIGHTMARES)
    end
end

return zoneObject
