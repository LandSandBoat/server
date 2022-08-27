-----------------------------------
-- Zone: Arrapago_Reef (54)
-----------------------------------
local ID = require('scripts/zones/Arrapago_Reef/IDs')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    zone:registerRegion(1, -462, -4, -420, -455, -1, -392) -- approach the Cutter
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-456, -3, -405, 64)
    end

    if
        prevZone == xi.zone.THE_ASHU_TALIF and
        player:getCharVar("AgainstAllOdds") == 3
    then
        cs = 238
    elseif prevZone == xi.zone.ILRUSI_ATOLL then
        player:setPos(26, -7, 606, 222)
    end

    return cs
end

zone_object.afterZoneIn = function(player)
    player:entityVisualPacket("1pb1")
    player:entityVisualPacket("2pb1")
end

zone_object.onRegionEnter = function(player, region)
    if
        player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AGAINST_ALL_ODDS) == QUEST_ACCEPTED and
        player:getCharVar("AgainstAllOdds") == 1
    then
        player:startEvent(237)
    end
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 108 then -- enter instance: illrusi atoll
        player:setPos(0, 0, 0, 0, 55)
    elseif csid == 222 then -- Enter instance: Black coffin
        player:setPos(0, 0, 0, 0, 60)
    elseif csid == 237 then
        player:startEvent(240)
    elseif csid == 238 then
        npcUtil.completeQuest(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AGAINST_ALL_ODDS, { item=15266, var="AgainstAllOdds"})
    elseif csid == 240 then
        player:setCharVar("AgainstAllOdds", 2)
    end
end

return zone_object
