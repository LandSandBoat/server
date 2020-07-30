-----------------------------------
-- Area: Bastok Mines
--  NPC: Gorvik
-- Type: Past Event Watcher
-- !pos 21.033 -1 -98.486 234
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(185)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
