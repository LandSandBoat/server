-----------------------------------
-- Area: Port Bastok
--  NPC: Flaco
-- Fame Checker
-- !zone 236
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(210 + player:getFameLevel(BASTOK))
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
