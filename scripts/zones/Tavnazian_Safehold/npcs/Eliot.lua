-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Eliot
-- !pos -103 -26 -49 26
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:hasCompletedMission(tpz.mission.log_id.COP, tpz.mission.id.cop.DARKNESS_NAMED)) then
        player:sendMenu(3)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
