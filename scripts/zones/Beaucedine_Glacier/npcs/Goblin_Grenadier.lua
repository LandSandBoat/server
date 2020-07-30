-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Goblin Grenadier
-- Type: Mission NPC
-- !pos -26.283 -60.49 -76.640 111
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(509)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
