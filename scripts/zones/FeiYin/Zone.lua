-----------------------------------
-- Zone: FeiYin (204)
-----------------------------------
local ID = require('scripts/zones/FeiYin/IDs')
require('scripts/globals/conquest')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/treasure')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- NM Persistence
    xi.mob.nmTODPersistCache(zone, ID.mob.CAPRICIOUS_CASSIE)

    xi.treasure.initZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(99.98, -1.768, 275.993, 70)
    end

    if player:getCurrentMission(xi.mission.log_id.ACP) == xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_I then
        cs = 29
    elseif
        prevZone == xi.zone.BEAUCEDINE_GLACIER and
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.PIEUJE_S_DECISION) == QUEST_ACCEPTED and
        player:getCharVar("pieujesDecisionCS") == 0
    then
        cs = 19 -- WHM AF
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 19 then
        player:setCharVar("pieujesDecisionCS", 1)
    elseif csid == 29 then
        player:completeMission(xi.mission.log_id.ACP, xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_I)
        player:addMission(xi.mission.log_id.ACP, xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_II)
    end
end

return zoneObject
