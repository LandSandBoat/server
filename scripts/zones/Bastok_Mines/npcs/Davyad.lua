-----------------------------------
-- Area: Bastok Mines
--  NPC: Davyad
-- Involved in Mission: Bastok 3-2
-- !pos 83 0 30 234
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.TO_THE_FORSAKEN_MINES) then
        player:startEvent(54)
    else
        player:startEvent(53)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
