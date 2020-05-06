-----------------------------------
-- Area: Upper Delkfutt's Tower
--  NPC: ???
-- Notes: Teleports you to the 10th floor.
-- !pos 261 19 20 158
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(17)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
