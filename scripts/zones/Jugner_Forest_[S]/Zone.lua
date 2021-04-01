-----------------------------------
--
-- Zone: Jugner_Forest_[S] (82)
--
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest_[S]/IDs")
require("scripts/globals/chocobo")
require("scripts/globals/quests")
require("scripts/globals/helm")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    xi.helm.initZone(zone, xi.helm.type.LOGGING)
    xi.chocobo.initZone(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(621.865, -6.665, 300.264, 149)
    end

    if player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.CLAWS_OF_THE_GRIFFON) == QUEST_ACCEPTED and player:getCharVar("ClawsOfGriffonProg") == 0 then
        cs = 200
    elseif player:getCharVar("roadToDivadomCS") == 1 then
        cs = 105
    end

    return cs

end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 200 then
        player:setCharVar("ClawsOfGriffonProg", 1)
    elseif csid == 105 then
        player:setCharVar("roadToDivadomCS", 2)
    end
end

return zone_object
