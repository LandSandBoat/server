-----------------------------------
-- Area: Southern San dOria
--  NPC: Maleme
-- Type: Weather Reporter
-- Involved in Quest: Flyers for Regine
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(632, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
