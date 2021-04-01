-----------------------------------
-- Area: Kazham
--   NPC: Vanono
-- Type: Standard NPC
-- !pos -23.140 -5 -23.101 250
-----------------------------------
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getCharVar("MissionStatus") == 3) then
        player:startEvent(264)
    elseif (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getCharVar("MissionStatus") > 3) then
        player:startEvent(268)
    else
        player:startEvent(262)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 264) then
        player:setCharVar("MissionStatus", 4)
    end

end

return entity
