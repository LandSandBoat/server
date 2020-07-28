-----------------------------------
-- Area: Bastok Mines
--  NPC: Christina
-- Type: Special Event Coordinator
-- !pos 23.703 -1 -86.034 234
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(32690)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
