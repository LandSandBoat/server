-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Senvaleget
-- !pos -103 -26 -49 26
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:hasCompletedMission(COP, tpz.mission.id.cop.DARKNESS_NAMED)) then
        player:sendMenu(3)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
