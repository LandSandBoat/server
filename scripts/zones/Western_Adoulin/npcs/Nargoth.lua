-----------------------------------
-- Area: Western Adoulin
--  NPC: Nargoht
-- Type: Standard NPC
-- !pos 25 0 117 256
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Standard dialogue
    player:startEvent(557)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
