-----------------------------------
-- Zone: East_Sarutabaruta (116)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- A Chocobo Riding Game finish line
    zone:registerCylindricalTriggerArea(1, -119.92, -520.08, 10)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-125, -3, -519, 4)
    end

    if
        player:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.BURGEONING_DREAD and
        prevZone == xi.zone.WINDURST_WOODS and
        not player:hasStatusEffect(xi.effect.MOUNTED)
    then
        cs = 71
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
    local triggerAreaID = triggerArea:getTriggerAreaID()

    if triggerAreaID == 1 and player:hasStatusEffect(xi.effect.MOUNTED) then
        xi.chocoboGame.onTriggerAreaEnter(player)
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    if csid == 71 then
        player:setCharVar('ASA_Status', option)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 71 then
        player:completeMission(xi.mission.log_id.ASA, xi.mission.id.asa.BURGEONING_DREAD)
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD)
    end

    xi.chocoboGame.onEventFinish(player, csid)
end

return zoneObject
