-----------------------------------
-- Area: Kazham
--  NPC: Vanono
-- Type: Standard NPC
-- !pos -23.140 -5 -23.101 250
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getMissionStatus(player:getNation()) == 3) then
        player:startEvent(264)
    elseif (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getMissionStatus(player:getNation()) > 3) then
        player:startEvent(268)
    else
        player:startEvent(262)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 264) then
        player:setMissionStatus(player:getNation(), 4)
    end

end

return entity
