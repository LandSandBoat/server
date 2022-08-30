-----------------------------------
-- Zone: Sealions_Den (32)
-----------------------------------
local ID = require('scripts/zones/Sealions_Den/IDs')
require('scripts/globals/conquest')
require('scripts/globals/quests')
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(600.101, 130.355, 797.612, 50)
    end

    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) == QUEST_ACCEPTED and
        player:getCharVar('ApocalypseNigh') == 1
    then
        cs = 29
    end

    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 29 then
        player:setCharVar('ApocalypseNigh', 2)
    end
end

return zone_object
