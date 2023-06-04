-----------------------------------
-- Zone: Southern_San_dOria (230)
-----------------------------------
local ID = require('scripts/zones/Southern_San_dOria/IDs')
require('scripts/globals/events/harvest_festivals')
require('scripts/quests/flyers_for_regine')
require('scripts/globals/conquest')
require('scripts/globals/cutscenes')
require('scripts/globals/chocobo')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerTriggerArea(1, -292, -10, 90 , -258, 10, 105)
    quests.ffr.initZone(zone) -- register trigger areas 2 through 6
    applyHalloweenNpcCostumes(zone:getID())
    xi.chocobo.initZone(zone)
    xi.conquest.toggleRegionalNPCs(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    -- MOG HOUSE EXIT
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(161, -2, 161, 94)
    end
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local triggerAreaID = triggerArea:GetTriggerAreaID()

    if
        triggerAreaID == 1 and
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.DAWN and
        player:getCharVar("COP_louverance_story") == 2
    then
        player:startEvent(758)
    end

    quests.ffr.onTriggerAreaEnter(player, triggerArea) -- player approaching Flyers for Regine NPCs
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 758 then
        player:setCharVar("COP_louverance_story", 3)
    end
end

return zoneObject
